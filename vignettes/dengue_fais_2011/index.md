# Dengue, Fais Island, Micronesia, 2011


## Overview

This dataset describes a dengue fever outbreak on Fais Island, a small
island in Yap State, Federated States of Micronesia, in 2011. The
outbreak affected 157 of the island’s 294 residents (53% attack rate),
illustrating the rapid spread of dengue in a small, immunologically
naïve island population.

**Source:** Funk S, Kucharski AJ, Camacho A, Eggo RM, Yakob L, Murray
LM, Edmunds WJ (2016). Comparative analysis of dengue and Zika outbreaks
reveals differences by setting and virus. *PLOS Neglected Tropical
Diseases* 10(12):e0005173.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.dengue_fais_2011()
size(df)
```

    (57, 3)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | onset_date |    nr | value |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 2011-09-15 |     7 |     0 |
|   2 | 2011-09-22 |    14 |     0 |
|   3 | 2011-09-29 |    21 |     0 |
|   4 | 2011-10-06 |    28 |     0 |
|   5 | 2011-10-13 |    35 |     0 |
|   6 | 2011-10-20 |    42 |     0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>3×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable   | mean   | min        | median     | max        | nmissing | eltype   |
|----:|:-----------|:-------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol     | Union… | Any        | Any        | Any        |    Int64 | DataType |
|   1 | onset_date |        | 2011-09-15 | 2011-11-30 | 2012-02-14 |        0 | Date     |
|   2 | nr         | 83.0   | 7          | 83.0       | 159        |        0 | Int64    |
|   3 | value      | 2.7193 | 0          | 0.0        | 19         |        0 | Int64    |

</div>

## Epidemic curve

``` julia
sort!(df, :onset_date)
println("Onset range: $(minimum(df.onset_date)) to $(maximum(df.onset_date))")
println("Total value: $(sum(df.value))")
for row in eachrow(df)
    if row.value > 0
        bar = repeat("█", min(row.value, 80))
        println("$(row.onset_date) (wk $(row.nr)) | $bar $(row.value)")
    end
end
```

    Onset range: 2011-09-15 to 2012-02-14
    Total value: 155
    2011-11-10 (wk 63) | █ 1
    2011-11-27 (wk 80) | █ 1
    2011-11-28 (wk 81) | ███ 3
    2011-11-29 (wk 82) | █ 1
    2011-11-30 (wk 83) | █ 1
    2011-12-01 (wk 84) | ████████ 8
    2011-12-02 (wk 85) | ████ 4
    2011-12-03 (wk 86) | ████████ 8
    2011-12-04 (wk 87) | ███████████ 11
    2011-12-05 (wk 88) | ███████ 7
    2011-12-06 (wk 89) | ███████████████ 15
    2011-12-07 (wk 90) | ███████████████████ 19
    2011-12-08 (wk 91) | ████████████ 12
    2011-12-09 (wk 92) | ██████████████ 14
    2011-12-10 (wk 93) | ██████████ 10
    2011-12-11 (wk 94) | ██████████████ 14
    2011-12-12 (wk 95) | ██████████ 10
    2011-12-13 (wk 96) | ████████ 8
    2011-12-14 (wk 97) | ██ 2
    2011-12-15 (wk 98) | █ 1
    2011-12-16 (wk 99) | █ 1
    2011-12-18 (wk 101) | █ 1
    2011-12-19 (wk 102) | █ 1
    2011-12-20 (wk 103) | ██ 2
