# COVID-19 NHS Pathways Calls, England, 2020


## Overview

This dataset contains aggregated NHS Pathways call data from England
during the COVID-19 pandemic in 2020. NHS Pathways is the clinical
triage system used by NHS 111 and other urgent care services. The data
captures calls related to potential COVID-19 symptoms, broken down by
date, sex, age group, and clinical commissioning group (CCG). Note that
these are aggregated call counts, not individual case records.

**Source:** NHS digital dashboards; cleaned by Quentin Leclerc.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.covid19_england_nhscalls_2020()
size(df)
```

    (253670, 11)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×11 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | site_type | date | sex | age | ccg_code | ccg_name | count | postcode | nhs_region | day | weekday |
|---:|:---|:---|:---|:---|:---|:---|---:|:---|:---|---:|:---|
|  | String15 | Date | String7 | String7 | String15 | String | Int64 | String7 | String31 | Int64 | String15 |
| 1 | 111 | 2020-03-18 | female | missing | e38000062 | nhs_gloucestershire_ccg | 1 | gl34fe | South West | 0 | rest_of_week |
| 2 | 111 | 2020-03-18 | female | missing | e38000163 | nhs_south_tyneside_ccg | 1 | ne325nn | North East and Yorkshire | 0 | rest_of_week |
| 3 | 111 | 2020-03-18 | female | 0-18 | e38000001 | nhs_airedale_wharfedale_and_craven_ccg | 8 | bd57jr | North East and Yorkshire | 0 | rest_of_week |
| 4 | 111 | 2020-03-18 | female | 0-18 | e38000002 | nhs_ashford_ccg | 7 | tn254ab | South East | 0 | rest_of_week |
| 5 | 111 | 2020-03-18 | female | 0-18 | e38000004 | nhs_barking_and_dagenham_ccg | 35 | rm13ae | London | 0 | rest_of_week |
| 6 | 111 | 2020-03-18 | female | 0-18 | e38000005 | nhs_barnet_ccg | 9 | n111np | London | 0 | rest_of_week |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>11×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Any | Any | Int64 | DataType |
| 1 | site_type |  | 111 |  | 999 | 0 | String15 |
| 2 | date |  | 2020-03-18 | 2020-05-30 | 2020-09-20 | 0 | Date |
| 3 | sex |  | female |  | unknown | 0 | String7 |
| 4 | age |  | 0-18 |  | missing | 0 | String7 |
| 5 | ccg_code |  | e38000001 |  | zc040 | 0 | String15 |
| 6 | ccg_name |  | nhs_airedale_wharfedale_and_craven_ccg |  | null | 0 | String |
| 7 | count | 16.1684 | 1 | 4.0 | 1704 | 0 | Int64 |
| 8 | postcode |  | NA |  | yo16ga | 0 | String7 |
| 9 | nhs_region |  | East of England |  | South West | 0 | String31 |
| 10 | day | 81.3931 | 0 | 73.0 | 186 | 0 | Int64 |
| 11 | weekday |  | monday |  | weekend | 0 | String15 |

</div>

## Daily call volume

``` julia
using StatsBase
daily = combine(groupby(df, :date), :count => sum => :total_calls)
sort!(daily, :date)
first(daily, 10)
```

<div><div style = "float: left;"><span>10×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | total_calls |
|----:|:-----------|------------:|
|     | Date       |       Int64 |
|   1 | 2020-03-18 |      128429 |
|   2 | 2020-03-19 |      152090 |
|   3 | 2020-03-20 |      137217 |
|   4 | 2020-03-21 |      122668 |
|   5 | 2020-03-22 |      137143 |
|   6 | 2020-03-23 |      165332 |
|   7 | 2020-03-24 |      139417 |
|   8 | 2020-03-25 |      130453 |
|   9 | 2020-03-26 |      112282 |
|  10 | 2020-03-27 |      114668 |

</div>

``` julia
println("Date range: $(minimum(daily.date)) to $(maximum(daily.date))")
println("Total calls: $(sum(daily.total_calls))")
println("Peak day: $(daily.date[argmax(daily.total_calls)]) with $(maximum(daily.total_calls)) calls")
```

    Date range: 2020-03-18 to 2020-09-20
    Total calls: 4101446
    Peak day: 2020-03-23 with 165332 calls
