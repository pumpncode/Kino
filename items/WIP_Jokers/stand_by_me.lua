SMODS.Joker {
    key = "stand_by_me",
    order = 65,
    config = {
        extra = {
            cur_suit = "Hearts"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.cur_suit
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you play your least played hand, +0.1x

    end
}