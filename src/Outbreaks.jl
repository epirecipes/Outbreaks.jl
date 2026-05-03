"""
    Outbreaks

A Julia package providing curated disease outbreak datasets for epidemiological
research and teaching. This is a Julia port of the R
[outbreaks](https://CRAN.R-project.org/package=outbreaks) package.

Each dataset is accessed by calling its corresponding function, which returns a
`DataFrame` (or a `NamedTuple` of `DataFrame`s for multi-table datasets).

# Quick start

```julia
using Outbreaks, DataFrames
df = measles_hagelloch_1861()
first(df, 5)
```

# Dataset categories

- **Line lists**: Individual-level case data (e.g. [`ebola_sierraleone_2014`](@ref), [`fluH7N9_china_2013`](@ref), [`measles_hagelloch_1861`](@ref))
- **Aggregated time series**: Case counts over time (e.g. [`influenza_england_1978_school`](@ref), [`zika_girardot_2015`](@ref))
- **Multi-table**: Linked linelist + contacts or DNA data (e.g. [`ebola_sim`](@ref), [`mers_korea_2015`](@ref), [`rabies_car_2003`](@ref))
"""
module Outbreaks

using CSV
using DataFrames
using Dates

function _load(filename::String)::DataFrame
    path = joinpath(@__DIR__, "..", "data", filename)
    return DataFrame(CSV.File(path))
end

# --- Simple datasets ---

"""
    covid19_england_nhscalls_2020() -> DataFrame

Aggregated NHS Pathways (111/999) call data from England during the COVID-19 pandemic in 2020.
Calls are broken down by date, sex, age group, and Clinical Commissioning Group (CCG).

**253,670 rows** × 11 columns:
`site_type`, `date`, `sex`, `age`, `ccg_code`, `ccg_name`, `count`,
`postcode`, `nhs_region`, `day`, `weekday`

**Source:** NHS Digital; cleaned by Quentin Leclerc.

# Example

```julia
df = covid19_england_nhscalls_2020()
describe(df)
```
"""
covid19_england_nhscalls_2020() = _load("covid19_england_nhscalls_2020.csv")

"""
    dengue_fais_2011() -> DataFrame

Weekly dengue fever case counts from an outbreak on Fais Island, Federated States
of Micronesia, 2011. The island population was approximately 294 at the time.

**57 rows** × 3 columns:
- `onset_date::Date` — Start date of the reporting week
- `nr::Int` — Week number
- `value::Int` — Number of cases reported that week

**Source:** Kool JL, Weinstein RA (2011).

# Example

```julia
df = dengue_fais_2011()
first(df, 6)
```
"""
dengue_fais_2011() = _load("dengue_fais_2011.csv")

"""
    dengue_yap_2011() -> DataFrame

Weekly dengue fever case counts from an outbreak on the Yap Main Islands,
Federated States of Micronesia, 2011. Dengue serotype 2 caused 978 cases
among 7,391 residents (13% attack rate).

**185 rows** × 3 columns:
- `onset_date::Date` — Start date of the reporting week
- `nr::Int` — Week number
- `value::Int` — Number of cases reported that week

**Source:** Funk S, Kucharski AJ, Camacho A, et al. (2016). *PLOS Neglected Tropical Diseases* 10(12):e0005173.

# Example

```julia
df = dengue_yap_2011()
first(df, 6)
```
"""
dengue_yap_2011() = _load("dengue_yap_2011.csv")

"""
    ebola_kikwit_1995() -> DataFrame

Daily Ebola haemorrhagic fever data from the 1995 outbreak in Kikwit,
Democratic Republic of the Congo (then Zaire). The outbreak resulted in
316 total cases and 236 deaths (75% case fatality rate).

**192 rows** × 4 columns:
- `date::Date` — Calendar date
- `onset::Int` — Number of new case onsets
- `death::Int` — Number of deaths
- `reporting::Bool` — Whether reporting was active on that date

**Source:** Khan AS, Tshioko FK, Heymann DL, et al. (1999). *Journal of Infectious Diseases* 179(Suppl 1):S76–S86. Provided by Camacho et al. (2014).

# Example

```julia
df = ebola_kikwit_1995()
first(df, 6)
```
"""
ebola_kikwit_1995() = _load("ebola_kikwit_1995.csv")

