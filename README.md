# Outbreaks.jl

[![CI](https://github.com/sdwfrost/Outbreaks.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sdwfrost/Outbreaks.jl/actions/workflows/CI.yml)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://sdwfrost.github.io/Outbreaks.jl/dev)

Curated disease outbreak datasets for Julia — a port of the R [outbreaks](https://CRAN.R-project.org/package=outbreaks) package.

## Installation

```julia
using Pkg
Pkg.add("Outbreaks")
```

## Quick Start

```julia
using Outbreaks
using DataFrames

# Load a line list
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
| `ebola_sierraleone_2014()` | Ebola | Sierra Leone | 2014 | 11,903 |
| `fluH7N9_china_2013()` | Influenza A H7N9 | China | 2013 | 136 |
| `measles_hagelloch_1861()` | Measles | Hagelloch, Germany | 1861 | 188 |
| `smallpox_abakaliki_1967()` | Smallpox | Abakaliki, Nigeria | 1967 | 32 |
| `norovirus_derbyshire_2001_school()` | Norovirus | Derbyshire, England | 2001 | 492 |
| `varicella_sim_berlin()` | Varicella | Berlin (simulated) | — | 500 |

### Aggregated Time Series

| Function | Disease | Location | Year | Rows |
|:---------|:--------|:---------|:-----|-----:|
| `covid19_england_nhscalls_2020()` | COVID-19 | England | 2020 | 253,670 |
| `dengue_fais_2011()` | Dengue | Fais Island, Micronesia | 2011 | 57 |
| `dengue_yap_2011()` | Dengue | Yap Island, Micronesia | 2011 | 185 |
| `ebola_kikwit_1995()` | Ebola | Kikwit, DRC | 1995 | 192 |
| `influenza_england_1978_school()` | Influenza | England | 1978 | 14 |
| `nipah_malaysia()` | Nipah | Malaysia | 1999 | 49 |
| `sars_canada_2003()` | SARS | Canada | 2003 | 110 |
| `sarscov2_who_2019()` | SARS-CoV-2 | Global (WHO) | 2019–2020 | 92 |
| `zika_girardot_2015()` | Zika | Girardot, Colombia | 2015 | 93 |
| `zika_sanandres_2015()` | Zika | San Andrés, Colombia | 2015 | 101 |
| `zika_yap_2007()` | Zika | Yap Island, Micronesia | 2007 | 29 |

### Multi-table Datasets (return `NamedTuple`)

| Function | Disease | Tables |
|:---------|:--------|:-------|
| `ebola_sim()` | Ebola (simulated) | `linelist` (5,888 rows) + `contacts` (3,800 rows) |
| `ebola_sim_clean()` | Ebola (simulated, cleaned) | `linelist` (5,829 rows) + `contacts` (3,800 rows) |
| `mers_korea_2015()` | MERS-CoV | `linelist` (162 rows) + `contacts` (98 rows) |
| `rabies_car_2003()` | Rabies | `linelist` (151 rows) + `dna` (137 rows) |
| `s_enteritidis_pt59()` | Salmonella | `graph` (103 rows) + `cluster` (43 rows) |

## Documentation

Full API documentation with column descriptions, sources, and examples is available at the [documentation site](https://sdwfrost.github.io/Outbreaks.jl/dev).

## Relationship to R outbreaks package

This package provides the same datasets as the R [outbreaks](https://CRAN.R-project.org/package=outbreaks) package (v1.9.0), stored as CSV files and loaded using [CSV.jl](https://github.com/JuliaData/CSV.jl) and [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl). Simple datasets return a `DataFrame`; complex multi-table datasets return a `NamedTuple` of `DataFrame`s.

## License

MIT License. See [LICENSE](LICENSE) for details.

Individual datasets may have their own citation requirements — see the docstrings for source references.
