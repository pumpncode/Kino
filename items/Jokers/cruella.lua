SMODS.Joker {
    key = "cruella",
    order = 255,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            count_non = 0,
            count_threshold = 3,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 337404,
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
    pools, k_genre = {"Comedy","Crime", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you've destroyed 3 cards, give a random card in deck an edition
        if context.remove_playing_cards then
            if not context.blueprint then
                card.ability.extra.count_non = card.ability.extra.count_non + 1
            end

            if card.ability.extra.count_non >= 3 then
                local _viable_cards = {}

                for _, _pcard in ipairs(G.deck.cards) do
                    if not _pcard.edition then
                        _viable_cards[#_viable_cards + 1] = _pcard
                    end
                end

                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = pseudorandom_element(_viable_cards, pseudoseed("cruella"))
                        local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'drwho'})
                        _card:set_ability(G.P_CENTERS[new_enhancement])
                    end}))  
                    
                return {
                    card = card,
                    message = localize("k_cruella")
                }
            end
        end
    end
}