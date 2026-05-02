# Multi-table Datasets

Datasets that return a `NamedTuple` of `DataFrame`s, linking case data with
contact tracing, genetic, or network information.

| Function | Disease | Location | Year | Tables |
|:---------|:--------|:---------|:-----|:-------|
| [`ebola_sim`](@ref) | Ebola | Simulated | — | linelist + contacts |
| [`ebola_sim_clean`](@ref) | Ebola | Simulated | — | linelist + contacts |
| [`mers_korea_2015`](@ref) | MERS-CoV | South Korea | 2015 | linelist + contacts |
| [`rabies_car_2003`](@ref) | Rabies | Central African Republic | 2003 | linelist + DNA |
| [`s_enteritidis_pt59`](@ref) | Salmonella | — | — | graph + cluster |
