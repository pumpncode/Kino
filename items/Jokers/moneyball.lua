SMODS.Joker {
    key = "moneyball",
    order = 154,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sports", "Drama"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)


        if context.after and context.cardarea == G.jokers then
            if G.GAME.current_round.hands_played == 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + G.GAME.hands[context.scoring_name].level
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    dollars = G.GAME.hands[context.scoring_name].level
                }
            end
        end
    end
}