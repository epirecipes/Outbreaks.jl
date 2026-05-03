# Zika, Girardot, Colombia, 2015


## Overview

This dataset contains daily incidence data from the 2015 Zika virus
disease outbreak in Girardot, Colombia. A total of 1,936 cases were
reported in a population of 102,225. The dataset has 93 rows and 2
columns: date and daily case count.

## Source

Rojas, D. P. et al. (2016). The epidemiology and transmissibility of
Zika virus in Girardot and San Andres Island, Colombia, September 2015
to January 2016. *Eurosurveillance*, 21(28):30283. Licensed under CC BY
4.0.

## Loading the data

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.zika_girardot_2015()
```

<div><div style = "float: left;"><span>93×2 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>68 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 2015-10-19 |     1 |
|   2 | 2015-10-22 |     2 |
|   3 | 2015-10-23 |     1 |
|   4 | 2015-10-24 |     4 |
|   5 | 2015-10-25 |     2 |
|   6 | 2015-10-26 |     5 |
|   7 | 2015-10-27 |     2 |
|   8 | 2015-10-28 |     4 |
|   9 | 2015-10-29 |     5 |
|  10 | 2015-10-30 |     4 |
|  11 | 2015-10-31 |     6 |
|  12 | 2015-11-01 |     8 |
|  13 | 2015-11-02 |    11 |
|   ⋮ | ⋮          |     ⋮ |
|  82 | 2016-01-11 |     8 |
|  83 | 2016-01-12 |    11 |
|  84 | 2016-01-13 |    15 |
|  85 | 2016-01-14 |     5 |
|  86 | 2016-01-15 |     9 |
|  87 | 2016-01-16 |     6 |
|  88 | 2016-01-17 |     3 |
|  89 | 2016-01-18 |     3 |
|  90 | 2016-01-19 |     2 |
|  91 | 2016-01-20 |     2 |
|  92 | 2016-01-21 |     1 |
|  93 | 2016-01-22 |     1 |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 2015-10-19 |     1 |
|   2 | 2015-10-22 |     2 |
|   3 | 2015-10-23 |     1 |
|   4 | 2015-10-24 |     4 |
|   5 | 2015-10-25 |     2 |
|   6 | 2015-10-26 |     5 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>2×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean    | min        | median     | max        | nmissing | eltype   |
|----:|:---------|:--------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol   | Union…  | Any        | Any        | Any        |    Int64 | DataType |
|   1 | date     |         | 2015-10-19 | 2015-12-06 | 2016-01-22 |        0 | Date     |
|   2 | cases    | 20.8172 | 1          | 13.0       | 59         |        0 | Int64    |

</div>
