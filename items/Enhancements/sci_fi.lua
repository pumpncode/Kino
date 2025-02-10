SMODS.Enhancement {
    key = "sci_fi",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 0},
    config = {
        a_mult = 1,
        a_chips = 5,
        mult = 0,
        bonus = 0,
        times_upgraded = 0
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.a_mult or self.config.a_mult,
                card and card.ability.a_chips or self.config.a_chips,
                card and card.ability.mult or self.config.mult,
                card and card.ability.bonus or self.config.bonus,
                card and card.ability.times_upgraded or self.config.times_upgraded
            }
        }
    end,
    calculate = function(self, card, context, effect)
        print("TESTING - ")
        if (context.cardarea == G.play and not context.repetition) or context.sci_fi_upgrade then

            -- Sets values, as upgrade should happen after scoring
            card.ability.times_upgraded = card.ability.times_upgraded + 1
            card.ability.mult = card.ability.mult + card.ability.a_mult
            card.ability.bonus = card.ability.bonus + card.ability.a_chips

            card_eval_status_text(card, 'extra', nil, nil, nil,
              { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
        end
    end

    
    -- upgrade = function()
    --     print("THIS WORKED. ")
    -- end
}