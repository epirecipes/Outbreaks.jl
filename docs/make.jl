using Documenter
using Outbreaks

makedocs(;
    sitename = "Outbreaks.jl",
    modules = [Outbreaks],
    authors = "Simon Frost and contributors",
    remotes = nothing,
    warnonly = [:cross_references],
    format = Documenter.HTML(;
        prettyurls = true,
    ),
    pages = [
        "Home" => "index.md",
        "Vignettes" => "vignettes.md",
        "Dataset Reference" => [
            "All Datasets" => "datasets.md",
            "Line Lists" => "linelists.md",
            "Aggregated Time Series" => "timeseries.md",
            "Multi-table Datasets" => "multitable.md",
        ],
    ],
)
