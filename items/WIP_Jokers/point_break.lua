SMODS.Joker {
    key = "point_break",
    order = 80,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 1},
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
        -- when a card is scored, lower rank by 1.
    end
}