# Simulated Ebola Outbreak


## Overview

This is a simulated Ebola Virus Disease outbreak dataset, designed with
properties mimicking the West African 2014–2015 epidemic. Created by
Pierre Nouvellet as a teaching resource, it contains intentional data
quality issues (e.g., negative incubation periods from erroneous date
entries) to illustrate real-world data cleaning challenges. A cleaned
version (`ebola_sim_clean`) with erroneous dates removed is also
provided.

The dataset is a `NamedTuple` with two components: a **linelist** of
cases and a **contacts** tracing DataFrame.

## Loading the data

``` julia
using DataFrames
using Outbreaks
data = Outbreaks.ebola_sim()
linelist = data.linelist
contacts = data.contacts
println("Linelist: $(size(linelist))")
println("Contacts: $(size(contacts))")
```

    Linelist: (5888, 11)
    Contacts: (3800, 3)

## Linelist — first few rows

``` julia
first(linelist, 6)
```

<div><div style = "float: left;"><span>6×11 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_id | generation | date_of_infection | date_of_onset | date_of_hospitalisation | date_of_outcome | outcome | gender | hospital | lon | lat |
|---:|:---|---:|:---|:---|:---|:---|:---|:---|:---|---:|---:|
|  | String7 | Int64 | String15 | Date | Date | String15 | String7 | String1 | String | Float64 | Float64 |
| 1 | d1fafd | 0 | NA | 2014-04-07 | 2014-04-17 | 2014-04-19 | NA | f | Military Hospital | -13.218 | 8.47351 |
| 2 | 53371b | 1 | 2014-04-09 | 2014-04-15 | 2014-04-20 | NA | NA | m | Connaught Hospital | -13.2149 | 8.46493 |
| 3 | f5c3d8 | 1 | 2014-04-18 | 2014-04-21 | 2014-04-25 | 2014-04-30 | Recover | f | other | -13.228 | 8.48336 |
| 4 | 6c286a | 2 | NA | 2014-04-27 | 2014-04-27 | 2014-05-07 | Death | f | NA | -13.2311 | 8.46478 |
| 5 | 0f58c4 | 2 | 2014-04-22 | 2014-04-26 | 2014-04-29 | 2014-05-17 | Recover | f | other | -13.2102 | 8.45214 |
| 6 | 49731d | 0 | 2014-03-19 | 2014-04-25 | 2014-05-02 | 2014-05-07 | NA | f | NA | -13.2344 | 8.46857 |

</div>

## Linelist summary

``` julia
describe(linelist)
```

<div><div style = "float: left;"><span>11×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Any | Any | Int64 | DataType |
| 1 | case_id |  | 00031d |  | fffc9d | 0 | String7 |
| 2 | generation | 16.5617 | 0 | 16.0 | 37 | 0 | Int64 |
| 3 | date_of_infection |  | 2014-03-19 |  | NA | 0 | String15 |
| 4 | date_of_onset |  | 2014-04-07 | 2014-10-21 | 2015-04-30 | 0 | Date |
| 5 | date_of_hospitalisation |  | 2014-04-17 | 2014-10-23 | 2015-04-30 | 0 | Date |
| 6 | date_of_outcome |  | 2014-04-19 |  | NA | 0 | String15 |
| 7 | outcome |  | Death |  | Recover | 0 | String7 |
| 8 | gender |  | f |  | m | 0 | String1 |
| 9 | hospital |  | Connaught Hopital |  | other | 0 | String |
| 10 | lon | -13.2338 | -13.2728 | -13.2291 | -13.2052 | 0 | Float64 |
| 11 | lat | 8.46964 | 8.44621 | 8.46899 | 8.49175 | 0 | Float64 |

</div>

## Contacts — first few rows

