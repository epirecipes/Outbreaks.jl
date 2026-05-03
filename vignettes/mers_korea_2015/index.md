# MERS-CoV, South Korea, 2015


## Overview

This dataset describes the 2015 outbreak of Middle East Respiratory
Syndrome Coronavirus (MERS-CoV) in South Korea. The outbreak was the
largest outside the Middle East, driven by nosocomial transmission in
healthcare facilities. The data include a linelist of cases and a
contact network linking transmission pairs.

## Source

European Centre for Disease Prevention and Control (ECDC).

## Data

The dataset is returned as a `NamedTuple` with two DataFrames:

- **linelist** (cases): id, age, age_class, sex, place_infect,
  reporting_ctry, loc_hosp, dt_onset, dt_report, week_report,
  dt_start_exp, dt_end_exp, dt_diag, outcome, dt_death
- **contacts** (transmission pairs): from, to, exposure, diff_dt_onset

``` julia
using Outbreaks
using DataFrames
data = Outbreaks.mers_korea_2015()
linelist = data.linelist
contacts = data.contacts
```

<div><div style = "float: left;"><span>98×4 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>73 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | from    | to      | exposure       | diff_dt_onset |
|----:|:--------|:--------|:---------------|--------------:|
|     | String7 | String7 | String31       |         Int64 |
|   1 | SK_14   | SK_113  | Emergency room |            10 |
|   2 | SK_14   | SK_116  | Emergency room |            13 |
|   3 | SK_14   | SK_41   | Emergency room |            14 |
|   4 | SK_14   | SK_112  | Emergency room |            14 |
|   5 | SK_14   | SK_100  | Emergency room |            15 |
|   6 | SK_14   | SK_114  | Emergency room |            15 |
|   7 | SK_14   | SK_136  | Emergency room |            15 |
|   8 | SK_14   | SK_47   | Emergency room |            16 |
|   9 | SK_14   | SK_110  | Emergency room |            16 |
|  10 | SK_14   | SK_122  | Emergency room |            16 |
|  11 | SK_14   | SK_120  | Emergency room |            17 |
|  12 | SK_14   | SK_98   | Emergency room |            18 |
|  13 | SK_14   | SK_102  | Emergency room |            18 |
|   ⋮ | ⋮       | ⋮       | ⋮              |             ⋮ |
|  87 | SK_1    | SK_10   | Visit hospital |            10 |
|  88 | SK_1    | SK_13   | Visit hospital |            10 |
|  89 | SK_1    | SK_26   | Visit hospital |            10 |
|  90 | SK_1    | SK_33   | Visit hospital |            10 |
|  91 | SK_1    | SK_17   | Visit hospital |            11 |
|  92 | SK_1    | SK_21   | Visit hospital |            12 |
|  93 | SK_1    | SK_32   | Visit hospital |            12 |
|  94 | SK_1    | SK_15   | Visit hospital |            13 |
|  95 | SK_1    | SK_4    | Visit hospital |            14 |
|  96 | SK_1    | SK_22   | Visit hospital |            16 |
|  97 | SK_1    | SK_19   | Visit hospital |            17 |
|  98 | SK_1    | SK_28   | Visit hospital |            18 |

</div>

### Linelist

``` julia
first(linelist, 6)
```

