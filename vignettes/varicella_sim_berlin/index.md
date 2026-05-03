# Simulated Varicella Outbreak, Berlin, 2015


## Overview

This is a simulated dataset of a varicella (chickenpox) outbreak based
on conditions in asylum seeker centers in Berlin, Germany, in 2015. The
dataset contains 500 rows and 13 columns including demographic
information (sex, ethnicity, name, age), center assignments with arrival
and departure dates, and disease onset date.

## Source

Jakob Schumacher; generated using the `outbreakcreator` package.

## Loading the data

``` julia
using Outbreaks
using DataFrames
df = Outbreaks.varicella_sim_berlin()
```

<div><div style = "float: left;"><span>500×13 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>475 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | sex | ethnicity | firstname | lastname | age | center1 | arrival1 | leave1 | center2 | arrival2 | leave2 | onset | disease |
|---:|:---|:---|:---|:---|---:|:---|:---|:---|:---|:---|:---|:---|:---|
|  | String7 | String15 | String15 | String31 | Int64 | String31 | Date | Date | String31 | Date | Date | String15 | String15 |
| 1 | female | arabic | Saleema | al-Ismael | 16 | Oranienburger Str | 2015-05-06 | 2015-06-20 | Bizetstr | 2015-06-27 | 2015-08-19 | NA | NA |
| 2 | male | hispanic | Domonic | Jaramillo | 25 | Platz der Luftbruecke | 2015-01-19 | 2015-01-21 | Bizetstr | 2015-01-30 | 2015-03-02 | NA | NA |
| 3 | female | arabic | Haaniya | el-Mitri | 34 | Platz der Luftbruecke | 2015-04-11 | 2015-07-09 | Platz der Luftbruecke | 2015-07-18 | 2015-10-03 | 2015-07-06 | varicella |
| 4 | female | asian | Erica | Tanghal | 11 | Platz der Luftbruecke | 2015-01-20 | 2015-03-30 | Oranienburger Str | 2015-04-08 | 2015-07-13 | 2015-08-20 | varicella |
| 5 | male | asian | Fermin Joshua | Kikuchi | 34 | Platz der Luftbruecke | 2015-06-15 | 2015-08-17 | Platz der Luftbruecke | 2015-08-22 | 2015-11-01 | NA | NA |
| 6 | male | arabic | Muslim | al-Moussa | 5 | Bizetstr | 2014-11-18 | 2015-02-03 | Platz der Luftbruecke | 2015-02-17 | 2015-04-27 | NA | NA |
| 7 | male | arabic | Abdul Baari | al-Ozer | 35 | Oranienburger Str | 2015-07-19 | 2015-10-28 | Oranienburger Str | 2015-11-06 | 2015-11-09 | NA | NA |
| 8 | female | arabic | Wadha | el-Dia | 11 | Platz der Luftbruecke | 2015-02-15 | 2015-04-10 | Platz der Luftbruecke | 2015-04-16 | 2015-06-08 | 2015-06-24 | varicella |
| 9 | male | asian | Binh | Kaneko | 13 | Bizetstr | 2015-05-06 | 2015-06-23 | Bizetstr | 2015-06-29 | 2015-08-28 | 2015-03-16 | varicella |
| 10 | female | native-american | Ruby | Cook | 15 | Platz der Luftbruecke | 2014-12-15 | 2015-01-07 | Bizetstr | 2015-01-13 | 2015-01-16 | NA | NA |
| 11 | female | asian | Kelyn | Maranto | 1 | Platz der Luftbruecke | 2015-05-19 | 2015-06-29 | Platz der Luftbruecke | 2015-07-11 | 2015-09-10 | NA | NA |
| 12 | male | caucasian | Aaron | Arendall | 3 | Platz der Luftbruecke | 2014-12-30 | 2015-02-17 | Platz der Luftbruecke | 2015-03-02 | 2015-03-14 | NA | NA |
| 13 | male | hispanic | Trey | Munoz | 7 | Oranienburger Str | 2015-05-16 | 2015-07-04 | Bizetstr | 2015-07-18 | 2015-08-11 | NA | NA |
| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |
| 489 | female | caucasian | Christina | Arnold | 24 | Oranienburger Str | 2015-07-08 | 2015-08-23 | Platz der Luftbruecke | 2015-09-06 | 2015-11-03 | NA | NA |
| 490 | female | arabic | Adeeba | el-Yousif | 10 | Platz der Luftbruecke | 2015-01-01 | 2015-03-18 | Platz der Luftbruecke | 2015-04-02 | 2015-07-17 | 2015-06-26 | varicella |
| 491 | female | african | Desiree | Mack-Lynch | 17 | Oranienburger Str | 2015-06-06 | 2015-05-18 | Buchholzerstr | 2015-06-02 | 2015-06-09 | 2015-03-01 | varicella |
| 492 | male | african | Richard | Devine | 24 | Oranienburger Str | 2014-12-10 | 2015-03-12 | Bizetstr | 2015-03-18 | 2015-04-07 | 2015-08-02 | varicella |
| 493 | male | arabic | Zaamil | al-Mohammad | 28 | Bizetstr | 2015-08-09 | 2015-09-18 | Bizetstr | 2015-09-24 | 2015-10-18 | NA | NA |
| 494 | male | arabic | Abdul Haadi | el-Quadri | 1 | Oranienburger Str | 2015-02-19 | 2015-03-16 | Platz der Luftbruecke | 2015-03-24 | 2015-05-10 | NA | NA |
| 495 | male | asian | Raja | Pang | 21 | Bizetstr | 2015-04-09 | 2015-05-02 | Platz der Luftbruecke | 2015-05-10 | 2015-07-29 | 2015-03-30 | varicella |
| 496 | male | asian | Wing | Richy | 18 | Oranienburger Str | 2014-11-17 | 2014-12-27 | Platz der Luftbruecke | 2015-01-10 | 2015-03-07 | NA | NA |
| 497 | male | african | Matthew | Lollis | 28 | Platz der Luftbruecke | 2015-04-29 | 2015-06-19 | Platz der Luftbruecke | 2015-06-25 | 2015-09-23 | 2015-06-18 | varicella |
| 498 | female | asian | Megha | Fujinami | 9 | Platz der Luftbruecke | 2015-06-25 | 2015-06-25 | Oranienburger Str | 2015-07-08 | 2015-09-21 | NA | NA |
| 499 | female | arabic | Awaatif | al-Harron | 24 | Oranienburger Str | 2015-04-12 | 2015-05-17 | Oranienburger Str | 2015-05-28 | 2015-08-04 | 2015-09-03 | varicella |
| 500 | female | african | Jazmine | Faulkner | 15 | Oranienburger Str | 2015-01-18 | 2015-02-13 | Oranienburger Str | 2015-02-19 | 2015-04-26 | NA | NA |

