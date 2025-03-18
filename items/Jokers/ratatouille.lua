SMODS.Joker {
    key = "ratatouille",
    order = 46,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_suit = "Hearts"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_legendary",
    pos = { x = 1, y = 0},
    soul_pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 62,
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
    pools, k_genre = {"Animation", "Romance", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.cur_suit
            }
        }
    end,
    calculate = function(self, card, context)
        -- Each round, one random suit counts as every suit.
        -- Needs to be done through lovely inject, both to accept suit type, and current thing.
        

    end
}