<div><div style = "float: left;"><span>6×15 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | id | age | age_class | sex | place_infect | reporting_ctry | loc_hosp | dt_onset | dt_report | week_report | dt_start_exp | dt_end_exp | dt_diag | outcome | dt_death |
|---:|:---|---:|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
|  | String7 | Int64 | String7 | String1 | String31 | String15 | String | String15 | Date | String7 | String15 | String15 | Date | String7 | String15 |
| 1 | SK_1 | 68 | 60-69 | M | Middle East | South Korea | Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi | 2015-05-11 | 2015-05-19 | 2015_21 | 2015-04-18 | 2015-05-04 | 2015-05-20 | Alive | NA |
| 2 | SK_2 | 63 | 60-69 | F | Outside Middle East | South Korea | Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi | 2015-05-18 | 2015-05-20 | 2015_21 | 2015-05-15 | 2015-05-20 | 2015-05-20 | Alive | NA |
| 3 | SK_3 | 76 | 70-79 | M | Outside Middle East | South Korea | Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi | 2015-05-20 | 2015-05-20 | 2015_21 | 2015-05-16 | 2015-05-16 | 2015-05-21 | Dead | 2015-06-04 |
| 4 | SK_4 | 46 | 40-49 | F | Outside Middle East | South Korea | Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi | 2015-05-25 | 2015-05-26 | 2015_22 | 2015-05-16 | 2015-05-20 | 2015-05-26 | Alive | NA |
| 5 | SK_5 | 50 | 50-59 | M | Outside Middle East | South Korea | 365 Yeollin Clinic, Seoul | 2015-05-25 | 2015-05-27 | 2015_22 | 2015-05-17 | 2015-05-17 | 2015-05-26 | Alive | NA |
| 6 | SK_6 | 71 | 70-79 | M | Outside Middle East | South Korea | Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi | 2015-05-24 | 2015-05-28 | 2015_22 | 2015-05-15 | 2015-05-17 | 2015-05-28 | Dead | 2015-06-01 |

</div>

``` julia
describe(linelist)
```

<div><div style = "float: left;"><span>15×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Any | Any | Int64 | DataType |
| 1 | id |  | SK_1 |  | SK_99 | 0 | String7 |
| 2 | age | 55.321 | 16 | 56.0 | 87 | 0 | Int64 |
| 3 | age_class |  | 10-20 |  | 80-89 | 0 | String7 |
| 4 | sex |  | F |  | M | 0 | String1 |
| 5 | place_infect |  | Middle East |  | Outside Middle East | 0 | String31 |
| 6 | reporting_ctry |  | China |  | South Korea | 0 | String15 |
| 7 | loc_hosp |  | 365 Yeollin Clinic, Seoul |  | Seoul Clinic, Asan, Chungcheongnam | 0 | String |
| 8 | dt_onset |  | 2015-05-11 |  | NA | 0 | String15 |
| 9 | dt_report |  | 2015-05-19 | 2015-06-07 | 2015-06-16 | 0 | Date |
| 10 | week_report |  | 2015_21 |  | 2015_25 | 0 | String7 |
| 11 | dt_start_exp |  | 2015-04-18 |  | NA | 0 | String15 |
| 12 | dt_end_exp |  | 2015-05-04 |  | NA | 0 | String15 |
| 13 | dt_diag |  | 2015-05-20 | 2015-06-07 | 2015-06-16 | 0 | Date |
| 14 | outcome |  | Alive |  | Dead | 0 | String7 |
| 15 | dt_death |  | 2015-06-01 |  | NA | 0 | String15 |

</div>

### Contacts

``` julia
first(contacts, 6)
```

<div><div style = "float: left;"><span>6×4 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | from    | to      | exposure       | diff_dt_onset |
|----:|:--------|:--------|:---------------|--------------:|
|     | String7 | String7 | String31       |         Int64 |
|   1 | SK_14   | SK_113  | Emergency room |            10 |
|   2 | SK_14   | SK_116  | Emergency room |            13 |
|   3 | SK_14   | SK_41   | Emergency room |            14 |
|   4 | SK_14   | SK_112  | Emergency room |            14 |
|   5 | SK_14   | SK_100  | Emergency room |            15 |
|   6 | SK_14   | SK_114  | Emergency room |            15 |

</div>

``` julia
describe(contacts)
```

<div><div style = "float: left;"><span>4×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Union… | Any | Int64 | DataType |
| 1 | from |  | SK_1 |  | SK_87 | 0 | String7 |
| 2 | to |  | SK_10 |  | SK_98 | 0 | String7 |
| 3 | exposure |  | Contact with HCW |  | Visit hospital | 0 | String31 |
| 4 | diff_dt_onset | 14.4694 | 2 | 14.0 | 27 | 0 | Int64 |

</div>
