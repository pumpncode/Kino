SMODS.Joker {
    key = "nightmare_on_elm_street",
    order = 158,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 377,
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
    pools, k_genre = {"Horror"},
    enhancement_gate = 'm_kino_horror',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Monster cards held in hand give 1.5x mult
        if context.individual and context.cardarea == G.hand and 
        SMODS.has_enhancement(context.other_card, "m_kino_monster") then
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end
    end
}