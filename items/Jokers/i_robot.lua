SMODS.Joker {
    key = "i_robot",
    order = 82,
    config = {
        extra = {
            x_mult = 1.00,
            a_xmult = 0.05
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- If a sci-fi card upgrades, gain x0.05
        if context.upgrading_sci_fi_card and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult
        end

        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
            }
        end
    end
}