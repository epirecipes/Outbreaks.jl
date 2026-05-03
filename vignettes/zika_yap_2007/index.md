# Zika, Yap Main Islands, Micronesia, 2007


## Overview

This dataset documents the 2007 Zika virus outbreak on the Yap Main
Islands, Federated States of Micronesia. A total of 108 cases (59
probable and 49 confirmed) were recorded in a population of 7,391. The
dataset contains 29 rows and 3 columns: onset date, case number, and
value (weekly case counts).

## Source

Funk, S. et al. (2016). Comparative analysis of dengue and Zika
outbreaks reveals differences by setting and virus. *PLOS Neglected
Tropical Diseases*, 10(12):e0005173.

## Loading the data

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.zika_yap_2007()
```

<div><div style = "float: left;"><span>29×3 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>4 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | onset_date |    nr | value |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 2007-02-18 |     7 |     0 |
|   2 | 2007-02-25 |    14 |     0 |
|   3 | 2007-03-04 |    21 |     0 |
|   4 | 2007-03-11 |    28 |     0 |
|   5 | 2007-03-18 |    35 |     0 |
|   6 | 2007-03-25 |    42 |     0 |
|   7 | 2007-04-01 |    49 |     0 |
|   8 | 2007-04-08 |    56 |     0 |
|   9 | 2007-04-15 |    63 |     1 |
|  10 | 2007-04-22 |    70 |     2 |
|  11 | 2007-04-29 |    77 |     0 |
|  12 | 2007-05-06 |    84 |     1 |
|  13 | 2007-05-13 |    91 |     1 |
|   ⋮ | ⋮          |     ⋮ |     ⋮ |
|  18 | 2007-06-17 |   126 |    15 |
|  19 | 2007-06-24 |   133 |    19 |
|  20 | 2007-07-01 |   140 |     6 |
|  21 | 2007-07-08 |   147 |     1 |
|  22 | 2007-07-15 |   154 |     0 |
|  23 | 2007-07-22 |   161 |     0 |
|  24 | 2007-07-29 |   168 |     0 |
|  25 | 2007-08-05 |   175 |     0 |
|  26 | 2007-08-12 |   182 |     0 |
|  27 | 2007-08-19 |   189 |     0 |
|  28 | 2007-08-26 |   196 |     0 |
|  29 | 2007-09-02 |   203 |     0 |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | onset_date |    nr | value |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 2007-02-18 |     7 |     0 |
|   2 | 2007-02-25 |    14 |     0 |
|   3 | 2007-03-04 |    21 |     0 |
|   4 | 2007-03-11 |    28 |     0 |
|   5 | 2007-03-18 |    35 |     0 |
|   6 | 2007-03-25 |    42 |     0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>3×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable   | mean    | min        | median     | max        | nmissing | eltype   |
|----:|:-----------|:--------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol     | Union…  | Any        | Any        | Any        |    Int64 | DataType |
|   1 | onset_date |         | 2007-02-18 | 2007-05-27 | 2007-09-02 |        0 | Date     |
|   2 | nr         | 105.0   | 7          | 105.0      | 203        |        0 | Int64    |
|   3 | value      | 3.72414 | 0          | 0.0        | 29         |        0 | Int64    |

</div>
