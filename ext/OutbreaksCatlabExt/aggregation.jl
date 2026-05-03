# Aggregation: the categorical core.
#
# Implements the three morphisms of aggregation:
#   1. Onset assignment: Case → Day  (attribute morphism in the ACSet)
#   2. Time binning: Day → Bin       (surjective FinFunction)
#   3. Decategorification: |fiber|   (cardinality of each fiber)
#
# The key insight: information loss occurs at step 3 (decategorification),
# NOT at step 2 (binning). The BucketedCases intermediate preserves the
# full fiber structure so multi-scale aggregation remains functorial.

using Catlab: FinSet, FinFunction, preimage
using Dates: Date

_sort_token(x::Date) = (0, Dates.value(x))
_sort_token(x::Real) = (1, Float64(x))
_sort_token(x::AbstractString) = (2, String(x))
_sort_token(::Missing) = (3, "")
_sort_token(x) = (4, string(x))
_bin_sort_key(x::Tuple) = tuple((_sort_token(v) for v in x)...)
_bin_sort_key(x) = _sort_token(x)
_sorted_unique_bins(values) = sort(collect(unique(values)); by=_bin_sort_key)

"""
    Outbreaks.aggregate(ll::LineListACSetWrapper, scale::TemporalScale; by=nothing)

Aggregate a line list by temporal scale, preserving categorical fiber structure.

This implements the composition `bin ∘ onset : Case → TimeBin` as a FinFunction,
then organizes cases into fibers without counting (preserving individual identity).

# Arguments
- `ll`: A LineListACSetWrapper from `LineListACSet()`
- `scale`: Temporal resolution (Day, Week, Month, Year)
- `by`: Optional additional stratification column(s)

# Returns
A `BucketedCases` with the fiber structure preserved.

# Example
```julia
ll = LineListACSet(measles_hagelloch_1861(), onset=:date_of_prodrome)
bucketed = aggregate(ll, Week)
# Or with stratification:
bucketed = aggregate(ll, Week, by=:class)
```
"""
function Outbreaks.aggregate(ll::LineListACSetWrapper, scale::TemporalScale;
                             by::Union{Symbol,Nothing}=nothing)
    dates = ll.df[!, ll.onset_col]
    n = length(dates)

    if isnothing(by)
        # Pure temporal aggregation
        binned = scale.bin_func.(dates)
        unique_bins = _sorted_unique_bins(binned)
        bin_index = Dict(b => i for (i, b) in enumerate(unique_bins))
        bin_vec = [bin_index[b] for b in binned]

        bin_map = FinFunction(bin_vec, FinSet(n), FinSet(length(unique_bins)))
        return BucketedCases(bin_map, unique_bins, ll.df,
                             Union{TemporalScale,CategoricalScale}[scale])
    else
        # Stratified: temporal ⊗ categorical
        by ∈ propertynames(ll.df) || error("Column :$by not found")
        binned_time = scale.bin_func.(dates)
        strata = ll.df[!, by]
        # Product bins: (time_bin, stratum)
        product_bins = collect(zip(binned_time, strata))
        unique_bins = _sorted_unique_bins(product_bins)
        bin_index = Dict(b => i for (i, b) in enumerate(unique_bins))
        bin_vec = [bin_index[b] for b in product_bins]

        bin_map = FinFunction(bin_vec, FinSet(n), FinSet(length(unique_bins)))
        scales = Union{TemporalScale,CategoricalScale}[scale, CategoricalScale(by)]
        return BucketedCases(bin_map, unique_bins, ll.df, scales)
    end
end

# Aggregation with ProductScale
function Outbreaks.aggregate(ll::LineListACSetWrapper, ps::ProductScale)
    dates = ll.df[!, ll.onset_col]
    n = length(dates)

    # Build product bin from all scales
    components = map(ps.scales) do s
        if s isa TemporalScale
            s.bin_func.(dates)
        else
            ll.df[!, s.col]
        end
    end

    product_bins = collect(zip(components...))
    unique_bins = _sorted_unique_bins(product_bins)
    bin_index = Dict(b => i for (i, b) in enumerate(unique_bins))
    bin_vec = [bin_index[b] for b in product_bins]

    bin_map = FinFunction(bin_vec, FinSet(n), FinSet(length(unique_bins)))
    return BucketedCases(bin_map, unique_bins, ll.df, ps.scales)
end

