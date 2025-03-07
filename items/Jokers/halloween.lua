SMODS.Joker {
    key = "halloween",
    order = 159,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 948,
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
                card.ability.extra.chips,
                G.GAME.current_round.horror_transform * card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives 20 chips for every time a Horror card has awoken.
        if context.joker_main then
            return {
                chips = G.GAME.current_round.horror_transform * card.ability.extra.chips
            }
        end
    end
}