"""
    ebola_sierraleone_2014() -> DataFrame

Individual-level case data from the 2014 Ebola outbreak in Sierra Leone,
from the WHO Patient Database. This is one of the largest line lists in
the package.

**11,903 rows** × 8 columns:
- `id` — Case identifier
- `age` — Patient age
- `sex` — Patient sex
- `status` — Case status (e.g. confirmed, probable)
- `date_of_onset::Date` — Symptom onset date
- `date_of_sample::Date` — Date sample was taken
- `district` — District name
- `chiefdom` — Chiefdom name

**Source:** WHO Patient Database, 2014.

# Example

```julia
df = ebola_sierraleone_2014()
describe(df)
```
"""
ebola_sierraleone_2014() = _load("ebola_sierraleone_2014.csv")

"""
    fluH7N9_china_2013() -> DataFrame

Individual-level case data from the influenza A H7N9 outbreak in China
starting in 2013.

**136 rows** × 8 columns:
- `case_id` — Numeric case identifier
- `date_of_onset::Date` — Date of symptom onset
- `date_of_hospitalisation::Date` — Date of hospital admission (may be missing)
- `date_of_outcome::Date` — Date of outcome (may be missing)
- `outcome` — Clinical outcome (Death, Recovery, or missing)
- `gender` — Patient gender (m/f)
- `age` — Patient age
- `province` — Province name

**Source:** WHO / Chinese CDC.

# Example

```julia
df = fluH7N9_china_2013()
first(df, 6)
```
"""
fluH7N9_china_2013() = _load("fluH7N9_china_2013.csv")

"""
    influenza_england_1978_school() -> DataFrame

Daily influenza case counts from a 1978 outbreak in a boys' boarding school
in England. This classic dataset has been widely used for fitting SIR models.

**14 rows** × 3 columns:
- `date::Date` — Calendar date
- `in_bed::Int` — Number of boys confined to bed
- `convalescent::Int` — Number of boys convalescing

**Source:** Anonymous (1978). Influenza in a boarding school. *British Medical Journal* 1:587.

# Example

```julia
df = influenza_england_1978_school()
first(df, 6)
```
"""
influenza_england_1978_school() = _load("influenza_england_1978_school.csv")

"""
    measles_hagelloch_1861() -> DataFrame

Individual-level data from a measles outbreak in the village of Hagelloch,
Germany, 1861. One of the oldest detailed epidemiological line lists, with
transmission links and spatial information.

**188 rows** × 12 columns:
- `case_ID::Int` — Case identifier
- `infector::Int` — Case ID of the infector
- `date_of_prodrome::Date` — Date of prodromal symptoms
- `date_of_rash::Date` — Date of rash onset
- `date_of_death::Date` — Date of death (missing if survived)
- `age::Int` — Patient age
- `gender` — Patient gender (m/f)
- `family_ID::Int` — Family identifier
- `class` — School class (0, 1, or 2)
- `complications` — Whether complications occurred (yes/no)
- `x_loc::Float64` — Household x coordinate
- `y_loc::Float64` — Household y coordinate

**Source:** Pfeilsticker (1863). Reproduced by Oesterle (1992) and Neal & Roberts (2004).

# Example

```julia
df = measles_hagelloch_1861()
first(df, 6)
```
"""
measles_hagelloch_1861() = _load("measles_hagelloch_1861.csv")

"""
    nipah_malaysia() -> DataFrame

Daily Nipah virus case counts by state during the 1999 outbreak in Malaysia.
The outbreak was associated with pig farming and resulted in 265 cases
with a 40% case fatality rate.

**49 rows** × 5 columns:
- `date::Date` — Calendar date
- `perak::Int` — Cases in Perak state
- `negeri_sembilan::Int` — Cases in Negeri Sembilan state
- `selangor::Int` — Cases in Selangor state
- `singapore::Int` — Cases in Singapore

**Source:** Chua KB, Bellini WJ, Rota PA, et al. (2000). *Science* 288(5470):1432–1435.

# Example

```julia
df = nipah_malaysia()
first(df, 6)
```
"""
nipah_malaysia() = _load("nipah_malaysia.csv")

"""
    norovirus_derbyshire_2001_school() -> DataFrame

Individual-level data from a norovirus gastroenteritis outbreak in a primary
school in Derbyshire, England, in 2001.

**492 rows** × 5 columns:
- `class` — School class of the pupil
- `day_absent` — Day of absence
- `start_illness` — Day illness started
- `end_illness` — Day illness ended
- `day_vomiting` — Day vomiting occurred

**Source:** Maguire AJ, Green J, Brown DWG, Desselberger U, Gray JJ (2006).

# Example

```julia
df = norovirus_derbyshire_2001_school()
first(df, 6)
```
"""
norovirus_derbyshire_2001_school() = _load("norovirus_derbyshire_2001_school.csv")

