SMODS.Joker {
    key = "wolf_man_1",
    order = 177,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 13666,
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
    pools, k_genre = {"Drama"},
    enhancement_gate = "m_kino_horror",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a monster card transforms, it also gives X2 mult
    end
}