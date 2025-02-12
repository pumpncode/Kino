SMODS.Joker {
    key = "mr_and_mrs_smith",
    order = 42,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
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
        -- ???

    end
}