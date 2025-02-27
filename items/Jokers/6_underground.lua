SMODS.Joker {
    key = "6_underground",
    order = 162,
    config = {
        extra = {
            mult = 6
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card:get_id() == 6 and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}