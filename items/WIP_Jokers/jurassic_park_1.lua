SMODS.Joker {
    key = "jurassic_park_1",
    order = 95,
    config = {
        extra = {
            factor = 5

        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 3},
    cost = 15,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- scored cards give 5 times as many chips
        if context.individual then
            return {
                
            }
        end
    end
}