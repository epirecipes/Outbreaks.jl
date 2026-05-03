# Nipah Virus, Malaysia and Singapore, 1997–1999


## Overview

This dataset records weekly case counts of Nipah virus encephalitis
during the 1997–1999 outbreak in Malaysia and Singapore. The outbreak
resulted in 257 human cases, primarily among pig farmers. Transmission
occurred via a zoonotic spillover pathway from fruit bats to pigs, and
then from pigs to humans.

## Source

Pulliam et al. (2011).

## Data

The dataset contains 49 rows and 5 columns of weekly case counts by
region:

- **date**: week of report
- **perak**: cases in Perak state
- **negeri_sembilan**: cases in Negeri Sembilan state
- **selangor**: cases in Selangor state
- **singapore**: cases in Singapore

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.nipah_malaysia()
first(df, 6)
```

<div><div style = "float: left;"><span>6×5 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | perak | negeri_sembilan | selangor | singapore |
|----:|:-----------|------:|----------------:|---------:|----------:|
|     | Date       | Int64 |           Int64 |    Int64 |     Int64 |
|   1 | 1997-01-04 |     0 |               0 |        0 |         0 |
|   2 | 1997-01-11 |     1 |               0 |        0 |         0 |
|   3 | 1997-01-18 |     0 |               0 |        0 |         0 |
|   4 | 1997-01-25 |     1 |               0 |        0 |         0 |
|   5 | 1997-02-01 |     1 |               0 |        0 |         0 |
|   6 | 1997-02-08 |     0 |               0 |        0 |         0 |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>5×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable        | mean     | min        | median     | max        | nmissing | eltype   |
|----:|:----------------|:---------|:-----------|:-----------|:-----------|---------:|:---------|
|     | Symbol          | Union…   | Any        | Any        | Any        |    Int64 | DataType |
|   1 | date            |          | 1997-01-04 | 1997-08-16 | 1999-04-10 |        0 | Date     |
|   2 | perak           | 0.734694 | 0          | 0.0        | 4          |        0 | Int64    |
|   3 | negeri_sembilan | 4.18367  | 0          | 0.0        | 49         |        0 | Int64    |
|   4 | selangor        | 0.102041 | 0          | 0.0        | 3          |        0 | Int64    |
|   5 | singapore       | 0.22449  | 0          | 0.0        | 11         |        0 | Int64    |

</div>
