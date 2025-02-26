SMODS.Enhancement {
    key = "demonic",
    atlas = "kino_enhancements",
    pos = { x = 1, y = 0},
    config = {
        x_mult = 1,
        base_xmult = 1,
        a_xmult = 0.25
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.x_mult or self.config.x_mult,
                card and card.ability.base_xmult or self.config.base_xmult,
                card and card.ability.a_xmult or self.config.a_xmult
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When scored, x3, then destroy the hand.
            if (context.before and context.cardarea == G.play and not context.repetition) then
                local sacrifices = false
                local _total_gain = 0
                for i = 1, #context.scoring_hand do
                    if not SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_demonic') then
                        sacrifices = true
                        _total_gain = _total_gain + card.ability.a_xmult
                    end
                end

                if sacrifices then
                    card.ability.x_mult = card.ability.base_xmult + _total_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_sacrifice'), colour = G.C.BLACK })
                end
            end
    end
}