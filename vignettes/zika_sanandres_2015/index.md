# Zika, San Andres Island, Colombia, 2015


## Overview

This dataset contains daily incidence data from the 2015 Zika virus
disease outbreak on San Andres Island, Colombia. A total of 928 cases
were reported in a population of 54,513. The dataset has 101 rows and 2
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
df = Outbreaks.zika_sanandres_2015()
```

<div><div style = "float: left;"><span>101×2 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>76 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 2015-09-06 |     1 |
|   2 | 2015-09-07 |     1 |
|   3 | 2015-09-08 |     1 |
|   4 | 2015-09-13 |     1 |
|   5 | 2015-09-15 |     4 |
|   6 | 2015-09-19 |     1 |
|   7 | 2015-09-20 |     1 |
|   8 | 2015-09-23 |     1 |
|   9 | 2015-09-24 |     1 |
|  10 | 2015-09-26 |     1 |
|  11 | 2015-09-28 |     2 |
|  12 | 2015-09-29 |     1 |
|  13 | 2015-09-30 |     2 |
|   ⋮ | ⋮          |     ⋮ |
|  90 | 2015-12-16 |     2 |
|  91 | 2015-12-17 |     1 |
|  92 | 2015-12-18 |     1 |
|  93 | 2015-12-19 |     1 |
|  94 | 2015-12-20 |     3 |
|  95 | 2015-12-23 |     1 |
|  96 | 2015-12-26 |     2 |
|  97 | 2015-12-29 |     1 |
|  98 | 2016-01-20 |     1 |
|  99 | 2016-01-21 |     1 |
| 100 | 2016-01-29 |     1 |
| 101 | 2016-01-30 |     1 |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 2015-09-06 |     1 |
|   2 | 2015-09-07 |     1 |
|   3 | 2015-09-08 |     1 |
|   4 | 2015-09-13 |     1 |
|   5 | 2015-09-15 |     4 |
|   6 | 2015-09-19 |     1 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>2×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean    | min        | median     | max        | nmissing | eltype   |
|----:|:---------|:--------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol   | Union…  | Any        | Any        | Any        |    Int64 | DataType |
|   1 | date     |         | 2015-09-06 | 2015-11-07 | 2016-01-30 |        0 | Date     |
|   2 | cases    | 9.18812 | 1          | 6.0        | 36         |        0 | Int64    |

</div>
