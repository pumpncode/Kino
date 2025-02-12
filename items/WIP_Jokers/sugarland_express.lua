SMODS.Joker {
    key = "sugarland_express",
    order = 90,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 2},
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