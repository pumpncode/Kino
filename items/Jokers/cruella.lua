SMODS.Joker {
    key = "cruella",
    order = 255,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 4
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 337404,
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
    pools, k_genre = {"Comedy","Crime", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- 1/4 chance to give an edition to a random scoring card each hand
        if context.joker_main then
            if pseudorandom("cruella") < (G.GAME.probabilities.chance * card.ability.extra.cur_chance) / card.ability.extra.chance then
                -- give card an edition
            end
        end
    end
}