SMODS.Joker {
    key = "star_wars_vii",
    order = 336,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 140607,
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
    pools, k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- scoring cards give chips equal to the number of planets used
        if context.individual and context.cardarea == G.play then
            return {
                chips = G.GAME.consumeable_usage_total.planet * card.ability.extra.factor
            }
        end
    end
}