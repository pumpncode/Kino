SMODS.Joker {
    key = "bfg",
    order = 97,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 4},
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