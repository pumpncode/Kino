SMODS.Joker {
    key = "rock",
    order = 155,
    config = {
        extra = {
            mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_stone",
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
        if context.individual and  SMODS.has_enhancement(context.other_card, "m_stone") then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}