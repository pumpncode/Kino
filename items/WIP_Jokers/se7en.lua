SMODS.Joker {
    key = "se7en",
    order = 74,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 0},
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
        -- Whenever a 7 is scored, destroy a random card from your deck. 
        -- Upgrade that 7 by giving it mult equal to the card's rank.
    end
}