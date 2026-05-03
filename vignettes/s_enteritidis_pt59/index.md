# Salmonella Enteritidis PT59 Outbreak


## Overview

This dataset describes a food-borne outbreak of *Salmonella* Enteritidis
phage type 59 (PT59). The data include a food distribution network
represented as a directed graph of supplier–retailer links, and genetic
cluster assignments for isolates, enabling joint epidemiological and
molecular analysis of the outbreak.

## Source

Multi-agency Outbreak Control Team (Public Health England).

## Data

The dataset is returned as a `NamedTuple` with two DataFrames:

- **graph**: from, to (edges of the food distribution network)
- **cluster**: genetic cluster assignments for isolates

``` julia
using Outbreaks
using DataFrames
data = Outbreaks.s_enteritidis_pt59()
graph = data.graph
cluster = data.cluster
```

<div><div style = "float: left;"><span>43×2 DataFrame</span></div><div style = "float: right; font-style: italic;"><span>18 rows omitted</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | Column1 | obj\$cluster |
|----:|:--------|:-------------|
|     | String7 | String1      |
|   1 | d81c17  | A            |
|   2 | 064974  | A            |
|   3 | 3b712b  | A            |
|   4 | 486c07  | A            |
|   5 | 6f5824  | A            |
|   6 | c77a84  | A            |
|   7 | 1f4d22  | A            |
|   8 | f951d8  | A            |
|   9 | 44060b  | A            |
|  10 | 905296  | A            |
|  11 | b4e5d5  | A            |
|  12 | 0fffca  | B            |
|  13 | 78e5ba  | B            |
|   ⋮ | ⋮       | ⋮            |
|  32 | 7d3df0  | C            |
|  33 | b08945  | A            |
|  34 | f80b2e  | A            |
|  35 | efee6b  | A            |
|  36 | 6e0643  | A            |
|  37 | 252679  | A            |
|  38 | 35a9b6  | A            |
|  39 | 80afad  | A            |
|  40 | 1569a5  | A            |
|  41 | 161814  | A            |
|  42 | c09e12  | A            |
|  43 | 38881f  | A            |

</div>

### Distribution network

``` julia
first(graph, 6)
```

<div><div style = "float: left;"><span>6×3 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | Column1 | from    | to      |
|----:|--------:|:--------|:--------|
|     |   Int64 | String7 | String7 |
|   1 |       1 | 2e7967  | dd73b6  |
|   2 |       2 | 2e7967  | c7cd02  |
|   3 |       3 | 2e7967  | 2afba4  |
|   4 |       4 | 2e7967  | 4df851  |
|   5 |       5 | 2e7967  | 48f980  |
|   6 |       6 | 2e7967  | 2d3187  |

</div>

``` julia
describe(graph)
```

<div><div style = "float: left;"><span>3×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable | mean   | min    | median | max    | nmissing | eltype   |
|----:|:---------|:-------|:-------|:-------|:-------|---------:|:---------|
|     | Symbol   | Union… | Any    | Union… | Any    |    Int64 | DataType |
|   1 | Column1  | 52.0   | 1      | 52.0   | 103    |        0 | Int64    |
|   2 | from     |        | 030327 |        | fc7f8f |        0 | String7  |
|   3 | to       |        | 030327 |        | f951d8 |        0 | String7  |

</div>

### Genetic clusters

``` julia
first(cluster, 6)
```

<div><div style = "float: left;"><span>6×2 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | Column1 | obj\$cluster |
|----:|:--------|:-------------|
|     | String7 | String1      |
|   1 | d81c17  | A            |
|   2 | 064974  | A            |
|   3 | 3b712b  | A            |
|   4 | 486c07  | A            |
|   5 | 6f5824  | A            |
|   6 | c77a84  | A            |

</div>

``` julia
describe(cluster)
```

<div><div style = "float: left;"><span>2×7 DataFrame</span></div><div style = "clear: both;"></div></div><div class = "data-frame" style = "overflow-x: scroll;">

| Row | variable     | mean    | min       | median  | max       | nmissing | eltype   |
|----:|:-------------|:--------|:----------|:--------|:----------|---------:|:---------|
|     | Symbol       | Nothing | InlineSt… | Nothing | InlineSt… |    Int64 | DataType |
|   1 | Column1      |         | 064974    |         | f951d8    |        0 | String7  |
|   2 | obj\$cluster |         | A         |         | C         |        0 | String1  |

</div>
