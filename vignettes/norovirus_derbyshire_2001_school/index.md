# Norovirus, Primary School, Derbyshire, England, 2001


## Overview

This dataset describes a norovirus outbreak at a primary school in
Derbyshire, England, in 2001. Of 492 children in the school, 186 were
absent with gastrointestinal symptoms. The data include individual-level
records of illness onset, duration, and school class membership.

## Source

O’Neill & Marks (2005). Bayesian model selection and parameter
estimation for a norovirus outbreak using a school absenteeism dataset.
*Statistics in Medicine* 24(13):2011–24.

## Data

The dataset contains 492 rows and 5 columns:

- **class**: school class of the child
- **day_absent**: day of absence
- **start_illness**: day of illness onset
- **end_illness**: day illness ended
- **day_vomiting**: day of vomiting

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.norovirus_derbyshire_2001_school()
first(df, 6)
```

<div><div style = "float: left;"><span>6×5 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | class | day_absent | start_illness | end_illness | day_vomiting |
|----:|------:|-----------:|--------------:|------------:|-------------:|
|     | Int64 |      Int64 |         Int64 |       Int64 |        Int64 |
|   1 |     1 |         23 |             0 |           0 |            0 |
|   2 |     1 |          0 |             0 |           0 |            0 |
|   3 |     1 |          0 |             0 |           0 |            0 |
|   4 |     1 |          0 |             0 |           0 |            0 |
|   5 |     1 |          0 |             0 |           0 |            0 |
|   6 |     1 |          0 |             0 |           0 |            0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>5×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable      |     mean |   min |  median |   max | nmissing | eltype   |
|----:|:--------------|---------:|------:|--------:|------:|---------:|:---------|
|     | Symbol        |  Float64 | Int64 | Float64 | Int64 |    Int64 | DataType |
|   1 | class         |   7.0061 |     1 |     7.0 |    15 |        0 | Int64    |
|   2 | day_absent    |  6.91667 |     0 |     0.0 |    23 |        0 | Int64    |
|   3 | start_illness |  2.70935 |     0 |     0.0 |    28 |        0 | Int64    |
|   4 | end_illness   |  3.06098 |     0 |     0.0 |    30 |        0 | Int64    |
|   5 | day_vomiting  | 0.461382 |     0 |     0.0 |    28 |        0 | Int64    |

</div>
