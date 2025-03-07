SMODS.Joker {
    key = "treasure_planet",
    order = 174,
    config = {
        extra = {
            money = 1,
            big_money = 100,
            chance = 1000
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 4},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9016,
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
    pools, k_genre = {"Sci-fi", "Adventure", "Animated"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == "Planet" then
                local _dollars = card.ability.extra.money 
                if pseudorandom("treasure") < G.GAME.probabilities.normal / card.ability.extra.chance then
                    _dollars = card.ability.extra.big_money
                end

                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + _dollars
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize("$").. _dollars,
                    dollars = _dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
}