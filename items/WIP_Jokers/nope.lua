SMODS.Joker {
    key = "nope",
    order = 45,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 1},
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
        -- Scored cards have a 1/5 chance to get abducted. 
        -- When a card gets abducted, create a random planet card

    end
}