# Categorical Aggregation

Outbreaks.jl includes an optional Catlab.jl extension for representing line
lists categorically and aggregating them across temporal and categorical scales.
Load Catlab alongside Outbreaks to activate these methods:

```julia
using Outbreaks, Catlab

ll = LineListACSet(measles_hagelloch_1861(), onset = :date_of_prodrome)
weekly = ll ↓ Outbreaks.Week
counts = ♯(weekly)
stratified = ♯(ll, Outbreaks.Week ⊗ Class(:class))
monthly = weekly ↓ Outbreaks.Month
```

!!! note
    `Day`, `Week`, `Month`, and `Year` are temporal scales exported by
    Outbreaks.jl. If `Dates` is also loaded, qualify them as `Outbreaks.Week`,
    `Outbreaks.Month`, and so on to avoid ambiguity with `Dates.Week`.

```@docs
TemporalScale
CategoricalScale
ProductScale
BucketedCases
LineListACSetWrapper
LineListACSet
EpiCurveACSet
aggregate
decategorify
fibers
coarsen
aggregate_by
Class
District
Stratum
Outbreaks.:↓
Outbreaks.♯
```
