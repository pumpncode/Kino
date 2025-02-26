SMODS.Joker {
    key = "apollo_13",
    order = 178,
    config = {
        extra = {
            goal = 13
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.goal
            }
        }
    end,
    calculate = function(self, card, context)
        -- If your hand rank's add up to 13, create a planet

        if context.joker_main then
            local _rank_total = 0
            for i = 1, #context.scoring_hand do
                local _card = context.scoring_hand[i]   
                _rank_total = _rank_total + context.scoring_hand[i]:get_id()
            end

            if _rank_total == card.ability.extra.goal and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, nil, "alien")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
            end
        end
    end
}