"""
    sars_canada_2003() -> DataFrame

Daily SARS case counts in Canada during the 2003 outbreak, stratified by
probable source of infection.

**110 rows** × 5 columns:
- `date::Date` — Calendar date
- `cases_travel::Int` — Cases linked to travel
- `cases_household::Int` — Cases linked to household contact
- `cases_healthcare::Int` — Cases linked to healthcare settings
- `cases_other::Int` — Cases from other sources

**Source:** WHO.

# Example

```julia
df = sars_canada_2003()
first(df, 6)
```
"""
sars_canada_2003() = _load("sars_canada_2003.csv")

"""
    sarscov2_who_2019() -> DataFrame

WHO situation report data on early SARS-CoV-2 cases and deaths by country/region.
This is a wide-format dataset with columns for each country's case and death counts.

**92 rows** with columns including:
`situation_report`, `date`, `cases_chn`, `cases_global`, `deaths_global`,
plus per-country case and death columns for ~200 countries/territories using
ISO 3166-1 alpha-3 codes (e.g. `cases_usa`, `deaths_ita`).

**Source:** WHO Situation Reports, 2019–2020.

# Example

```julia
df = sarscov2_who_2019()
names(df)[1:10]
```
"""
sarscov2_who_2019() = _load("sarscov2_who_2019.csv")

"""
    smallpox_abakaliki_1967() -> DataFrame

Individual-level data from a 1967 smallpox outbreak in Abakaliki, Nigeria.
This classic dataset is frequently used to illustrate outbreak analysis methods.

**32 rows** × 8 columns:
- `case_ID::Int` — Case identifier
- `date_of_onset::Date` — Date of symptom onset
- `age::Int` — Patient age
- `gender` — Patient gender
- `vaccinated` — Vaccination status
- `vaccscar` — Whether a vaccination scar was present
- `ftc` — Face, trunk, or combined presentation
- `compound` — Compound identifier

**Source:** Thompson D, Foege W (1968). Faith Tabernacle smallpox epidemic.

# Example

```julia
df = smallpox_abakaliki_1967()
first(df, 6)
```
"""
smallpox_abakaliki_1967() = _load("smallpox_abakaliki_1967.csv")

"""
    varicella_sim_berlin() -> DataFrame

Simulated varicella (chickenpox) surveillance data set for Berlin, designed
to illustrate outbreak detection and reporting patterns.

**500 rows** × 13 columns:
- `sex` — Patient sex
- `ethnicity` — Patient ethnicity
- `firstname`, `lastname` — Simulated names
- `age::Int` — Patient age
- `center1`, `arrival1`, `leave1` — First care centre and dates
- `center2`, `arrival2`, `leave2` — Second care centre and dates
- `onset::Date` — Date of symptom onset
- `disease` — Disease name

**Source:** Simulation study.

# Example

```julia
df = varicella_sim_berlin()
first(df, 6)
```
"""
varicella_sim_berlin() = _load("varicella_sim_berlin.csv")

"""
    zika_girardot_2015() -> DataFrame

Weekly Zika virus case counts from an outbreak in Girardot, Colombia, 2015.

**93 rows** × 2 columns:
- `date::Date` — Date
- `cases::Int` — Number of cases

**Source:** Pacheco O, Beltrán M, Nelson CA, et al. (2016). *NEJM* 374:1981–1987.

# Example

```julia
df = zika_girardot_2015()
first(df, 6)
```
"""
zika_girardot_2015() = _load("zika_girardot_2015.csv")

"""
    zika_sanandres_2015() -> DataFrame

Weekly Zika virus case counts from an outbreak in San Andrés Island, Colombia, 2015.

**101 rows** × 2 columns:
- `date::Date` — Date
- `cases::Int` — Number of cases

**Source:** Pacheco O, Beltrán M, Nelson CA, et al. (2016). *NEJM* 374:1981–1987.

# Example

```julia
df = zika_sanandres_2015()
first(df, 6)
```
"""
zika_sanandres_2015() = _load("zika_sanandres_2015.csv")

