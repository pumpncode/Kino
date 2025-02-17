SMODS.Joker {
    key = "blade_1",
    order = 136,
    config = {
        extra = {
            x_mult = 1,
            x_chips = 1,
            chips = 0,
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Superhero", "Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_chips,
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- when selecting a blind, destroy the vampire joker on the left. 
        -- gain all it's levelling.
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _my_pos = nil
            for i = 1, #G.jokers.cards do 
                if G.jokers.cards[i] == card then 
                    _my_pos = i
                    break
                end
            end

            if _my_pos and G.jokers.cards[_my_pos + 1] and not 
            G.jokers.cards[_my_pos + 1].getting_sliced and not
            G.jokers.cards[_my_pos + 1].ability.eternal then
                if G.jokers.cards[_my_pos + 1].config.center.is_vampire or G.jokers.cards.config.center.key == "j_vampire" then
                    local _xmult = {"xmult", "x_mult", "Xmult", "X_mult"}
                    local _xchips =  {"xchips", "x_chips", "Xchips", "X_chips"}
                    local _mult = {"mult", "mod_mult", "modmult"}
                    local _chips = {"chips", "mod_chips", "modchips"}
                    
                    for i = 1, #_xmult do
                        if G.jokers.cards[_my_pos + 1].ability.extra[i] then
                            card.ability.extra.x_mult = card.ability.extra.x_mult + G.jokers.cards[_my_pos + 1].ability.extra[i]
                        end
                    end

                    for i = 1, #_xchips do
                        if G.jokers.cards[_my_pos + 1].ability.extra[i] then
                            card.ability.extra.x_chips = card.ability.extra.x_chips + G.jokers.cards[_my_pos + 1].ability.extra[i]
                        end
                    end

                    for i = 1, #_mult do
                        print(G.jokers.cards[_my_pos + 1].ability.extra[i])
                        if G.jokers.cards[_my_pos + 1].ability.extra[i] then
                            
                            card.ability.extra.mult = card.ability.extra.mult + G.jokers.cards[_my_pos + 1].ability.extra[i]
                        end
                    end

                    for i = 1, #_chips do
                        if G.jokers.cards[_my_pos + 1].ability.extra[i] then
                            card.ability.extra.chips = card.ability.extra.chips + G.jokers.cards[_my_pos + 1].ability.extra[i]
                        end
                    end

                    if G.jokers.cards[_my_pos + 1].ability.extra.romance_bonus then
                        card.ability.extra.x_chips = card.ability.extra.x_chips + G.jokers.cards[_my_pos + 1].ability.extra.romance_bonus
                    end

                    G.jokers.cards[_my_pos + 1].getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        G.jokers.cards[_my_pos + 1]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))

                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_blade_ex'), colour = G.C.BLACK })
                end
            end
            
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips,
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}