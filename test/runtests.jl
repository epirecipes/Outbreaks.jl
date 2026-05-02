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

end
