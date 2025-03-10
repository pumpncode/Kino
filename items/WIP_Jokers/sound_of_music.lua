SMODS.Joker {
    key = "sound_of_music",
    order = 41,
    config = {
        extra = {
            cards_scored = {Hearts = {}, Spades = {}, Diamonds = {}, Clubs = {}, Suitless = {}},
            a_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 15121,
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
    pools, k_genre = {"Musical", "Romance", "Historical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- gains +1 mult when you score
        -- a unique rank/suit combination

        if context.individual and context.cardarea == G.play and not context.blueprint then
            for suit, table in ipairs(card.ability.extra.cards_scored) do
                if context.other_card:is_suit(suit) then
                    for i = 1, #card.ability.extra.cards_scored[suit] do
                        
                    end
                end
            end
        end

    end
}