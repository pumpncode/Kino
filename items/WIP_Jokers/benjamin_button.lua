SMODS.Joker {
    key = "benjamin_button",
    order = 78,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 0},
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