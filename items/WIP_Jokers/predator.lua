SMODS.Joker {
    key = "predator",
    order = 40,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 0},
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
        -- Turn one of the cards in your opening hand into a hidden predator card.
        -- Gives x3 when triggered.

    end
}