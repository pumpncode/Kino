SMODS.Joker {
    key = "blair_witch",
    order = 150,
    config = {
        extra = {
            chance_cur = 0,
            chance = 100,
            a_chance = 5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 0},
    cost = 10,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                G.GAME.probabilities.normal * card.ability.extra.chance_cur,
                card.ability.extra.chance,
                card.ability.extra.a_chance
            }
        }
    end,
    calculate = function(self, card, context)
        -- Rerolls are free. Every time you reroll, increase the chance by 5 to destroy all current jokers.
        
        
        if context.reroll_shop and not context.blueprint then
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		    calculate_reroll_cost(true)

            if pseudorandom("blair") < ((G.GAME.probabilities.normal * card.ability.extra.chance_cur) / card.ability.extra.chance) then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then 
                            G.jokers.cards[i].getting_sliced = true
                            G.E_MANAGER:add_event(Event({func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                end

                if card.ability.extra.chance_cur >= 100 then
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        card:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                    return true
                end
            end

            card.ability.extra.chance_cur = card.ability.extra.chance_cur + card.ability.extra.a_chance
        end
    end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		calculate_reroll_cost(true)
	end,
    remove_from_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
}