"""
    zika_yap_2007() -> DataFrame

Weekly Zika virus case counts from the 2007 outbreak on Yap Island,
Federated States of Micronesia — the first recognized Zika outbreak
outside Africa and Asia.

**29 rows** × 3 columns:
- `onset_date::Date` — Start date of the reporting week
- `nr::Int` — Week number
- `value::Int` — Number of cases reported that week

**Source:** Duffy MR, Chen TH, Hancock WT, et al. (2009). *NEJM* 360:2536–2543.

# Example

```julia
df = zika_yap_2007()
first(df, 6)
```
"""
zika_yap_2007() = _load("zika_yap_2007.csv")

# --- Complex datasets (return NamedTuples) ---

"""
    ebola_sim() -> NamedTuple{(:linelist, :contacts), Tuple{DataFrame, DataFrame}}

Simulated Ebola Virus Disease outbreak dataset with properties mimicking
the 2014–2015 West African epidemic. Created by Pierre Nouvellet as a teaching
resource, it contains intentional data quality issues (e.g. negative incubation
periods from erroneous date entries).

See also [`ebola_sim_clean`](@ref) for the cleaned version.

**Returns** a `NamedTuple` with two components:

- `linelist` — **5,888 rows** × 11 columns:
  `case_id`, `generation`, `date_of_infection`, `date_of_onset`,
  `date_of_hospitalisation`, `date_of_outcome`, `outcome`, `gender`,
  `hospital`, `lon`, `lat`
- `contacts` — **3,800 rows** × 3 columns:
  `infector`, `case_id`, `source`

# Example

```julia
data = ebola_sim()
first(data.linelist, 5)
first(data.contacts, 5)
```
"""
function ebola_sim()
    return (linelist = _load("ebola_sim_linelist.csv"),
            contacts = _load("ebola_sim_contacts.csv"))
end

"""
    ebola_sim_clean() -> NamedTuple{(:linelist, :contacts), Tuple{DataFrame, DataFrame}}

Cleaned version of [`ebola_sim`](@ref) with erroneous dates removed.

**Returns** a `NamedTuple` with two components:

- `linelist` — **5,829 rows** × 11 columns (same schema as `ebola_sim`)
- `contacts` — **3,800 rows** × 3 columns (same schema as `ebola_sim`)

# Example

```julia
data = ebola_sim_clean()
nrow(data.linelist)  # 5829 (fewer rows than ebola_sim due to cleaning)
```
"""
function ebola_sim_clean()
    return (linelist = _load("ebola_sim_clean_linelist.csv"),
            contacts = _load("ebola_sim_clean_contacts.csv"))
end

"""
    mers_korea_2015() -> NamedTuple{(:linelist, :contacts), Tuple{DataFrame, DataFrame}}

MERS-CoV outbreak data from South Korea, 2015. The outbreak originated from
a single index case returning from the Middle East and resulted in 186
confirmed cases and 38 deaths.

**Returns** a `NamedTuple` with two components:

- `linelist` — **162 rows** × 15 columns:
  `id`, `age`, `age_class`, `sex`, `place_infect`, `reporting_ctry`,
  `loc_hosp`, `dt_onset`, `dt_report`, `week_report`, `dt_start_exp`,
  `dt_end_exp`, `dt_diag`, `outcome`, `dt_death`
- `contacts` — **98 rows** × 4 columns:
  `from`, `to`, `exposure`, `diff_dt_onset`

**Source:** WHO / Korean CDC.

# Example

```julia
data = mers_korea_2015()
first(data.linelist, 5)
first(data.contacts, 5)
```
"""
function mers_korea_2015()
    return (linelist = _load("mers_korea_2015_linelist.csv"),
            contacts = _load("mers_korea_2015_contacts.csv"))
end

"""
    rabies_car_2003() -> NamedTuple{(:linelist, :dna), Tuple{DataFrame, DataFrame}}

Rabies virus outbreak data from the Central African Republic, 2003. Includes
a spatial linelist of animal cases and a DNA sequence distance matrix.

**Returns** a `NamedTuple` with two components:

- `linelist` — **151 rows** × 5 columns:
  `index`, `date`, `latitude`, `longitude`, `has_dna`
- `dna` — **137 rows** × distance matrix columns (pairwise genetic distances)

**Source:** Talbi C, Lemey P, Suchard MA, et al. (2009).

# Example

```julia
data = rabies_car_2003()
first(data.linelist, 5)
size(data.dna)
```
"""
function rabies_car_2003()
    return (linelist = _load("rabies_car_2003_linelist.csv"),
            dna = _load("rabies_car_2003_dna.csv"))
