SMODS.Joker {
    key = "pinocchio_1940",
    order = 128,
    config = {
        extra = {
            chips = 10
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Musical", "Animated"},

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
        -- unmodified cards give +5 chips when held in hand
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.BLUE,
                    card = card,
                }
            end

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