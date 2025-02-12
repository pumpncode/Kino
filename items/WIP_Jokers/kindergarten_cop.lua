SMODS.Joker {
    key = "kindergarten_cop",
    order = 71,
    config = {
        extra = {
            cur_suit = "Hearts"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 5},
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
        -- when you buy this, creates a list of requirements.
        -- when the requirements are met, functions as mr. bones
        -- except, create new requirements instead of disappearing.

    end
}