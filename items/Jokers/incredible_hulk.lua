SMODS.Joker {
    key = "incredible_hulk",
    order = 157,
    config = {
        extra = {
            mult = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_kino_horror",
    pools, k_genre = {"Superhero", "Sci-fi"},

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
        -- Monster cards also give +10 mult
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_kino_monster") then
                return {
                    message = "Angry!",
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}