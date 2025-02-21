SMODS.Joker {
    key = "avatar",
    order = 63,
    config = {
        extra = {
            chips = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you use a planet, this gains +chips equal to the level of your most played hand.
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "Planet" then
                local _hand, _tally = nil, -1
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _tally = G.GAME.hands[v].played
                    end
                end

                card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[v].level
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
}