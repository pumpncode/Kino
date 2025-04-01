SMODS.Enhancement {
    key = "sci_fi",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 0},
    config = {
        a_mult = 1,
        a_chips = 5,
        mult = 0,
        x_mult = 0,
        bonus = 0,
        times_upgraded = 0
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.a_mult or self.config.a_mult,
                card and card.ability.a_chips or self.config.a_chips,
                card and card.ability.mult or self.config.mult,
                card and card.ability.x_mult or self.config.x_mult,
                card and card.ability.bonus or self.config.bonus,
                card and card.ability.times_upgraded or self.config.times_upgraded
            }
        }
    end,
    upgrade = function(self, card)
        card.ability.times_upgraded = card.ability.times_upgraded + 1
        card.ability.bonus = card.ability.bonus + card.ability.a_chips

        if next(find_joker('j_kino_terminator_2')) then
            for index, _joker in ipairs(G.jokers.cards) do
                if _joker.ability.extra.affects_sci_fi then
                    card.ability.x_mult = card.ability.x_mult + _joker.ability.extra.x_mult
                end
            end
        else
            card.ability.mult = card.ability.mult + card.ability.a_mult
        end
                
                
        G.GAME.current_round.sci_fi_upgrades = G.GAME.current_round.sci_fi_upgrades + 1
        G.GAME.current_round.sci_fi_upgrades_last_round = G.GAME.current_round.sci_fi_upgrades_last_round + 1
        SMODS.calculate_context({upgrading_sci_fi_card = true})
    end,
    calculate = function(self, card, context, effect)
        if (context.main_scoring and context.cardarea == G.play and not context.repetition) or context.sci_fi_upgrade then
            if (context.sci_fi_upgrade_target ~= nil and context.sci_fi_upgrade_target ~= card) then
                return 
            end 

            local times_to_upgrade = 1
            local wall_e = false
            -- Sets values, as upgrade should happen after scoring
            if G.GAME.current_round.scrap_total and G.GAME.current_round.scrap_total > 0 and next(find_joker('j_kino_wall_e')) then
                times_to_upgrade = 1 + G.GAME.current_round.scrap_total
                wall_e = true
            end

            for i = 1, times_to_upgrade do 
                card.config.center:upgrade(card)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
                
            end

            if wall_e then
                update_scrap(0, true)
            end
        end
    end
}