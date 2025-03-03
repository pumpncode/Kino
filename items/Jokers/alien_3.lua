SMODS.Joker {
    key = "alien_3",
    order = 73,
    config = {
        extra = {
            will_trigger = true
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8077,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.will_trigger
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a hand with only debuffed cards
        -- Create a LV426

        if context.before and not context.repetition and not context.blueprint then

            for i = 1, #context.full_hand do
                if context.full_hand[i].debuff then
                    card.ability.extra.will_trigger = true
                else 
                    card.ability.extra.will_trigger = false
                    break
                end
            end
        end

        if context.after and card.ability.extra.will_trigger and
        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, "c_kino_lv426", "alien")
                    card:add_to_deck()
                    G.consumeables:emplace(card) 
                    return true
                end}))
        end
    end
}