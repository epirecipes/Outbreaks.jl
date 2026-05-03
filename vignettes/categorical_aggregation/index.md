# Categorical Aggregation with Catlab.jl


## Overview

This vignette demonstrates the Outbreaks.jl Catlab extension, which
provides a category-theoretic framework for aggregating line list data.
The key insight: aggregation decomposes into three morphisms — onset
assignment, temporal binning, and decategorification (counting) — with
information loss occurring *only* at the final step.

The extension provides:

- **`LineListACSet`**: Convert a DataFrame to a categorical
  representation
- **`↓` (aggregate)**: Coarsen temporal resolution via a surjective
  `FinFunction`
- **`♯` (decategorify)**: Count fibers to produce an epidemic curve
- **`⊗` (tensor product)**: Stratify by multiple scales simultaneously
- **`fibers`**: Inspect which cases fall in each bin
  (pre-decategorification)
- **`coarsen`**: Functorial composition of binning maps

## Setup

``` julia
using Outbreaks
using Catlab
using DataFrames
```

## Loading data

We use the Hagelloch measles dataset (188 cases, 1861) which has onset
dates and school class membership — ideal for demonstrating temporal and
stratified aggregation.

``` julia
df = measles_hagelloch_1861()
println("$(nrow(df)) cases, $(ncol(df)) columns")
first(df, 5)
```

    188 cases, 12 columns

<div><div style = "float: left;"><span>5×12 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_ID | infector | date_of_prodrome | date_of_rash | date_of_death | age | gender | family_ID | class | complications | x_loc | y_loc |
|---:|---:|:---|:---|:---|:---|---:|:---|---:|---:|:---|---:|---:|
|  | Int64 | String3 | Date | Date | String15 | Int64 | String3 | Int64 | Int64 | String3 | Float64 | Float64 |
| 1 | 1 | 45 | 1861-11-21 | 1861-11-25 | NA | 7 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 2 | 2 | 45 | 1861-11-23 | 1861-11-27 | NA | 6 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 3 | 3 | 172 | 1861-11-28 | 1861-12-02 | NA | 4 | f | 41 | 0 | yes | 142.5 | 100.0 |
| 4 | 4 | 180 | 1861-11-27 | 1861-11-28 | NA | 13 | m | 61 | 2 | yes | 165.0 | 102.5 |
| 5 | 5 | 45 | 1861-11-22 | 1861-11-27 | NA | 8 | f | 42 | 1 | yes | 145.0 | 120.0 |

</div>

## Creating a LineListACSet

The first step wraps the DataFrame in a categorical structure. This is
the *instance* construction: a functor from the line list schema (a
category) to **Set**.

``` julia
ll = LineListACSet(df, onset=:date_of_prodrome)
```

    LineListACSet(188 cases, onset=:date_of_prodrome)

## Temporal aggregation: the `↓` operator

The downward arrow `↓` applies a binning morphism. Mathematically, this
is a surjective `FinFunction` from cases to time bins. No information is
lost yet — we know *which* cases map to each bin.

``` julia
weekly = ll ↓ Outbreaks.Week
```

    BucketedCases(188 cases → 8 bins, by=week)

The result is a `BucketedCases` — an intermediate that preserves the
full fiber structure.

## Decategorification: the `♯` operator

The sharp operator `♯` counts the cardinality of each fiber, producing
the familiar epidemic curve. This is where information is irreversibly
lost: we forget *which* cases are in each bin.

``` julia
epi_curve = ♯(weekly)
```

<div><div style = "float: left;"><span>8×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | week       | count |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 1861-10-28 |     2 |
|   2 | 1861-11-04 |     3 |
|   3 | 1861-11-11 |     7 |
|   4 | 1861-11-18 |    44 |
|   5 | 1861-11-25 |    54 |
|   6 | 1861-12-02 |    63 |
|   7 | 1861-12-09 |    14 |
|   8 | 1862-01-20 |     1 |

</div>

Or as a one-liner:

``` julia
♯(ll, Outbreaks.Week)
```

<div><div style = "float: left;"><span>8×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | week       | count |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 1861-10-28 |     2 |
|   2 | 1861-11-04 |     3 |
|   3 | 1861-11-11 |     7 |
|   4 | 1861-11-18 |    44 |
|   5 | 1861-11-25 |    54 |
|   6 | 1861-12-02 |    63 |
|   7 | 1861-12-09 |    14 |
|   8 | 1862-01-20 |     1 |

</div>

## Inspecting fibers

Before decategorifying, we can inspect the actual cases in each bin.
This is the left Kan extension — the categorical structure that counting
collapses.

