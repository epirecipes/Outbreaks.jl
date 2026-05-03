# Line list schema definitions using Catlab presentations.
#
# These define the categorical structure of epidemiological data:
# schemas as categories, instances as functors C → Set.

using Catlab: @present, @acset_type, FreeSchema

# Core line list schema: Case objects with temporal and categorical attributes.
@present SchLineList(FreeSchema) begin
    Case::Ob
    (DayT, LocationT, AgeT, OutcomeT)::AttrType
    onset::Attr(Case, DayT)
    location::Attr(Case, LocationT)
    age::Attr(Case, AgeT)
    outcome::Attr(Case, OutcomeT)
end

# Minimal schema with only onset (most general)
@present SchOnsetList(FreeSchema) begin
    Case::Ob
    DayT::AttrType
    onset::Attr(Case, DayT)
end

# Stratified schema: cases with onset and one stratification variable
@present SchStratifiedList(FreeSchema) begin
    Case::Ob
    (DayT, StratumT)::AttrType
    onset::Attr(Case, DayT)
    stratum::Attr(Case, StratumT)
end

# Epidemic curve schema (aggregated): time bins with counts
@present SchEpiCurve(FreeSchema) begin
    TimeBin::Ob
    (BinT, CountT)::AttrType
    bin_label::Attr(TimeBin, BinT)
    count::Attr(TimeBin, CountT)
end

# Generate concrete ACSet types
@acset_type LineListData(SchLineList, index=[:onset, :location])
@acset_type OnsetListData(SchOnsetList, index=[:onset])
@acset_type StratifiedListData(SchStratifiedList, index=[:onset, :stratum])
@acset_type EpiCurveData(SchEpiCurve, index=[:bin_label])
