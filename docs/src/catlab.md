# Categorical Aggregation

Category-theoretic aggregation of line lists now lives in
[`CategoricalOutbreaks.jl`](https://github.com/epirecipes/CategoricalOutbreaks.jl).
Outbreaks.jl provides the curated datasets; CategoricalOutbreaks.jl provides the
Catlab schemas, ACSet wrappers, fiber-preserving aggregation, and Unicode
operators.

```julia
using Outbreaks
using CategoricalOutbreaks

ll = LineListACSet(measles_hagelloch_1861(), onset = :date_of_prodrome)
weekly = ll ↓ Week
counts = ♯(weekly)
stratified = ♯(ll, Week ⊗ Class(:class))
monthly = weekly ↓ Month
```

See the CategoricalOutbreaks.jl package for its API reference and examples.
