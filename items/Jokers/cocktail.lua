SMODS.Joker {
    key = "cocktail",
    order = 195,
    config = {
        extra = {
            a_money = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 2},
    cost = 1,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 7520,
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
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you use a confection, increase sell value by 2
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "confection" then
                card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.a_money
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_cocktail'), colour = G.C.MONEY })
                card:set_cost()
            end
        end
    end
}