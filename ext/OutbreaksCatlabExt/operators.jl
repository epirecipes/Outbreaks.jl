# Unicode operator definitions for categorical epidemiology.
#
# These provide syntactic sugar for common categorical operations,
# making Julia code visually closer to the mathematical notation
# in the category theory document.
#
# Operators:
#   ↓  (U+2193) : Coarsen/aggregate (temporal resolution decreases)
#   ♯  (U+266F) : Decategorify (count fibers, "sharp" = discrete)
#   ⊗  (U+2297) : Product of scales (extends Catlab's monoidal ⊗)
#   ⊚  (U+229A) : Compose coarsening functorially

import Outbreaks: ↓, ♯
import Catlab: ⊗

# ─────────────────────────────────────────────────────────────────────
# ↓ : Aggregation (coarsening)
# ─────────────────────────────────────────────────────────────────────

(↓)(ll::LineListACSetWrapper, scale::TemporalScale) = Outbreaks.aggregate(ll, scale)
(↓)(ll::LineListACSetWrapper, ps::ProductScale) = Outbreaks.aggregate(ll, ps)
(↓)(b::BucketedCases, scale::TemporalScale) = Outbreaks.coarsen(b, scale)

# ─────────────────────────────────────────────────────────────────────
# ♯ : Decategorification (counting)
# ─────────────────────────────────────────────────────────────────────

Outbreaks.♯(b::BucketedCases) = Outbreaks.decategorify(b)
Outbreaks.♯(ll::LineListACSetWrapper, scale::TemporalScale) =
    Outbreaks.decategorify(Outbreaks.aggregate(ll, scale))
Outbreaks.♯(ll::LineListACSetWrapper, ps::ProductScale) =
    Outbreaks.decategorify(Outbreaks.aggregate(ll, ps))

# ─────────────────────────────────────────────────────────────────────
# ⊗ : Tensor product of scales (extending Catlab's monoidal product)
# ─────────────────────────────────────────────────────────────────────

(⊗)(a::TemporalScale, b::CategoricalScale) =
    ProductScale(Union{TemporalScale,CategoricalScale}[a, b])
(⊗)(a::CategoricalScale, b::TemporalScale) =
    ProductScale(Union{TemporalScale,CategoricalScale}[a, b])
(⊗)(a::TemporalScale, b::TemporalScale) =
    ProductScale(Union{TemporalScale,CategoricalScale}[a, b])
(⊗)(a::CategoricalScale, b::CategoricalScale) =
    ProductScale(Union{TemporalScale,CategoricalScale}[a, b])
(⊗)(p::ProductScale, s::Union{TemporalScale,CategoricalScale}) =
    ProductScale(vcat(p.scales, [s]))
(⊗)(s::Union{TemporalScale,CategoricalScale}, p::ProductScale) =
    ProductScale(vcat([s], p.scales))

# ─────────────────────────────────────────────────────────────────────
# ⊚ : Functorial composition of coarsening maps
# ─────────────────────────────────────────────────────────────────────

(⊚)(fine::TemporalScale, coarse::TemporalScale) = coarse

# Only export what's unique to the extension
export ⊚
