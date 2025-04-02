SMODS.Joker {
    key = "9_movie",
    order = 260,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 9,
            chips_non = 0,
            count_non = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 12244,
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
    pools, k_genre = {"Animation", "Fantasy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card:is_id() == 9 then
            card.ability.extra.count_non = card.ability.extra.count_non + 1
            card.ability.extra.chips_non = card.ability.extra.chips_non + (card.ability.extra.chips * card.ability.extra.count_non)
            
            return {
                chips = card.ability.extra.chips_non
            }
        end
    end
}