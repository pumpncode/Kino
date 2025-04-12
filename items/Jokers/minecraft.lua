SMODS.Joker {
    key = "minecraft",
    order = 278,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 950387,
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
    pools, k_genre = {"Fantasy", "Comedy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                if pseudorandom("minecraft") < 1 / 2 then
                    context.other_card:set_ability("m_steel")
                    return {
                        message = localize("k_minecraft_1")
                    }
                else
                    context.other_card:set_ability("m_gold")
                    return {
                        message = localize("k_minecraft_2")
                    }
                end
                
            end
        end
    end
}