end

"""
    s_enteritidis_pt59() -> NamedTuple{(:graph, :cluster), Tuple{DataFrame, DataFrame}}

*Salmonella* Enteritidis PT59 outbreak data, including a contact/exposure
network graph and cluster assignments.

**Returns** a `NamedTuple` with two components:

- `graph` — **103 rows** × 3 columns: edge list (`from`, `to`)
- `cluster` — **43 rows** × 2 columns: node cluster assignments

**Source:** Reingold et al. (2004).

# Example

```julia
data = s_enteritidis_pt59()
first(data.graph, 5)
first(data.cluster, 5)
```
"""
function s_enteritidis_pt59()
    return (graph = _load("s_enteritidis_pt59_graph.csv"),
            cluster = _load("s_enteritidis_pt59_cluster.csv"))
end

export covid19_england_nhscalls_2020,
       dengue_fais_2011,
       dengue_yap_2011,
       ebola_kikwit_1995,
       ebola_sierraleone_2014,
       fluH7N9_china_2013,
       influenza_england_1978_school,
       measles_hagelloch_1861,
       nipah_malaysia,
       norovirus_derbyshire_2001_school,
       sars_canada_2003,
       sarscov2_who_2019,
       smallpox_abakaliki_1967,
       varicella_sim_berlin,
       zika_girardot_2015,
       zika_sanandres_2015,
       zika_yap_2007,
       ebola_sim,
       ebola_sim_clean,
       mers_korea_2015,
       rabies_car_2003,
       s_enteritidis_pt59

# --- Catlab extension: types and API ---
# Types defined here; methods added by OutbreaksCatlabExt when `using Catlab`.

"""
    TemporalScale

Represents a temporal aggregation resolution (Day, Week, Month, Year).
Each scale defines a binning morphism from finer to coarser time.
"""
struct TemporalScale
    name::Symbol
    bin_func::Function
end

"""
    CategoricalScale(col::Symbol)

Stratification by a categorical column (e.g., district, sex, age group).
"""
struct CategoricalScale
    col::Symbol
end

"""
    ProductScale

Tensor product of scales for joint stratification.
Created via `⊗`, e.g. `Week ⊗ Class(:district)`.
"""
struct ProductScale
    scales::Vector{Union{TemporalScale, CategoricalScale}}
end

"""
    BucketedCases

Result of categorical aggregation *before* decategorification.
Preserves fiber structure: for each bucket, knows *which* cases
are in it (not just how many). The `bin_map` field holds the
`FinFunction` from cases to bins once the Catlab extension is loaded.
"""
struct BucketedCases
    bin_map::Any             # FinFunction (Case → Bin) when Catlab loaded
    bins::Vector             # bin labels
    cases::DataFrame         # original case-level data
    scales::Vector{Union{TemporalScale, CategoricalScale}}
end

"""
    LineListACSetWrapper

Wraps a Catlab ACSet with metadata for ergonomic categorical operations.
"""
struct LineListACSetWrapper
    acset::Any               # ACSet instance
    df::DataFrame            # original DataFrame
    onset_col::Symbol        # onset date column
    strata_cols::Vector{Symbol}
end

# Pretty printing
function Base.show(io::IO, ll::LineListACSetWrapper)
    n = nrow(ll.df)
    print(io, "LineListACSet($(n) cases, onset=:$(ll.onset_col)")
    isempty(ll.strata_cols) || print(io, ", strata=$(ll.strata_cols)")
    print(io, ")")
end

function Base.show(io::IO, b::BucketedCases)
    nc = nrow(b.cases)
    nb = length(b.bins)
    labels = [s isa TemporalScale ? string(s.name) : string(s.col) for s in b.scales]
    print(io, "BucketedCases($(nc) cases → $(nb) bins, by=$(join(labels, " ⊗ ")))")
end

Base.show(io::IO, s::TemporalScale) = print(io, "TemporalScale(:$(s.name))")
Base.show(io::IO, s::CategoricalScale) = print(io, "CategoricalScale(:$(s.col))")
function Base.show(io::IO, p::ProductScale)
    labels = [s isa TemporalScale ? string(s.name) : string(s.col) for s in p.scales]
    print(io, join(labels, " ⊗ "))
end

# Standard temporal scales
const Day   = TemporalScale(:day,   identity)
const Week  = TemporalScale(:week,  d -> Dates.firstdayofweek(d))
const Month = TemporalScale(:month, d -> Date(Dates.year(d), Dates.month(d), 1))
const Year  = TemporalScale(:year,  d -> Date(Dates.year(d), 1, 1))

