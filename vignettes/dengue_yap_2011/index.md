# Dengue, Yap Main Islands, Micronesia, 2011


## Overview

This dataset describes a dengue fever outbreak on the Yap Main Islands,
Federated States of Micronesia, in 2011. Dengue serotype 2 caused 978
cases among 7,391 residents (13% attack rate). This outbreak occurred
concurrently with the Fais Island outbreak but in a larger population.

**Source:** Funk S, Kucharski AJ, Camacho A, Eggo RM, Yakob L, Murray
LM, Edmunds WJ (2016). Comparative analysis of dengue and Zika outbreaks
reveals differences by setting and virus. *PLOS Neglected Tropical
Diseases* 10(12):e0005173.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.dengue_yap_2011()
size(df)
```

    (185, 3)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | onset_date |    nr | value |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 2011-07-07 |     7 |     0 |
|   2 | 2011-07-14 |    14 |     0 |
|   3 | 2011-07-21 |    21 |     0 |
|   4 | 2011-07-28 |    28 |     0 |
|   5 | 2011-08-04 |    35 |     0 |
|   6 | 2011-08-11 |    42 |     0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>3×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable   | mean    | min        | median     | max        | nmissing | eltype   |
|----:|:-----------|:--------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol     | Union…  | Any        | Any        | Any        |    Int64 | DataType |
|   1 | onset_date |         | 2011-07-07 | 2011-11-24 | 2012-04-12 |        0 | Date     |
|   2 | nr         | 147.0   | 7          | 147.0      | 287        |        0 | Int64    |
|   3 | value      | 5.28649 | 0          | 4.0        | 29         |        0 | Int64    |

</div>

## Epidemic curve

``` julia
sort!(df, :onset_date)
println("Onset range: $(minimum(df.onset_date)) to $(maximum(df.onset_date))")
println("Total value: $(sum(df.value))")
for row in eachrow(first(df, 30))
    if row.value > 0
        bar = repeat("█", min(row.value, 60))
        println("$(row.onset_date) (wk $(row.nr)) | $bar $(row.value)")
    end
end
println("... ($(nrow(df)) rows total)")
```

    Onset range: 2011-07-07 to 2012-04-12
    Total value: 978
    2011-09-01 (wk 63) | █ 1
    2011-09-02 (wk 64) | ██ 2
    2011-09-09 (wk 71) | █ 1
    2011-09-15 (wk 77) | █ 1
    2011-09-16 (wk 78) | ██ 2
    2011-09-19 (wk 81) | █ 1
    2011-09-22 (wk 84) | ██ 2
    ... (185 rows total)
