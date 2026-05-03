# Influenza, Boarding School, England, 1978


## Overview

This dataset describes an influenza outbreak at a boys’ boarding school
in England in 1978. Of the 763 boys at the school, 512 became ill over a
two-week period. The data record the daily number of boys confined to
bed and the number convalescing, providing a classic example of an
epidemic curve in a closed population.

## Source

Anonymous (1978). Influenza in a boarding school. *British Medical
Journal* 1:578. See also De Vries et al. (2006).

## Data

The dataset contains 14 rows and 3 columns:

- **date**: date of observation
- **in_bed**: number of boys confined to bed
- **convalescent**: number of boys convalescing

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.influenza_england_1978_school()
first(df, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | in_bed | convalescent |
|----:|:-----------|-------:|-------------:|
|     | Date       |  Int64 |        Int64 |
|   1 | 1978-01-22 |      3 |            0 |
|   2 | 1978-01-23 |      8 |            0 |
|   3 | 1978-01-24 |     26 |            0 |
|   4 | 1978-01-25 |     76 |            0 |
|   5 | 1978-01-26 |    225 |            9 |
|   6 | 1978-01-27 |    298 |           17 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>3×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable     | mean    | min        | median | max        | nmissing | eltype   |
|----:|:-------------|:--------|:-----------|:-------|:-----------|---------:|:---------|
|     | Symbol       | Union…  | Any        | Union… | Any        |    Int64 | DataType |
|   1 | date         |         | 1978-01-22 |        | 1978-02-04 |        0 | Date     |
|   2 | in_bed       | 111.357 | 3          | 72.0   | 298        |        0 | Int64    |
|   3 | convalescent | 66.9286 | 0          | 33.5   | 176        |        0 | Int64    |

</div>
