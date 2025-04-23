SMODS.Joker {
    key = "modern_times",
    order = 225,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetition = 1,
            cur_chance = 1,
            chance = 2,
            destroy_chance_non = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3082,
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
    pools, k_genre = {"Comedy", "Silent"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetition, 
                card.ability.extra.cur_chance * G.GAME.probabilities.normal,
                card.ability.extra.chance,
                card.ability.extra.destroy_chance_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- played cards have a 1/2 chance to retrigger and a 1/5 chance to break
        
        if context.cardarea == G.play and context.repetition then
            if pseudorandom("modern_times_retrigger") < (G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance then
                return {
                    repetitions = card.ability.extra.repetition,
                    message = localize('k_again_ex')
                }
            end 
        end

        if context.destroying_card and not context.blueprint then
            if pseudorandom("modern_times_destroy") < (G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.destroy_chance_non then
                return {
                    remove = true
                }
            end
        end
        
    end
}