SMODS.Joker {
    key = "2001_odyssey",
    order = 46,
    config = {
        extra = {
            cur_suit = "Hearts"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 1},
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
        -- Each round, one random suit counts as every suit.
        -- Needs to be done through lovely inject, both to accept suit type, and current thing.
        

    end
}