``` julia
f = fibers(weekly)
println("$(length(f)) weekly bins")
println("\nCases in peak week (week 4):")
f[4]
```

    8 weekly bins

    Cases in peak week (week 4):

<div><div style = "float: left;"><span>44×12 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>19 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | case_ID | infector | date_of_prodrome | date_of_rash | date_of_death | age | gender | family_ID | class | complications | x_loc | y_loc |
|---:|---:|:---|:---|:---|:---|---:|:---|---:|---:|:---|---:|---:|
|  | Int64 | String3 | Date | Date | String15 | Int64 | String3 | Int64 | Int64 | String3 | Float64 | Float64 |
| 1 | 1 | 45 | 1861-11-21 | 1861-11-25 | NA | 7 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 2 | 2 | 45 | 1861-11-23 | 1861-11-27 | NA | 6 | f | 41 | 1 | yes | 142.5 | 100.0 |
| 3 | 5 | 45 | 1861-11-22 | 1861-11-27 | NA | 8 | f | 42 | 1 | yes | 145.0 | 120.0 |
| 4 | 7 | 42 | 1861-11-24 | 1861-11-28 | NA | 6 | m | 26 | 0 | yes | 272.5 | 147.5 |
| 5 | 8 | 45 | 1861-11-21 | 1861-11-26 | NA | 10 | m | 44 | 1 | yes | 97.5 | 155.0 |
| 6 | 10 | 45 | 1861-11-21 | 1861-11-25 | NA | 7 | f | 29 | 1 | yes | 240.0 | 75.0 |
| 7 | 12 | 45 | 1861-11-20 | 1861-11-25 | NA | 7 | f | 32 | 1 | yes | 195.0 | 27.5 |
| 8 | 14 | 181 | 1861-11-22 | 1861-11-29 | NA | 13 | f | 22 | 2 | yes | 227.5 | 185.0 |
| 9 | 15 | 45 | 1861-11-24 | 1861-11-29 | NA | 8 | m | 22 | 1 | yes | 227.5 | 185.0 |
| 10 | 16 | 181 | 1861-11-21 | 1861-11-25 | NA | 15 | f | 43 | 2 | yes | 172.5 | 172.5 |
| 11 | 17 | 181 | 1861-11-20 | 1861-11-25 | NA | 10 | f | 43 | 2 | yes | 172.5 | 172.5 |
| 12 | 18 | 175 | 1861-11-23 | 1861-11-27 | NA | 2 | f | 43 | 0 | yes | 172.5 | 172.5 |
| 13 | 19 | 181 | 1861-11-20 | 1861-11-24 | NA | 11 | m | 11 | 2 | yes | 167.5 | 5.0 |
| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |
| 33 | 93 | 45 | 1861-11-22 | 1861-11-26 | NA | 8 | m | 36 | 1 | yes | 162.5 | 47.5 |
| 34 | 94 | 183 | 1861-11-20 | 1861-12-03 | NA | 4 | f | 10 | 0 | yes | 190.0 | 115.0 |
| 35 | 97 | 45 | 1861-11-21 | 1861-11-25 | NA | 10 | m | 28 | 1 | yes | 230.0 | 120.0 |
| 36 | 106 | 42 | 1861-11-23 | 1861-11-26 | NA | 4 | m | 34 | 0 | yes | 170.0 | 17.5 |
| 37 | 116 | 45 | 1861-11-21 | 1861-11-25 | NA | 8 | m | 40 | 1 | yes | 127.5 | 147.5 |
| 38 | 145 | 45 | 1861-11-23 | 1861-11-27 | NA | 8 | f | 39 | 1 | yes | 135.0 | 125.0 |
| 39 | 153 | 45 | 1861-11-24 | 1861-11-27 | NA | 10 | f | 37 | 1 | yes | 132.5 | 80.0 |
| 40 | 156 | 45 | 1861-11-22 | 1861-11-24 | NA | 8 | m | 31 | 1 | yes | 182.5 | 55.0 |
| 41 | 172 | 174 | 1861-11-19 | 1861-11-21 | NA | 3 | f | 62 | 0 | yes | 185.0 | 175.0 |
| 42 | 179 | 177 | 1861-11-18 | 1861-11-21 | NA | 1 | f | 17 | 1 | yes | 182.5 | 200.0 |
| 43 | 186 | 45 | 1861-11-22 | 1861-11-26 | NA | 6 | NA | 57 | 0 | yes | 212.5 | 90.0 |
| 44 | 188 | 175 | 1861-11-23 | 1861-11-27 | NA | 1 | NA | 57 | 0 | yes | 212.5 | 90.0 |

