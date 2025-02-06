SMODS.Joker {
    key = "piranha_2",
    order = 15,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
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
        -- High Card gives +8 mult.
        -- TEST
    end
}