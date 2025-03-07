SMODS.Joker {
    key = "wall_e",
    order = 85,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10681,
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
    pools, k_genre = {"Sci-fi", "Animation", "Family"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.current_round.scrap_total
            }
        }
    end,
    calculate = function(self, card, context)
        --When you discard a steel card, gain scrap. When a sci-fi card upgrades, upgrade it an additional time for each scrap you have.
        if context.discard and not context.other_card.debuff and context.other_card.config.center == G.P_CENTERS.m_steel 
        and not context.blueprint then
            update_scrap(1)              
        end
    end
}