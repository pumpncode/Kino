SMODS.Joker {
    key = "inception",
    order = 105,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- blueprint-esque
        -- after sitting next to a joker for one played hand,
        -- copy its effects.
    end
}