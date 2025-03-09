SMODS.Joker {
    key = "nope",
    order = 45,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {}
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 601,
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
    pools, k_genre = {"Family", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                #card.ability.extra.cards_abducted 
            }
        }
    end,
    calculate = function(self, card, context)
        -- Scored cards have a 1/5 chance to get abducted. 
        -- When a card gets abducted, create a random planet card
        -- abducted cards still count towards the hand, but do not score
        -- that hand.

        if context.joker_main then
            Kino.abduct_card(card, context.scoring_hand[1])
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        print("test")
        AbductionDisplayBox(card)
        print("Test End")
    end,
}