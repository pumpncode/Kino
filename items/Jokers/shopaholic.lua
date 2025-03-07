SMODS.Joker {
    key = "shopaholic",
    order = 33,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            xmult_mod = 0.25,
            x_mult = 1,
            money_spend = 5,
            cur_spend = 0,
            money_threshold = 5

        }
    },
    rarity = 3,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 0},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 20048,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.x_mult,
                card.ability.extra.money_spend,
                card.ability.extra.cur_spend,
                card.ability.extra.money_threshold
            }
        }
    end,
    calculate = function(self, card, context)
        if context.kino_ease_dollars and context.kino_ease_dollars < 0 and not context.blueprint then
            local pos_spend = -1 * context.kino_ease_dollars
            card.ability.extra.cur_spend = card.ability.extra.cur_spend + pos_spend
            
            local upgraded = false
            -- Checks if enough money was spend
            while card.ability.extra.cur_spend >= card.ability.extra.money_threshold do
                upgraded = true
                
                -- upgrades xmult
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.xmult_mod
                
                -- Lowers the counter
                card.ability.extra.cur_spend = card.ability.extra.cur_spend - card.ability.extra.money_threshold

                -- sets the new treshold
                card.ability.extra.money_threshold = card.ability.extra.money_threshold + card.ability.extra.money_spend 
            end

            if upgraded then
                return {
                    message = localize('k_upgrade_ex'),
                    card = card
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
            }
        end
    end
}