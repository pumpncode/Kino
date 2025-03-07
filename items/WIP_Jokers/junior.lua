SMODS.Joker {
    key = "kindergarten_cop",
    order = 72,
    config = {
        extra = {
            triggered = false
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.cur_suit
            }
        }
    end,
    calculate = function(self, card, context)
        -- The first king or jack that scores, duplicate it but make it a 2.
        if context.after then
            
        end
    end
}