</div>

## First few rows

``` julia
first(df, 6)
```

<div><div style = "float: left;"><span>6×13 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | sex | ethnicity | firstname | lastname | age | center1 | arrival1 | leave1 | center2 | arrival2 | leave2 | onset | disease |
|---:|:---|:---|:---|:---|---:|:---|:---|:---|:---|:---|:---|:---|:---|
|  | String7 | String15 | String15 | String31 | Int64 | String31 | Date | Date | String31 | Date | Date | String15 | String15 |
| 1 | female | arabic | Saleema | al-Ismael | 16 | Oranienburger Str | 2015-05-06 | 2015-06-20 | Bizetstr | 2015-06-27 | 2015-08-19 | NA | NA |
| 2 | male | hispanic | Domonic | Jaramillo | 25 | Platz der Luftbruecke | 2015-01-19 | 2015-01-21 | Bizetstr | 2015-01-30 | 2015-03-02 | NA | NA |
| 3 | female | arabic | Haaniya | el-Mitri | 34 | Platz der Luftbruecke | 2015-04-11 | 2015-07-09 | Platz der Luftbruecke | 2015-07-18 | 2015-10-03 | 2015-07-06 | varicella |
| 4 | female | asian | Erica | Tanghal | 11 | Platz der Luftbruecke | 2015-01-20 | 2015-03-30 | Oranienburger Str | 2015-04-08 | 2015-07-13 | 2015-08-20 | varicella |
| 5 | male | asian | Fermin Joshua | Kikuchi | 34 | Platz der Luftbruecke | 2015-06-15 | 2015-08-17 | Platz der Luftbruecke | 2015-08-22 | 2015-11-01 | NA | NA |
| 6 | male | arabic | Muslim | al-Moussa | 5 | Bizetstr | 2014-11-18 | 2015-02-03 | Platz der Luftbruecke | 2015-02-17 | 2015-04-27 | NA | NA |

</div>

## Summary statistics

``` julia
describe(df)
```

<div><div style = "float: left;"><span>13×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean | min | median | max | nmissing | eltype |
|---:|:---|:---|:---|:---|:---|---:|:---|
|  | Symbol | Union… | Any | Any | Any | Int64 | DataType |
| 1 | sex |  | female |  | male | 0 | String7 |
| 2 | ethnicity |  | african |  | native-american | 0 | String15 |
| 3 | firstname |  | Aabdeen |  | Zumruda | 0 | String15 |
| 4 | lastname |  | Absher |  | el-Zaki | 0 | String31 |
| 5 | age | 16.95 | 0 | 17.0 | 35 | 0 | Int64 |
| 6 | center1 |  | Bizetstr |  | Platz der Luftbruecke | 0 | String31 |
| 7 | arrival1 |  | 2014-10-26 | 2015-04-02 | 2015-10-06 | 0 | Date |
| 8 | leave1 |  | 2014-10-29 | 2015-05-13 | 2015-12-17 | 0 | Date |
| 9 | center2 |  | Bizetstr |  | Platz der Luftbruecke | 0 | String31 |
| 10 | arrival2 |  | 2014-11-06 | 2015-05-23 | 2015-12-23 | 0 | Date |
| 11 | leave2 |  | 2014-12-03 | 2015-07-07 | 2016-02-22 | 0 | Date |
| 12 | onset |  | 2015-01-06 |  | NA | 0 | String15 |
| 13 | disease |  | NA |  | varicella | 0 | String15 |

</div>
