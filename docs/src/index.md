# Outbreaks.jl

*Curated disease outbreak datasets for Julia.*

## Overview

**Outbreaks.jl** provides 23 curated disease outbreak datasets for use in
epidemiological research and teaching. It is a Julia port of the R
[outbreaks](https://CRAN.R-project.org/package=outbreaks) package.

Each dataset is accessed by calling its corresponding function. Simple datasets
return a `DataFrame`; complex multi-table datasets return a `NamedTuple` of
`DataFrame`s.

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/sdwfrost/Outbreaks.jl")
```

## Quick Start

```julia
using Outbreaks
using DataFrames

# Load a simple dataset
df = measles_hagelloch_1861()
first(df, 5)

# Load a multi-table dataset
data = ebola_sim()
first(data.linelist, 5)
first(data.contacts, 5)
```

## Available Datasets

### Line Lists (individual-level case data)

| Function | Disease | Location | Year | Rows |
|:---------|:--------|:---------|:-----|-----:|
| [`ebola_sierraleone_2014`](@ref) | Ebola | Sierra Leone | 2014 | 11,903 |
| [`fluH7N9_china_2013`](@ref) | Influenza A H7N9 | China | 2013 | 136 |
| [`measles_hagelloch_1861`](@ref) | Measles | Germany | 1861 | 188 |
| [`smallpox_abakaliki_1967`](@ref) | Smallpox | Nigeria | 1967 | 32 |
| [`norovirus_derbyshire_2001_school`](@ref) | Norovirus | England | 2001 | 492 |
| [`varicella_sim_berlin`](@ref) | Varicella | Berlin | Simulated | 500 |

### Aggregated Time Series

| Function | Disease | Location | Year | Rows |
|:---------|:--------|:---------|:-----|-----:|
| [`covid19_england_nhscalls_2020`](@ref) | COVID-19 | England | 2020 | 253,670 |
| [`dengue_fais_2011`](@ref) | Dengue | Fais Island | 2011 | 57 |
| [`dengue_yap_2011`](@ref) | Dengue | Yap Island | 2011 | 185 |
| [`ebola_kikwit_1995`](@ref) | Ebola | DRC | 1995 | 192 |
| [`influenza_england_1978_school`](@ref) | Influenza | England | 1978 | 14 |
| [`nipah_malaysia`](@ref) | Nipah | Malaysia | 1999 | 49 |
| [`sars_canada_2003`](@ref) | SARS | Canada | 2003 | 110 |
| [`sarscov2_who_2019`](@ref) | SARS-CoV-2 | Global | 2019 | 92 |
| [`zika_girardot_2015`](@ref) | Zika | Colombia | 2015 | 93 |
| [`zika_sanandres_2015`](@ref) | Zika | Colombia | 2015 | 101 |
| [`zika_yap_2007`](@ref) | Zika | Yap Island | 2007 | 29 |

### Multi-table Datasets

| Function | Disease | Location | Year | Tables |
|:---------|:--------|:---------|:-----|:-------|
| [`ebola_sim`](@ref) | Ebola | Simulated | — | linelist + contacts |
| [`ebola_sim_clean`](@ref) | Ebola | Simulated | — | linelist + contacts |
| [`mers_korea_2015`](@ref) | MERS-CoV | South Korea | 2015 | linelist + contacts |
| [`rabies_car_2003`](@ref) | Rabies | Central African Republic | 2003 | linelist + DNA |
| [`s_enteritidis_pt59`](@ref) | Salmonella | — | — | graph + cluster |

## Module Documentation

```@docs
Outbreaks
```
