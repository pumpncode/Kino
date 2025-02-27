SMODS.Joker {
    key = "seven_brides_for_seven_brothers",
    order = 163,
    config = {
        extra = {
            a_xmult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance", "Musical"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        
    end
}