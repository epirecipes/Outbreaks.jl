# Measles, Hagelloch, Germany, 1861


## Overview

This dataset documents a measles outbreak in the village of Hagelloch,
Germany, in 1861. The detailed records include individual-level data on
188 cases with dates of prodrome and rash onset, spatial locations,
family and school class membership, and identified infectors — making it
one of the earliest and most complete outbreak datasets available.

## Source

Pfeilsticker (1863); Oesterle (1992); Neal & Roberts (2004).

## Data

The dataset contains 188 rows and 12 columns:

- **case_ID**: unique case identifier
- **infector**: case ID of the infector
- **date_of_prodrome**: date of prodromal symptoms
- **date_of_rash**: date of rash onset
- **date_of_death**: date of death (if applicable)
- **age**: age of the individual
- **gender**: gender
- **family_ID**: family identifier
- **class**: school class
- **complications**: complications recorded
- **x_loc**: x coordinate of household location
- **y_loc**: y coordinate of household location

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.measles_hagelloch_1861()
first(df, 6)
```

<div><div style = "float: left;"><span>6×12 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_ID | infector | date_of_prodrome | date_of_rash | date_of_death | age | gender | family_ID | class | complications | x_loc | y_loc |
|---:|---:|:---|:---|:---|:---|---:|:---|---:|---:|:---|---:|---:|
|  | Int64 | String3 | Date | Date | String15 | Int64 | String3 | Int64 | Int64 | String3 | Float64 | Float64 |
| 1 | 1 | 45 | 1861-11-21 | 1861-11-25 | NA | 7 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 2 | 2 | 45 | 1861-11-23 | 1861-11-27 | NA | 6 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 3 | 3 | 172 | 1861-11-28 | 1861-12-02 | NA | 4 | f | 41 | 0 | yes | 142.5 | 100.0 |
| 4 | 4 | 180 | 1861-11-27 | 1861-11-28 | NA | 13 | m | 61 | 2 | yes | 165.0 | 102.5 |
| 5 | 5 | 45 | 1861-11-22 | 1861-11-27 | NA | 8 | f | 42 | 1 | yes | 145.0 | 120.0 |
| 6 | 6 | 180 | 1861-11-26 | 1861-11-29 | NA | 12 | m | 42 | 2 | yes | 145.0 | 120.0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>12×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Any | Any | Int64 | DataType |
| 1 | case_ID | 94.5 | 1 | 94.5 | 188 | 0 | Int64 |
| 2 | infector |  | 1 |  | NA | 0 | String3 |
| 3 | date_of_prodrome |  | 1861-10-30 | 1861-12-01 | 1862-01-24 | 0 | Date |
| 4 | date_of_rash |  | 1861-11-03 | 1861-12-05 | 1862-01-27 | 0 | Date |
| 5 | date_of_death |  | 1861-11-18 |  | NA | 0 | String15 |
| 6 | age | 6.98936 | 0 | 7.0 | 15 | 0 | Int64 |
| 7 | gender |  | NA |  | m | 0 | String3 |
| 8 | family_ID | 30.9521 | 1 | 31.0 | 69 | 0 | Int64 |
| 9 | class | 0.882979 | 0 | 1.0 | 2 | 0 | Int64 |
| 10 | complications |  | yes |  | yes | 0 | String3 |
| 11 | x_loc | 188.218 | 7.5 | 182.5 | 280.0 | 0 | Float64 |
| 12 | y_loc | 133.777 | 5.0 | 147.5 | 240.0 | 0 | Float64 |

</div>
