SMODS.Joker {
    key = "mars_attacks",
    order = 55,
    config = {
        extra = {
            additional_levels = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 3},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.additional_levels + 1
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, destroy every planet you have, then upgrade 4 of a kind for each planet destroyed.
        -- If Full House's level would go down to 0, LOSE THE GAME 
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.center == G.P_CENTERS.c_planet then

                if G.GAME.hands["Full House"].level == 1 then
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_mars_attacks_2'), colour = G.C.MULT })

                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                        G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
                    return true end }))
                    
                end

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_mars_attacks'), colour = G.C.CHIPS })

                level_up_hand(card, "Four of a Kind", nil, card.ability.extra.additional_levels)
                level_up_hand(card, "Full House", nil, -1)
                
                     
            end
        end
    end
}