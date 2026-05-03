# Ebola, Kikwit, DRC, 1995


## Overview

This dataset describes the 1995 Ebola haemorrhagic fever outbreak in
Kikwit, Democratic Republic of the Congo (then Zaire). The outbreak
resulted in 316 total cases and 236 deaths (75% case fatality rate). The
dataset records daily case onset counts, deaths, and reporting dates.

**Source:** Khan AS, Tshioko FK, Heymann DL, Le Guenno B, Nabeth P,
Kerstiëns B, et al. (1999). The reemergence of Ebola hemorrhagic fever,
Democratic Republic of the Congo, 1995. *Journal of Infectious Diseases*
179(Suppl 1):S76–S86.

## Loading the data

``` julia
using DataFrames
using Outbreaks
df = Outbreaks.ebola_kikwit_1995()
size(df)
```

    (192, 4)

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×4 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | date       | onset | death | reporting |
|----:|:-----------|------:|------:|----------:|
|     | Date       | Int64 | Int64 |      Bool |
|   1 | 1995-01-06 |     1 |     0 |      true |
|   2 | 1995-01-07 |     0 |     0 |     false |
|   3 | 1995-01-08 |     0 |     0 |     false |
|   4 | 1995-01-09 |     0 |     0 |     false |
|   5 | 1995-01-10 |     0 |     0 |     false |
|   6 | 1995-01-11 |     0 |     0 |     false |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>4×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable  | mean     | min        | median | max        | nmissing | eltype   |
|----:|:----------|:---------|:-----------|:-------|:-----------|---------:|:---------|
|     | Symbol    | Union…   | Any        | Union… | Any        |    Int64 | DataType |
|   1 | date      |          | 1995-01-06 |        | 1995-07-16 |        0 | Date     |
|   2 | onset     | 1.52083  | 0          | 0.0    | 15         |        0 | Int64    |
|   3 | death     | 1.22917  | 0          | 0.0    | 14         |        0 | Int64    |
|   4 | reporting | 0.723958 | false      | 1.0    | true       |        0 | Bool     |

</div>

## Epidemic curve

``` julia
sort!(df, :date)
println("Date range: $(minimum(df.date)) to $(maximum(df.date))")
println("Total onset cases: $(sum(df.onset))")
println("Total deaths: $(sum(df.death))")
for row in eachrow(df)
    if row.onset > 0
        bar = repeat("█", min(row.onset, 60))
        println("$(row.date) | $bar $(row.onset)")
    end
end
```

    Date range: 1995-01-06 to 1995-07-16
    Total onset cases: 292
    Total deaths: 236
    1995-01-06 | █ 1
    1995-03-06 | █ 1
    1995-03-07 | █ 1
    1995-03-08 | █ 1
    1995-03-13 | ███ 3
    1995-03-17 | █ 1
    1995-03-18 | █ 1
    1995-03-20 | █ 1
    1995-03-22 | ██ 2
    1995-03-24 | █ 1
    1995-04-01 | ██ 2
    1995-04-03 | █ 1
    1995-04-04 | █ 1
    1995-04-05 | ██ 2
    1995-04-06 | █ 1
    1995-04-08 | █ 1
    1995-04-09 | █ 1
    1995-04-10 | █ 1
    1995-04-11 | █ 1
    1995-04-12 | █ 1
    1995-04-13 | █ 1
    1995-04-14 | ███ 3
    1995-04-16 | ████ 4
    1995-04-17 | ████ 4
    1995-04-18 | █ 1
    1995-04-19 | ██ 2
    1995-04-20 | ████ 4
    1995-04-21 | ██ 2
    1995-04-22 | █ 1
    1995-04-23 | ███████ 7
    1995-04-24 | ████ 4
    1995-04-25 | ████ 4
    1995-04-26 | ██ 2
    1995-04-27 | ████ 4
    1995-04-28 | █████ 5
    1995-04-29 | ███ 3
    1995-04-30 | ███████████ 11
    1995-05-01 | ████████████ 12
    1995-05-02 | ███████████████ 15
    1995-05-03 | ███████ 7
    1995-05-04 | ███████ 7
    1995-05-05 | ████████ 8
    1995-05-06 | ██ 2
    1995-05-07 | █████ 5
    1995-05-08 | ████████ 8
    1995-05-09 | ██████ 6
    1995-05-10 | ████████ 8
    1995-05-11 | ███ 3
    1995-05-12 | ████ 4
    1995-05-13 | ███████ 7
    1995-05-14 | ███████████ 11
    1995-05-15 | ███ 3
    1995-05-16 | ████████████ 12
    1995-05-17 | █████ 5
    1995-05-18 | ████████ 8
    1995-05-19 | ███ 3
    1995-05-20 | ███ 3
    1995-05-21 | ████████ 8
    1995-05-22 | ████ 4
    1995-05-23 | █████ 5
    1995-05-24 | █ 1
    1995-05-25 | ███ 3
    1995-05-26 | ████ 4
    1995-05-27 | ███ 3
    1995-05-28 | █ 1
    1995-05-29 | ██ 2
    1995-05-30 | ███ 3
    1995-05-31 | █ 1
    1995-06-01 | ███ 3
    1995-06-02 | ███ 3
    1995-06-03 | ████ 4
    1995-06-04 | ███ 3
    1995-06-05 | █████ 5
    1995-06-06 | ██ 2
    1995-06-07 | ██ 2
    1995-06-08 | █ 1
    1995-06-10 | ██ 2
    1995-06-13 | ██ 2
    1995-06-17 | ██ 2
    1995-06-18 | ██ 2
    1995-06-20 | █ 1
    1995-07-12 | █ 1
