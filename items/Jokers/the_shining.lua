SMODS.Joker {
    key = "the_shining",
    order = 47,
    config = {
        extra = {
            mult = 0,
            a_mult = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i].base.id == 11 and 
                context.hand_drawn[i].config.center ~= G.P_CENTERS.m_stone then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult

                    if pseudorandom("shining") < (1/10) then
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_shining'), colour = G.C.MULT })
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize({type='variable', key = 'a_mult', vars = {card.ability.extra.mult}}), colour = G.C.MULT })
                    end
                    
                end
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end

        if context.after and not context.blueprint and not context.repetition then
            card.ability.extra.mult = 0
        end
    end
}