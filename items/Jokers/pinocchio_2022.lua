SMODS.Joker {
    key = "pinocchio_2022",
    order = 127,
    config = {
        extra = {
            chips = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Musical"},

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
        -- unmodified cards give +20 chips when scored
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.c_base and
            context.other_card.seal == nil and
            context.other_card.edition == nil then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}