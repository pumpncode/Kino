SMODS.Joker {
    key = "turner_and_hooch",
    order = 29,
    config = {
        extra = {
            mult = 30,
            one_face = false,
            one_nface = false
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.one_face,
                card.ability.extra.one_nface
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a Pair, and it contains 1 face and one non-face, +30 mult.

    end
}