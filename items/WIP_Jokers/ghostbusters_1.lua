SMODS.Joker {
    key = "ghostbusters",
    order = 68,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 5},
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
        -- +1 when you remove a card from your deck. 
        -- +5 if it was enhanced.

    end
}