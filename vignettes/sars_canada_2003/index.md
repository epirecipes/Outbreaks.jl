# SARS, Canada, 2003


## Overview

This dataset contains daily aggregated case counts of Severe Acute
Respiratory Syndrome (SARS) in Canada during the 2003 outbreak. Cases
are classified by transmission route: travel-related, household,
healthcare, and other. The dataset comprises 110 rows and 5 columns.

## Source

De Vries et al. (2006), based on data from Health Canada.

## Loading the data

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.sars_canada_2003()
```

<div><div style = "float: left;"><span>110×5 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>85 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases_travel | cases_household | cases_healthcare | cases_other |
|----:|:-----------|-------------:|----------------:|-----------------:|------------:|
|     | Date       |        Int64 |           Int64 |            Int64 |       Int64 |
|   1 | 2003-02-23 |            1 |               0 |                0 |           0 |
|   2 | 2003-02-24 |            0 |               0 |                0 |           0 |
|   3 | 2003-02-25 |            0 |               0 |                0 |           0 |
|   4 | 2003-02-26 |            0 |               1 |                0 |           0 |
|   5 | 2003-02-27 |            0 |               0 |                0 |           0 |
|   6 | 2003-02-28 |            1 |               0 |                0 |           0 |
|   7 | 2003-03-01 |            0 |               0 |                0 |           0 |
|   8 | 2003-03-02 |            0 |               0 |                0 |           0 |
|   9 | 2003-03-03 |            0 |               1 |                0 |           0 |
|  10 | 2003-03-04 |            0 |               0 |                0 |           0 |
|  11 | 2003-03-05 |            0 |               1 |                0 |           0 |
|  12 | 2003-03-06 |            0 |               0 |                0 |           0 |
|  13 | 2003-03-07 |            0 |               1 |                0 |           0 |
|   ⋮ | ⋮          |            ⋮ |               ⋮ |                ⋮ |           ⋮ |
|  99 | 2003-06-01 |            0 |               1 |                2 |           0 |
| 100 | 2003-06-02 |            0 |               0 |                1 |           0 |
| 101 | 2003-06-03 |            0 |               0 |                1 |           0 |
| 102 | 2003-06-04 |            0 |               0 |                2 |           0 |
| 103 | 2003-06-05 |            0 |               0 |                0 |           0 |
| 104 | 2003-06-06 |            0 |               0 |                0 |           0 |
| 105 | 2003-06-07 |            0 |               0 |                0 |           0 |
| 106 | 2003-06-08 |            0 |               2 |                0 |           0 |
| 107 | 2003-06-09 |            0 |               0 |                0 |           0 |
| 108 | 2003-06-10 |            0 |               0 |                0 |           0 |
| 109 | 2003-06-11 |            0 |               0 |                0 |           0 |
| 110 | 2003-06-12 |            0 |               1 |                0 |           0 |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×5 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | cases_travel | cases_household | cases_healthcare | cases_other |
|----:|:-----------|-------------:|----------------:|-----------------:|------------:|
|     | Date       |        Int64 |           Int64 |            Int64 |       Int64 |
|   1 | 2003-02-23 |            1 |               0 |                0 |           0 |
|   2 | 2003-02-24 |            0 |               0 |                0 |           0 |
|   3 | 2003-02-25 |            0 |               0 |                0 |           0 |
|   4 | 2003-02-26 |            0 |               1 |                0 |           0 |
|   5 | 2003-02-27 |            0 |               0 |                0 |           0 |
|   6 | 2003-02-28 |            1 |               0 |                0 |           0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>5×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable         | mean      | min        | median | max        | nmissing | eltype   |
|----:|:-----------------|:----------|:-----------|:-------|:-----------|---------:|:---------|
|     | Symbol           | Union…    | Any        | Union… | Any        |    Int64 | DataType |
|   1 | date             |           | 2003-02-23 |        | 2003-06-12 |        0 | Date     |
|   2 | cases_travel     | 0.0454545 | 0          | 0.0    | 1          |        0 | Int64    |
|   3 | cases_household  | 0.418182  | 0          | 0.0    | 4          |        0 | Int64    |
|   4 | cases_healthcare | 1.75455   | 0          | 1.0    | 9          |        0 | Int64    |
|   5 | cases_other      | 0.0545455 | 0          | 0.0    | 2          |        0 | Int64    |

</div>
