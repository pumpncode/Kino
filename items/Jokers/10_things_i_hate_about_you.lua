SMODS.Joker {
    key = "10_things_i_hate_about_you",
    order = 146,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 509967,
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
    pools, k_genre = {"Comedy", "Romance"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a hand containing only one romance card
        -- turn a random unenhanced scoring card into a romance card

        if context.joker_main then
            local _count = 0
            local _non_romance_cards = {}
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_romance') then
                    _count = _count + 1
                else
                    _non_romance_cards[#_non_romance_cards] = context.scoring_hand[i]
                end
            end

            if _count == 1 then
                local _card = pseudorandom_element(_non_romance_cards)
                _card:set_ability(G.P_CENTERS.m_kino_romance, nil, true)

            card_eval_status_text(_card, 'extra', nil, nil, nil,
            { message = localize('k_10_things_ex'), colour = G.C.MULT })
            end
        end
    end
}