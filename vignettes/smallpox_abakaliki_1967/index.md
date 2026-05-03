# Smallpox, Abakaliki, Nigeria, 1967


## Overview

This dataset documents 32 cases of smallpox in Abakaliki, Nigeria, in
1967. The outbreak occurred predominantly within a religious community
(Faith Tabernacle Church) whose members refused vaccination and other
medical interventions. The dataset contains 32 rows and 8 columns: case
ID, date of onset, age, gender, vaccination status, vaccination scar,
Faith Tabernacle Church membership, and compound.

## Source

Thompson, D. & Foege, W. (1968). Faith Tabernacle smallpox epidemic,
Abakaliki, Nigeria. *WHO*, 3:1–9.

## Loading the data

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.smallpox_abakaliki_1967()
```

<div><div style = "float: left;"><span>32×8 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>7 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_ID | date_of_onset |   age | gender  | vaccinated | vaccscar | ftc     | compound |
|----:|--------:|:--------------|------:|:--------|:-----------|:---------|:--------|---------:|
|     |   Int64 | Date          | Int64 | String1 | String1    | String1  | String1 |    Int64 |
|   1 |       1 | 1967-04-05    |    10 | f       | n          | n        | y       |        1 |
|   2 |       2 | 1967-04-18    |    25 | f       | n          | n        | y       |        1 |
|   3 |       3 | 1967-04-25    |    35 | m       | n          | n        | y       |        1 |
|   4 |       4 | 1967-04-27    |     4 | f       | n          | n        | y       |        1 |
|   5 |       5 | 1967-04-30    |    11 | m       | n          | n        | y       |        1 |
|   6 |       6 | 1967-04-30    |     1 | m       | n          | n        | y       |        1 |
|   7 |       7 | 1967-04-30    |     4 | f       | n          | n        | y       |        1 |
|   8 |       8 | 1967-05-01    |     8 | f       | y          | n        | y       |        2 |
|   9 |       9 | 1967-05-05    |    12 | m       | y          | y        | y       |        2 |
|  10 |      10 | 1967-05-10    |     2 | m       | n          | n        | y       |        1 |
|  11 |      11 | 1967-05-13    |    35 | m       | n          | n        | y       |        4 |
|  12 |      12 | 1967-05-15    |    28 | f       | n          | n        | y       |        5 |
|  13 |      13 | 1967-05-15    |     3 | m       | n          | n        | y       |        1 |
|   ⋮ |       ⋮ | ⋮             |     ⋮ | ⋮       | ⋮          | ⋮        | ⋮       |        ⋮ |
|  21 |      21 | 1967-05-31    |    26 | f       | y          | n        | n       |        6 |
|  22 |      22 | 1967-05-31    |    35 | m       | y          | y        | y       |        5 |
|  23 |      23 | 1967-06-01    |     2 | f       | n          | n        | y       |        2 |
|  24 |      24 | 1967-06-02    |     2 | m       | n          | n        | y       |        7 |
|  25 |      25 | 1967-06-04    |    11 | f       | n          | n        | y       |        4 |
|  26 |      26 | 1967-06-04    |     1 | f       | n          | n        | y       |        2 |
|  27 |      27 | 1967-06-05    |     3 | m       | n          | n        | y       |        2 |
|  28 |      28 | 1967-06-07    |    40 | m       | y          | n        | n       |        8 |
|  29 |      29 | 1967-06-10    |    28 | f       | n          | n        | y       |        3 |
|  30 |      30 | 1967-06-10    |    27 | m       | n          | n        | y       |        9 |
|  31 |      31 | 1967-06-15    |     9 | f       | n          | n        | y       |        5 |
|  32 |      32 | 1967-06-30    |    35 | m       | y          | y        | y       |        2 |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×8 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_ID | date_of_onset |   age | gender  | vaccinated | vaccscar | ftc     | compound |
|----:|--------:|:--------------|------:|:--------|:-----------|:---------|:--------|---------:|
|     |   Int64 | Date          | Int64 | String1 | String1    | String1  | String1 |    Int64 |
|   1 |       1 | 1967-04-05    |    10 | f       | n          | n        | y       |        1 |
|   2 |       2 | 1967-04-18    |    25 | f       | n          | n        | y       |        1 |
|   3 |       3 | 1967-04-25    |    35 | m       | n          | n        | y       |        1 |
|   4 |       4 | 1967-04-27    |     4 | f       | n          | n        | y       |        1 |
|   5 |       5 | 1967-04-30    |    11 | m       | n          | n        | y       |        1 |
|   6 |       6 | 1967-04-30    |     1 | m       | n          | n        | y       |        1 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>8×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable      | mean    | min        | median | max        | nmissing | eltype   |
|----:|:--------------|:--------|:-----------|:-------|:-----------|---------:|:---------|
|     | Symbol        | Union…  | Any        | Union… | Any        |    Int64 | DataType |
|   1 | case_ID       | 16.5    | 1          | 16.5   | 32         |        0 | Int64    |
|   2 | date_of_onset |         | 1967-04-05 |        | 1967-06-30 |        0 | Date     |
|   3 | age           | 14.0938 | 1          | 9.5    | 40         |        0 | Int64    |
|   4 | gender        |         | f          |        | m          |        0 | String1  |
|   5 | vaccinated    |         | n          |        | y          |        0 | String1  |
|   6 | vaccscar      |         | n          |        | y          |        0 | String1  |
|   7 | ftc           |         | n          |        | y          |        0 | String1  |
|   8 | compound      | 2.8125  | 1          | 2.0    | 9          |        0 | Int64    |

</div>
