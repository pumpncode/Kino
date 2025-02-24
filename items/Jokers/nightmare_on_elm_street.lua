SMODS.Joker {
    key = "nightmare_on_elm_street",
    order = 158,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Monster cards held in hand give 1.5x mult
        if context.individual and context.cardarea == G.hand and 
        SMODS.has_enhancement(context.other_card, "m_kino_monster") then
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end
    end
}