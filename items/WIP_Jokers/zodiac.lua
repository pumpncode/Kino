SMODS.Joker {
    key = "zodiac",
    order = 77,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- creates a cypher when bought. when every card in the cypher is
        -- played, they will give x2 when scored.
    end
}