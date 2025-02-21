SMODS.Joker {
    key = "panic_room",
    order = 76,
    config = {
        extra = {
            chips = 20,
            mult = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Give +20 mult and +20 chips on your final hand.
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}