``` julia
first(contacts, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | infector | case_id | source  |
|----:|:---------|:--------|:--------|
|     | String7  | String7 | String7 |
|   1 | d1fafd   | 53371b  | other   |
|   2 | cac51e   | f5c3d8  | funeral |
|   3 | f5c3d8   | 0f58c4  | other   |
|   4 | 0f58c4   | 881bd4  | other   |
|   5 | 8508df   | 40ae5f  | other   |
|   6 | 127d83   | f547d6  | funeral |

</div>

## Cleaned version

``` julia
clean = Outbreaks.ebola_sim_clean()
clean_ll = clean.linelist
println("Raw linelist rows: $(nrow(linelist))")
println("Cleaned linelist rows: $(nrow(clean_ll))")
println("Rows removed: $(nrow(linelist) - nrow(clean_ll))")
```

    Raw linelist rows: 5888
    Cleaned linelist rows: 5829
    Rows removed: 59

## Epidemic curve

``` julia
using Dates
onset = dropmissing(clean_ll, :date_of_onset)
sort!(onset, :date_of_onset)
weekly = combine(groupby(transform(onset, :date_of_onset => (x -> x .- Dates.Day.(Dates.dayofweek.(x) .- 1)) => :week_start), :week_start), nrow => :cases)
sort!(weekly, :week_start)
for row in eachrow(weekly)
    bar = repeat("█", max(1, round(Int, row.cases / 2)))
    println("$(row.week_start) | $bar $(row.cases)")
end
```

    2014-04-07 | █ 1
    2014-04-14 | █ 1
    2014-04-21 | ██ 5
    2014-04-28 | ██ 4
    2014-05-05 | ██████ 12
    2014-05-12 | ████████ 17
    2014-05-19 | ████████ 15
    2014-05-26 | ██████████ 19
    2014-06-02 | ████████████ 23
    2014-06-09 | ██████████ 21
    2014-06-16 | ███████████████ 30
    2014-06-23 | ███████████ 22
    2014-06-30 | █████████████████ 34
    2014-07-07 | ███████████████████ 38
    2014-07-14 | ██████████████████████████████ 61
    2014-07-21 | ██████████████████████████████ 59
    2014-07-28 | ████████████████████████████████████████ 80
    2014-08-04 | ███████████████████████████████████████████ 86
    2014-08-11 | ██████████████████████████████████████████████████████████ 116
    2014-08-18 | ██████████████████████████████████████████████████████████████████████ 139
    2014-08-25 | ████████████████████████████████████████████████████████████████████████████████ 161
    2014-09-01 | ████████████████████████████████████████████████████████████████████████████████████████████████████████ 208
    2014-09-08 | ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 233
    2014-09-15 | ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 325
    2014-09-22 | █████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 290
    2014-09-29 | ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 307
    2014-10-06 | ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 275
    2014-10-13 | ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 264
    2014-10-20 | ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 264
    2014-10-27 | ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 253
    2014-11-03 | ██████████████████████████████████████████████████████████████████████████████████████████████████████████ 212
    2014-11-10 | ██████████████████████████████████████████████████████████████████████████████████████████ 179
    2014-11-17 | ██████████████████████████████████████████████████████████████████████████ 149
    2014-11-24 | ██████████████████████████████████████████████████████████████████████████████████ 163
    2014-12-01 | ██████████████████████████████████████████████████████████████████████████████ 156
    2014-12-08 | ████████████████████████████████████████████████████████████████ 127
    2014-12-15 | █████████████████████████████████████████████████████████████ 122
    2014-12-22 | ██████████████████████████████████████████████████████████ 117
    2014-12-29 | ██████████████████████████████████████████████ 93
    2015-01-05 | ██████████████████████████████████████████████████ 101
    2015-01-12 | ██████████████████████████████████████████████████████ 108
    2015-01-19 | ████████████████████████████████████████████████ 95
    2015-01-26 | ██████████████████████████████████████████ 85
    2015-02-02 | █████████████████████████████████████████ 82
    2015-02-09 | █████████████████████████████████ 66
    2015-02-16 | █████████████████████████████████████████ 82
    2015-02-23 | ███████████████████████████████████████ 78
    2015-03-02 | ████████████████████████████████████ 73
    2015-03-09 | ████████████████████████████████ 65
    2015-03-16 | ████████████████████████████████ 63
    2015-03-23 | ██████████████████████████ 51
    2015-03-30 | ███████████████████████████ 54
    2015-04-06 | █████████████████████ 42
    2015-04-13 | ██████████████████████ 44
    2015-04-20 | ████████████████████ 40
    2015-04-27 | ██████████ 19
