SMODS.Joker {
    key = "incredible_hulk",
    order = 157,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1724,
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
    enhancement_gate = "m_kino_horror",
    pools, k_genre = {"Superhero", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Monster cards also give +10 mult
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_kino_monster") then
                return {
                    message = "Angry!",
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}