SMODS.Joker {
    key = "frankenstein",
    order = 99,
    config = {
        extra = {
            is_used = false,
            chips = 0,
            mult = 0,
            xmult = 0,
            xchips = 0

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.is_used,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        -- If not yet used:
        -- When you play a hand, destroy all cards. Then give this card + chips, + mult, xmult and xchips equal to their total values.
    
        

        if card.ability.extra.is_used and context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchips 
            }
        end
    end
}