# Convenience constructors for categorical scales
"""Create a [`CategoricalScale`](@ref) for school/hospital class."""
Class(col::Symbol) = CategoricalScale(col)
"""Create a [`CategoricalScale`](@ref) for geographic district."""
District(col::Symbol) = CategoricalScale(col)
"""Create a [`CategoricalScale`](@ref) for an arbitrary stratum."""
Stratum(col::Symbol) = CategoricalScale(col)

# Pipe-friendly curried form
"""
    aggregate_by(scale) -> Function

Curried form of [`aggregate`](@ref) for use with `|>` piping.

# Example
```julia
ll |> aggregate_by(Week) |> ♯
```
"""
aggregate_by(scale) = ll -> aggregate(ll, scale)
aggregate_by(scale, by) = ll -> aggregate(ll, scale; by=by)

# --- Function stubs (methods added by extension) ---

"""
    LineListACSet(df::DataFrame; onset, location=nothing, age=nothing, outcome=nothing)

Convert a DataFrame into a categorical ACSet. Requires `Catlab.jl`.

# Example
```julia
using Outbreaks, Catlab
ll = LineListACSet(measles_hagelloch_1861(), onset=:date_of_prodrome, location=:class)
```
"""
function LineListACSet end

"""
    EpiCurveACSet(df::DataFrame; time, count)

Convert an aggregated epidemic curve DataFrame into an ACSet. Requires `Catlab.jl`.
"""
function EpiCurveACSet end

"""
    aggregate(acset, scale; by=nothing)

Aggregate a line list ACSet by temporal/categorical scale.
Returns a [`BucketedCases`](@ref) preserving fiber structure.

See also: [`decategorify`](@ref), [`↓`](@ref)
"""
function aggregate end

"""
    decategorify(bucketed::BucketedCases) -> DataFrame

Count cases per bucket, collapsing categorical structure to counts.
Information loss occurs here (not at binning).

See also: [`aggregate`](@ref), [`♯`](@ref)
"""
function decategorify end

"""
    fibers(bucketed::BucketedCases) -> Vector{DataFrame}

Return the preimage of each bin: the cases assigned to that bucket.
This is the left Kan extension *before* applying cardinality.
"""
function fibers end

"""
    coarsen(bucketed::BucketedCases, new_scale::TemporalScale) -> BucketedCases

Compose binning functorially: if `b` buckets by week, `coarsen(b, Month)`
computes `Case → Week → Month` without re-accessing raw data.
"""
function coarsen end

# --- Unicode operators ---

"""
    ll ↓ scale

Coarsen temporal resolution. Alias for [`aggregate`](@ref).
The downward arrow (↓) suggests information flows "down" to coarser scale.

# Example
```julia
using Outbreaks, Catlab
ll = LineListACSet(measles_hagelloch_1861(), onset=:date_of_prodrome)
weekly = ll ↓ Week
monthly = weekly ↓ Month   # functorial composition
```
"""
(↓)(a, b) = throw(MethodError(↓, (a, b)))

"""
    ♯(bucketed)
    ♯(ll, scale)

Decategorify: count fibers. Alias for [`decategorify`](@ref).
The sharp (♯) evokes "counting measure" / discretization.

# Example
```julia
♯(ll ↓ Week)           # weekly epidemic curve as DataFrame
♯(ll, Week)            # shorthand: aggregate + count in one step
♯(ll, Week ⊗ Class(:class))  # stratified counts
```
"""
♯(a) = throw(MethodError(♯, (a,)))
♯(a, b) = throw(MethodError(♯, (a, b)))

"""
    scale1 ⊗ scale2

Tensor product of scales for stratified aggregation.
The result lives in a product category.
Requires `Catlab.jl` (uses Catlab's monoidal product `⊗`).

# Example
```julia
using Outbreaks, Catlab
# Count by week × district
♯(ll, Week ⊗ District(:district))
```
"""
# ⊗ is NOT defined here — the extension adds methods to Catlab's ⊗

export TemporalScale, CategoricalScale, ProductScale, BucketedCases, LineListACSetWrapper
export Day, Week, Month, Year
export Class, District, Stratum
export aggregate_by
export LineListACSet, EpiCurveACSet, aggregate, decategorify, fibers, coarsen
export ↓, ♯

end # module
