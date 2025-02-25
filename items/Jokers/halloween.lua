SMODS.Joker {
    key = "halloween",
    order = 159,
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
    pools, k_genre = {"Horror"},
    enhancement_gate = 'm_kino_horror',

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
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