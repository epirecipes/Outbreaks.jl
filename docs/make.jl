using Documenter
using Outbreaks

function copy_rendered_vignettes()
    source_root = normpath(joinpath(@__DIR__, "..", "vignettes"))
    destination_root = joinpath(@__DIR__, "build", "vignettes")
    isdir(source_root) || return

    for name in sort(readdir(source_root))
        source = joinpath(source_root, name, "index.html")
        isfile(source) || continue
        destination_dir = joinpath(destination_root, name)
        mkpath(destination_dir)
        cp(source, joinpath(destination_dir, "index.html"); force = true)
    end
end

makedocs(;
    sitename = "Outbreaks.jl",
    modules = [Outbreaks],
    authors = "Simon Frost and contributors",
    remotes = nothing,
    warnonly = [:cross_references],
    format = Documenter.HTML(;
        prettyurls = true,
        repolink = "https://github.com/epirecipes/Outbreaks.jl",
    ),
    pages = [
        "Home" => "index.md",
        "Vignettes" => "vignettes.md",
        "Categorical Aggregation" => "catlab.md",
        "Dataset Reference" => [
            "All Datasets" => "datasets.md",
            "Line Lists" => "linelists.md",
            "Aggregated Time Series" => "timeseries.md",
            "Multi-table Datasets" => "multitable.md",
        ],
    ],
)

copy_rendered_vignettes()

deploydocs(;
    repo = "github.com/epirecipes/Outbreaks.jl.git",
    target = "build",
    push_preview = true,
)
