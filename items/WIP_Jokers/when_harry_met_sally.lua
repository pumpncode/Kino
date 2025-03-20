SMODS.Joker {
    key = "when_harry_met_sally",
    order = 66,
    config = {
        extra = {
            matches = {

            }
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_kino_romance",
    kino_joker = {
        id = 639,
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
    pools, k_genre = {"Romance", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,
    calculate = function(self, card, context)
        -- if context.match_made 

    end
}