</div>

## Functorial coarsening: Week → Month

A key advantage of the categorical approach: coarsening from weekly to
monthly is *functorial composition* of `FinFunction`s. We compose
`Case → Week → Month` without re-accessing raw data.

``` julia
monthly = weekly ↓ Outbreaks.Month
♯(monthly)
```

<div><div style = "float: left;"><span>4×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | month      | count |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 1861-10-01 |     2 |
|   2 | 1861-11-01 |   108 |
|   3 | 1861-12-01 |    77 |
|   4 | 1862-01-01 |     1 |

</div>

Compare: going directly to monthly gives the same result
(functoriality):

``` julia
♯(ll, Outbreaks.Month)
```

<div><div style = "float: left;"><span>4×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | month      | count |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 1861-10-01 |     1 |
|   2 | 1861-11-01 |    89 |
|   3 | 1861-12-01 |    97 |
|   4 | 1862-01-01 |     1 |

</div>

## Stratified aggregation with `⊗`

The tensor product `⊗` creates a product scale for joint stratification.
This corresponds to aggregation in a product category.

``` julia
# Weekly counts stratified by school class
strat = ♯(ll, Outbreaks.Week ⊗ Class(:class))
first(strat, 10)
```

<div><div style = "float: left;"><span>10×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | week       | class | count |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 1861-10-28 |     0 |     1 |
|   2 | 1861-10-28 |     2 |     1 |
|   3 | 1861-11-04 |     0 |     2 |
|   4 | 1861-11-04 |     1 |     1 |
|   5 | 1861-11-11 |     0 |     3 |
|   6 | 1861-11-11 |     1 |     1 |
|   7 | 1861-11-11 |     2 |     3 |
|   8 | 1861-11-18 |     0 |     7 |
|   9 | 1861-11-18 |     1 |    27 |
|  10 | 1861-11-18 |     2 |    10 |

</div>

Multiple categorical variables can be combined:

``` julia
# By month and class
♯(ll, Outbreaks.Month ⊗ Class(:class))
```

<div><div style = "float: left;"><span>7×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | month      | class | count |
|----:|:-----------|------:|------:|
|     | Date       | Int64 | Int64 |
|   1 | 1861-10-01 |     2 |     1 |
|   2 | 1861-11-01 |     0 |    22 |
|   3 | 1861-11-01 |     1 |    30 |
|   4 | 1861-11-01 |     2 |    37 |
|   5 | 1861-12-01 |     0 |    67 |
|   6 | 1861-12-01 |     2 |    30 |
|   7 | 1862-01-01 |     0 |     1 |

</div>

## Pipe-friendly syntax

All operations compose naturally with Julia’s `|>` pipe:

``` julia
result = ll |> aggregate_by(Outbreaks.Week) |> ♯
first(result, 5)
```

<div><div style = "float: left;"><span>5×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | week       | count |
|----:|:-----------|------:|
|     | Date       | Int64 |
|   1 | 1861-10-28 |     2 |
|   2 | 1861-11-04 |     3 |
|   3 | 1861-11-11 |     7 |
|   4 | 1861-11-18 |    44 |
|   5 | 1861-11-25 |    54 |

</div>

## The category theory perspective

The pipeline `LineListACSet → ↓ → ♯` implements the mathematical
decomposition:

$$\text{EpiCurve} = |{-}| \circ \pi^{-1} \circ \beta$$

where:

- $\beta$: onset assignment (`Case → Day`, attribute morphism in the
  ACSet)
- $\pi^{-1}$: fiber construction (preimage of the binning `FinFunction`)
- $|{-}|$: cardinality (decategorification, the *only* lossy step)

The `BucketedCases` intermediate lives between $\pi^{-1}$ and $|{-}|$,
preserving the full categorical structure. This is why coarsening is
functorial: we compose surjections *before* counting, so `Week → Month`
is just another `FinFunction` in the chain.

## Summary

| Operation | Symbol | Categorical meaning | Information loss? |
|----|----|----|:--:|
| Wrap as ACSet | `LineListACSet` | Instance functor $I: \mathcal{C} \to \mathbf{Set}$ | No |
| Aggregate | `↓` | Surjective `FinFunction` | No |
| Stratify | `⊗` | Product category | No |
| Coarsen | `↓` on `BucketedCases` | Composition of `FinFunction`s | No |
| Count | `♯` | Cardinality $\|\text{fiber}\|$ | **Yes** |
| Inspect fibers | `fibers` | Left Kan extension | No |
