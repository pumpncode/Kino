SMODS.Joker {
    key = "edward_scissorhands",
    order = 51,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 2},
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
        -- "A little off the top"
        -- When you play a card, lower its chips by 3 and gain +3 chips.

    end
}