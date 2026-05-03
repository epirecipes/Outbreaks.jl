using Test
using Outbreaks
using DataFrames

@testset "Outbreaks.jl" begin

    @testset "Simple datasets" begin
        @testset "covid19_england_nhscalls_2020" begin
            df = covid19_england_nhscalls_2020()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "dengue_fais_2011" begin
            df = dengue_fais_2011()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "dengue_yap_2011" begin
            df = dengue_yap_2011()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "ebola_kikwit_1995" begin
            df = ebola_kikwit_1995()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "ebola_sierraleone_2014" begin
            df = ebola_sierraleone_2014()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "fluH7N9_china_2013" begin
            df = fluH7N9_china_2013()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "influenza_england_1978_school" begin
            df = influenza_england_1978_school()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "measles_hagelloch_1861" begin
            df = measles_hagelloch_1861()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "nipah_malaysia" begin
            df = nipah_malaysia()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "norovirus_derbyshire_2001_school" begin
            df = norovirus_derbyshire_2001_school()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "sars_canada_2003" begin
            df = sars_canada_2003()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "sarscov2_who_2019" begin
            df = sarscov2_who_2019()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "smallpox_abakaliki_1967" begin
            df = smallpox_abakaliki_1967()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "varicella_sim_berlin" begin
            df = varicella_sim_berlin()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "zika_girardot_2015" begin
            df = zika_girardot_2015()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "zika_sanandres_2015" begin
            df = zika_sanandres_2015()
            @test df isa DataFrame
            @test nrow(df) > 0
        end

        @testset "zika_yap_2007" begin
            df = zika_yap_2007()
            @test df isa DataFrame
            @test nrow(df) > 0
        end
    end

    @testset "Complex datasets" begin
        @testset "ebola_sim" begin
            data = ebola_sim()
            @test data isa NamedTuple
            @test haskey(data, :linelist)
            @test haskey(data, :contacts)
            @test data.linelist isa DataFrame
            @test data.contacts isa DataFrame
            @test nrow(data.linelist) > 0
            @test nrow(data.contacts) > 0
        end

        @testset "ebola_sim_clean" begin
            data = ebola_sim_clean()
            @test data isa NamedTuple
            @test haskey(data, :linelist)
            @test haskey(data, :contacts)
            @test data.linelist isa DataFrame
            @test data.contacts isa DataFrame
            @test nrow(data.linelist) > 0
            @test nrow(data.contacts) > 0
        end

        @testset "mers_korea_2015" begin
            data = mers_korea_2015()
            @test data isa NamedTuple
            @test haskey(data, :linelist)
            @test haskey(data, :contacts)
            @test data.linelist isa DataFrame
            @test data.contacts isa DataFrame
            @test nrow(data.linelist) > 0
            @test nrow(data.contacts) > 0
        end

        @testset "rabies_car_2003" begin
            data = rabies_car_2003()
            @test data isa NamedTuple
            @test haskey(data, :linelist)
            @test haskey(data, :dna)
            @test data.linelist isa DataFrame
            @test data.dna isa DataFrame
            @test nrow(data.linelist) > 0
            @test nrow(data.dna) > 0
        end

        @testset "s_enteritidis_pt59" begin
            data = s_enteritidis_pt59()
            @test data isa NamedTuple
            @test haskey(data, :graph)
            @test haskey(data, :cluster)
            @test data.graph isa DataFrame
            @test data.cluster isa DataFrame
            @test nrow(data.graph) > 0
            @test nrow(data.cluster) > 0
        end
    end

    @testset "Catlab Extension" begin
        using Catlab

        @testset "Types available from main module" begin
            @test Day isa TemporalScale
            @test Week isa TemporalScale
            @test Month isa TemporalScale
            @test Year isa TemporalScale
            @test Class(:x) isa CategoricalScale
            @test District(:y) isa CategoricalScale
        end

        @testset "LineListACSet construction" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            @test ll isa LineListACSetWrapper
            @test ll.onset_col == :date_of_prodrome
            @test nrow(ll.df) == 188
            @test_throws ErrorException LineListACSet(df, onset=:missing_col)
            @test_throws ErrorException LineListACSet(df, onset=:date_of_prodrome, age=:age)
            @test_throws ErrorException LineListACSet(df, onset=:date_of_prodrome, location=:missing_col)
        end

        @testset "Temporal aggregation (↓)" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            bucketed = ll ↓ Week
            @test bucketed isa BucketedCases
            @test length(bucketed.bins) == 8
            @test nrow(bucketed.cases) == 188
        end

        @testset "Decategorification (♯)" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            counts = ♯(ll, Week)
            @test counts isa DataFrame
            @test sum(counts.count) == 188
            @test :week in propertynames(counts)
            @test :count in propertynames(counts)
        end

        @testset "Tensor product (⊗) and stratification" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            ps = Outbreaks.Week ⊗ Class(:class)
            @test ps isa ProductScale
            @test length(ps.scales) == 2
            strat = ♯(ll, ps)
            @test :week in propertynames(strat)
            @test :class in propertynames(strat)
            @test sum(strat.count) == 188
        end

        @testset "Coarsen (functorial composition)" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            weekly = ll ↓ Outbreaks.Week
            monthly = weekly ↓ Outbreaks.Month
            @test monthly isa BucketedCases
            @test length(monthly.bins) < length(weekly.bins)
            monthly_counts = ♯(monthly)
            @test sum(monthly_counts.count) == 188

            stratified_weekly = ll ↓ (Outbreaks.Week ⊗ Class(:class))
            stratified_monthly = stratified_weekly ↓ Outbreaks.Month
            stratified_counts = ♯(stratified_monthly)
            @test :month in propertynames(stratified_counts)
            @test :class in propertynames(stratified_counts)
            @test sum(stratified_counts.count) == 188

            yearly = monthly ↓ Outbreaks.Year
            @test sum(♯(yearly).count) == 188
        end

        @testset "Fibers" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            bucketed = ll ↓ Week
            f = fibers(bucketed)
            @test length(f) == length(bucketed.bins)
            @test sum(nrow.(f)) == 188
            @test all(fi -> fi isa DataFrame, f)
        end

        @testset "Pipe style (aggregate_by)" begin
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            result = ll |> aggregate_by(Outbreaks.Week) |> ♯
            @test result isa DataFrame
            @test sum(result.count) == 188
        end

        @testset "Dates namespace qualification" begin
            using Dates
            df = measles_hagelloch_1861()
            ll = LineListACSet(df, onset=:date_of_prodrome)
            result = ll |> aggregate_by(Outbreaks.Week) |> ♯
            @test result isa DataFrame
            @test sum(result.count) == 188
        end

        @testset "Missing and empty inputs" begin
            df = measles_hagelloch_1861()
            df_missing = df[1:5, :]
            df_missing.date_of_prodrome = Union{Missing, Date}[df_missing.date_of_prodrome...]
            df_missing.date_of_prodrome[1] = missing
            @test_logs (:warn, r"Dropped 1 rows") begin
                ll_missing = LineListACSet(df_missing, onset=:date_of_prodrome)
                @test nrow(ll_missing.df) == 4
            end

            df_empty = df[1:0, :]
            ll_empty = LineListACSet(df_empty, onset=:date_of_prodrome)
            bucketed_empty = ll_empty ↓ Outbreaks.Week
            counts_empty = ♯(bucketed_empty)
            @test nrow(counts_empty) == 0
        end

        @testset "Mixed strata and EpiCurveACSet" begin
            df = measles_hagelloch_1861()[1:6, :]
            df.stratum = Any["a", missing, 2, "b", 1, missing]
            ll = LineListACSet(df, onset=:date_of_prodrome)
            stratified = ♯(ll, Outbreaks.Week ⊗ Stratum(:stratum))
            @test sum(stratified.count) == nrow(df)

            curve = DataFrame(week=[Date(2020, 1, 1), Date(2020, 1, 8)], cases=[10, 15])
            ec = EpiCurveACSet(curve, time=:week, count=:cases)
            @test ec !== nothing
        end
    end

end
