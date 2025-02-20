SMODS.Joker {
    key = "indiana_jones",
    order = 92,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 3},
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
        -- Ancient Joker-esque, but each individual trigger increases the scaling
        -- LEGENDARY SPIELBERG JOKER
    end
}