# DataFrame ↔ ACSet conversion.
#
# Implements the functor: DataFrame world → Categorical world
# This is the "instance" construction: I : Schema → Set

using Catlab: add_parts!, set_subpart!

"""
    Outbreaks.LineListACSet(df::DataFrame; onset, location=nothing, age=nothing, outcome=nothing)

Convert a DataFrame line list into a categorical ACSet representation.

The resulting object wraps a Catlab ACSet and supports categorical operations
like aggregation (`↓`), decategorification (`♯`), and fiber inspection.

# Arguments
- `df`: A DataFrame containing individual case records
- `onset`: Column name (Symbol) for the date of onset/event
- `location`: Optional column for geographic stratification
- `age`: Optional column for age
- `outcome`: Optional column for outcome status

# Example
```julia
using Outbreaks, Catlab
df = measles_hagelloch_1861()
ll = LineListACSet(df, onset=:date_of_prodrome, location=:class)
```
"""
function Outbreaks.LineListACSet(df::DataFrame; onset::Symbol,
                                 location::Union{Symbol,Nothing}=nothing,
                                 age::Union{Symbol,Nothing}=nothing,
                                 outcome::Union{Symbol,Nothing}=nothing)
    # Validate columns exist
    onset ∈ propertynames(df) || error("Column :$onset not found in DataFrame")
    for col in (location, age, outcome)
        isnothing(col) || col ∈ propertynames(df) || error("Column :$col not found in DataFrame")
    end
    partial_optional = any(!isnothing, (location, age, outcome)) &&
        !(isnothing(age) && isnothing(outcome)) &&
        any(isnothing, (location, age, outcome))
    partial_optional && error(
        "LineListACSet currently supports optional attributes as either " *
        "`location` only or all of `location`, `age`, and `outcome`."
    )

    # Filter to rows with non-missing onset
    valid = .!ismissing.(df[!, onset])
    dropped = count(!, valid)
    dropped == 0 || @warn "Dropped $dropped rows with missing onset dates" onset
    df_clean = df[valid, :]
    n = nrow(df_clean)

    # Build appropriate ACSet based on available columns
    strata_cols = Symbol[]

    if !isnothing(location) && !isnothing(age) && !isnothing(outcome)
        # Full schema
        acset = LineListData{Date, Any, Any, Any}()
        add_parts!(acset, :Case, n)
        set_subpart!(acset, :onset, collect(df_clean[!, onset]))
        set_subpart!(acset, :location, collect(df_clean[!, location]))
        set_subpart!(acset, :age, collect(df_clean[!, age]))
        set_subpart!(acset, :outcome, collect(df_clean[!, outcome]))
        strata_cols = filter(!isnothing, [location, age, outcome]) |> collect
    elseif !isnothing(location)
        # Stratified schema
        acset = StratifiedListData{Date, Any}()
        add_parts!(acset, :Case, n)
        set_subpart!(acset, :onset, collect(df_clean[!, onset]))
        set_subpart!(acset, :stratum, collect(df_clean[!, location]))
        strata_cols = [location]
    else
        # Minimal onset-only schema
        acset = OnsetListData{Date}()
        add_parts!(acset, :Case, n)
        set_subpart!(acset, :onset, collect(df_clean[!, onset]))
    end

    return LineListACSetWrapper(acset, df_clean, onset, strata_cols)
end

"""
    Outbreaks.EpiCurveACSet(df::DataFrame; time, count)

Convert an aggregated epidemic curve DataFrame into a categorical ACSet.

# Example
```julia
using Outbreaks, Catlab
curve = EpiCurveACSet(epi_df, time=:week, count=:cases)
```
"""
function Outbreaks.EpiCurveACSet(df::DataFrame; time::Symbol, count::Symbol)
    time ∈ propertynames(df) || error("Column :$time not found")
    count ∈ propertynames(df) || error("Column :$count not found")

    n = nrow(df)
    acset = EpiCurveData{eltype(df[!, time]), Int}()
    add_parts!(acset, :TimeBin, n)
    set_subpart!(acset, :bin_label, collect(df[!, time]))
    set_subpart!(acset, :count, collect(Int.(df[!, count])))

    return acset
end
