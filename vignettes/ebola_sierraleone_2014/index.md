# Ebola, Sierra Leone, 2014


## Overview

This dataset contains individual-level line list data from the 2014
Ebola outbreak in Sierra Leone. With 11,903 records, it includes patient
demographics (age, sex), clinical status, dates of onset and sample
collection, and geographic information (district and chiefdom). This is
one of the largest publicly available Ebola line lists.

**Source:** Fang LQ, Yang Y, Jiang JF, Yao HW, Kargbo D, Li XL, et
al. (2016). Transmission dynamics of Ebola virus disease and
intervention effectiveness in Sierra Leone. *Proceedings of the National
Academy of Sciences* 113(16):4488–4493.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.ebola_sierraleone_2014()
size(df)
```

    (11903, 8)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×8 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | id | age | sex | status | date_of_onset | date_of_sample | district | chiefdom |
|---:|---:|:---|:---|:---|:---|:---|:---|:---|
|  | Int64 | String7 | String3 | String15 | Date | Date | String15 | String31 |
| 1 | 1 | 20 | F | confirmed | 2014-05-18 | 2014-05-23 | Kailahun | Kissi Teng |
| 2 | 2 | 42 | F | confirmed | 2014-05-20 | 2014-05-25 | Kailahun | Kissi Teng |
| 3 | 3 | 45 | F | confirmed | 2014-05-20 | 2014-05-25 | Kailahun | Kissi Tonge |
| 4 | 4 | 15 | F | confirmed | 2014-05-21 | 2014-05-26 | Kailahun | Kissi Teng |
| 5 | 5 | 19 | F | confirmed | 2014-05-21 | 2014-05-26 | Kailahun | Kissi Teng |
| 6 | 6 | 55 | F | confirmed | 2014-05-21 | 2014-05-26 | Kailahun | Kissi Teng |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>8×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable       | mean   | min        | median     | max           | nmissing | eltype   |
|----:|:---------------|:-------|:-----------|:-----------|:--------------|---------:|:---------|
|     | Symbol         | Union… | Any        | Any        | Any           |    Int64 | DataType |
|   1 | id             | 5952.0 | 1          | 5952.0     | 11903         |        0 | Int64    |
|   2 | age            |        | 0          |            | NA            |        0 | String7  |
|   3 | sex            |        | F          |            | NA            |        0 | String3  |
|   4 | status         |        | confirmed  |            | suspected     |        0 | String15 |
|   5 | date_of_onset  |        | 2014-05-18 | 2014-11-18 | 2015-09-12    |        0 | Date     |
|   6 | date_of_sample |        | 2014-05-23 | 2014-11-24 | 2015-09-13    |        0 | Date     |
|   7 | district       |        | Bo         |            | Western Urban |        0 | String15 |
|   8 | chiefdom       |        | Badjia     |            | Yoni          |        0 | String31 |

</div>

## Cases by district

``` julia
using StatsBase
district_counts = sort(combine(groupby(df, :district), nrow => :cases), :cases, rev=true)
for row in eachrow(district_counts)
    bar = repeat("█", max(1, round(Int, row.cases / 50)))
    println(rpad(coalesce(string(row.district), "missing"), 20), " | $bar $(row.cases)")
end
```

    Western Urban        | ███████████████████████████████████████████████████████████████ 3165
    Port Loko            | ██████████████████████████████████ 1701
    Western Rural        | ██████████████████████████████ 1522
    Bombali              | ████████████████████████ 1190
    Kenema               | ████████████████ 780
    Bo                   | ████████████ 606
    Tonkolili            | ████████████ 583
    Kailahun             | ███████████ 570
    Kono                 | ███████████ 551
    Moyamba              | █████████ 449
    Kambia               | ████████ 421
    Koinadugu            | ███ 157
    Pujehun              | ██ 124
    Bonthe               | ██ 84

## Epidemic curve (weekly)

``` julia
onset = dropmissing(df, :date_of_onset)
sort!(onset, :date_of_onset)
println("Onset range: $(minimum(onset.date_of_onset)) to $(maximum(onset.date_of_onset))")
println("Cases with onset date: $(nrow(onset)) / $(nrow(df))")
```

    Onset range: 2014-05-18 to 2015-09-12
    Cases with onset date: 11903 / 11903
