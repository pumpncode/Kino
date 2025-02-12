SMODS.Joker {
    key = "catch_me_if_you_can",
    order = 96,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 3},
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
        -- ???
    end
}