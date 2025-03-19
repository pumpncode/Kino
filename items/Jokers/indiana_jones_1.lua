SMODS.Joker {
    key = "indiana_jones_1",
    order = 92,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_legendary",
    pos = { x = 4, y = 0},
    soul_pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        
    end
}