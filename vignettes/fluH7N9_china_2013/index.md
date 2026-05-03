# Influenza A H7N9, China, 2013


## Overview

This dataset contains individual-level data on 136 confirmed human cases
of avian influenza A (H7N9) in China, 2013. It includes dates of onset,
hospitalisation, and outcome, along with patient demographics (age,
gender) and province. The H7N9 subtype emerged in early 2013 with
zoonotic spillover from poultry, causing severe respiratory illness with
a high case fatality rate.

**Source:** Kucharski AJ, Mills HL, Donnelly CA, Riley S (2014).
Transmission potential of healthcare-acquired infections in acute care
settings. *PLOS Currents Outbreaks*. Data archived at Dryad:
doi:10.5061/dryad.2g43n.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.fluH7N9_china_2013()
size(df)
```

    (136, 8)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×8 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_id | date_of_onset | date_of_hospitalisation | date_of_outcome | outcome | gender | age | province |
|---:|---:|:---|:---|:---|:---|:---|:---|:---|
|  | Int64 | String15 | String15 | String15 | String7 | String3 | String3 | String15 |
| 1 | 1 | 2013-02-19 | NA | 2013-03-04 | Death | m | 87 | Shanghai |
| 2 | 2 | 2013-02-27 | 2013-03-03 | 2013-03-10 | Death | m | 27 | Shanghai |
| 3 | 3 | 2013-03-09 | 2013-03-19 | 2013-04-09 | Death | f | 35 | Anhui |
| 4 | 4 | 2013-03-19 | 2013-03-27 | NA | NA | f | 45 | Jiangsu |
| 5 | 5 | 2013-03-19 | 2013-03-30 | 2013-05-15 | Recover | f | 48 | Jiangsu |
| 6 | 6 | 2013-03-21 | 2013-03-28 | 2013-04-26 | Death | f | 32 | Jiangsu |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>8×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable                | mean   | min        | median | max      | nmissing | eltype   |
|----:|:------------------------|:-------|:-----------|:-------|:---------|---------:|:---------|
|     | Symbol                  | Union… | Any        | Union… | Any      |    Int64 | DataType |
|   1 | case_id                 | 68.5   | 1          | 68.5   | 136      |        0 | Int64    |
|   2 | date_of_onset           |        | 2013-02-19 |        | NA       |        0 | String15 |
|   3 | date_of_hospitalisation |        | 2013-03-03 |        | NA       |        0 | String15 |
|   4 | date_of_outcome         |        | 2013-03-04 |        | NA       |        0 | String15 |
|   5 | outcome                 |        | Death      |        | Recover  |        0 | String7  |
|   6 | gender                  |        | NA         |        | m        |        0 | String3  |
|   7 | age                     |        | 15         |        | ?        |        0 | String3  |
|   8 | province                |        | Anhui      |        | Zhejiang |        0 | String15 |

</div>

## Outcomes

``` julia
using StatsBase
outcome_counts = combine(groupby(df, :outcome), nrow => :count)
for row in eachrow(outcome_counts)
    println("$(rpad(coalesce(string(row.outcome), "missing"), 15)) $(row.count)")
end
```

    Death           32
    NA              57
    Recover         47

## Epidemic curve

``` julia
onset = dropmissing(df, :date_of_onset)
sort!(onset, :date_of_onset)
println("Onset range: $(minimum(onset.date_of_onset)) to $(maximum(onset.date_of_onset))")
daily = combine(groupby(onset, :date_of_onset), nrow => :cases)
sort!(daily, :date_of_onset)
for row in eachrow(daily)
    bar = repeat("█", row.cases)
    println("$(row.date_of_onset) | $bar $(row.cases)")
end
```

    Onset range: 2013-02-19 to NA
    2013-02-19 | █ 1
    2013-02-27 | █ 1
    2013-03-07 | █ 1
    2013-03-08 | █ 1
    2013-03-09 | █ 1
    2013-03-13 | █ 1
    2013-03-17 | █ 1
    2013-03-19 | ██ 2
    2013-03-20 | ██ 2
    2013-03-21 | ██ 2
    2013-03-22 | █ 1
    2013-03-25 | ██ 2
    2013-03-27 | █ 1
    2013-03-28 | ████ 4
    2013-03-29 | ██████ 6
    2013-03-30 | ██ 2
    2013-03-31 | ███ 3
    2013-04-01 | ██████ 6
    2013-04-02 | ██ 2
    2013-04-03 | ███████ 7
    2013-04-04 | ███ 3
    2013-04-05 | ██ 2
    2013-04-06 | ███████ 7
    2013-04-07 | █ 1
    2013-04-08 | ██████ 6
    2013-04-09 | ███ 3
    2013-04-10 | ██████ 6
    2013-04-11 | ██████ 6
    2013-04-12 | ██████ 6
    2013-04-13 | █████ 5
    2013-04-14 | █████ 5
    2013-04-15 | ████ 4
    2013-04-16 | ███ 3
    2013-04-17 | █████ 5
    2013-04-18 | ███ 3
    2013-04-19 | ██ 2
    2013-04-21 | ██ 2
    2013-04-23 | ██ 2
    2013-04-25 | █ 1
    2013-04-26 | █ 1
    2013-04-27 | █ 1
    2013-04-29 | █ 1
    2013-05-03 | █ 1
    2013-05-21 | █ 1
    2013-07-10 | █ 1
    2013-07-27 | █ 1
    NA | ██████████ 10