"""
    Outbreaks.decategorify(b::BucketedCases) -> DataFrame

Apply cardinality to each fiber, collapsing categorical structure to counts.

This is the information-destroying step: after decategorification, we know
*how many* cases per bin but not *which* cases. Two different line lists
with identical counts are indistinguishable.

# Returns
A DataFrame with columns for each scale dimension plus a `count` column.

# Example
```julia
bucketed = ll ↓ Week
counts = decategorify(bucketed)  # DataFrame with :week, :count
```
"""
function Outbreaks.decategorify(b::BucketedCases)
    n_bins = length(b.bins)
    # Count fibers using the FinFunction
    counts = zeros(Int, n_bins)
    bin_vec = collect(b.bin_map)
    for idx in bin_vec
        counts[idx] += 1
    end

    # Build result DataFrame
    if length(b.scales) == 1 && b.scales[1] isa TemporalScale
        return DataFrame(; b.scales[1].name => b.bins, count=counts)
    elseif length(b.scales) == 1 && b.scales[1] isa CategoricalScale
        return DataFrame(; b.scales[1].col => b.bins, count=counts)
    else
        # Product scale: unzip tuples
        cols = Pair{Symbol,Vector}[]
        for (i, s) in enumerate(b.scales)
            col_name = s isa TemporalScale ? s.name : s.col
            vals = [bin[i] for bin in b.bins]
            push!(cols, col_name => vals)
        end
        push!(cols, :count => counts)
        return DataFrame(cols...)
    end
end

"""
    Outbreaks.fibers(b::BucketedCases) -> Vector{DataFrame}

Return the categorical fibers: for each bucket, the DataFrame of cases it contains.

This preserves full individual-level information. The fibers are the preimages
of the binning FinFunction — the left Kan extension before decategorification.

# Example
```julia
bucketed = ll ↓ Week
week_fibers = fibers(bucketed)
# week_fibers[1] is all cases in the first week
```
"""
function Outbreaks.fibers(b::BucketedCases)
    n_bins = length(b.bins)
    bin_vec = collect(b.bin_map)
    result = Vector{DataFrame}(undef, n_bins)
    for i in 1:n_bins
        case_indices = findall(==(i), bin_vec)
        result[i] = b.cases[case_indices, :]
    end
    return result
end

"""
    Outbreaks.coarsen(b::BucketedCases, new_scale::TemporalScale) -> BucketedCases

Refine aggregation to a coarser temporal scale via functorial composition.

Given `bin₁: Case → Week` and `bin₂: Week → Month`, the composite
`bin₂ ∘ bin₁: Case → Month` is computed by composing FinFunctions.
This avoids re-accessing the raw data.

# Example
```julia
weekly = ll ↓ Week
monthly = coarsen(weekly, Month)  # functorial: Case → Week → Month
```
"""
function Outbreaks.coarsen(b::BucketedCases, new_scale::TemporalScale)
    # The existing bins must be temporal (dates) for coarsening to make sense
    t_idx = findfirst(s -> s isa TemporalScale, b.scales)
    isnothing(t_idx) && error("Cannot coarsen: no temporal scale in current bucketing")

    # Apply new binning to existing bin labels
    old_temporal_bins = if length(b.scales) == 1
        b.bins
    else
        # Extract temporal component from product bins
        [bin[t_idx] for bin in b.bins]
    end

    new_temporal_bins = new_scale.bin_func.(old_temporal_bins)
    new_binned = if length(b.scales) == 1
        new_temporal_bins
    else
        [ntuple(j -> j == t_idx ? new_temporal_bins[i] : b.bins[i][j], length(b.scales))
         for i in eachindex(b.bins)]
    end
    unique_new_bins = _sorted_unique_bins(new_binned)
    new_bin_index = Dict(nb => i for (i, nb) in enumerate(unique_new_bins))

    # Compose: old_bin_map composed with coarsening map
    # coarsen_map: OldBins → NewBins
    coarsen_vec = [new_bin_index[new_binned[i]] for i in 1:length(new_binned)]
    coarsen_map = FinFunction(coarsen_vec, FinSet(length(new_binned)), FinSet(length(unique_new_bins)))

    # Compose FinFunctions: Case → OldBin → NewBin
    old_vec = collect(b.bin_map)
    composed_vec = [coarsen_vec[old_vec[i]] for i in 1:length(old_vec)]
    composed_map = FinFunction(composed_vec, FinSet(length(old_vec)), FinSet(length(unique_new_bins)))

    # Update scales
    new_scales = copy(b.scales)
    new_scales[t_idx] = new_scale

    return BucketedCases(composed_map, unique_new_bins, b.cases, new_scales)
end
