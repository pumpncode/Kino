SMODS.Joker {
    key = "abyss",
    order = 60,
    config = {
        extra = {
            chance = 4,
            destroy_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        info_queue[#info_queue+1] = {set = 'Other', key = "jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.chance
            }
        }
    end,
    calculate = function(self, card, context)
        -- Unscored cards have a 1/4 chance to jump scare
        if context.individual and context.cardarea == "unscored" then
            if pseudorandom("abyss") < G.GAME.probabilities.normal / card.ability.extra.chance then
                print(G.GAME.probabilities.normal / card.ability.extra.chance)
                card.ability.extra.destroy_cards[#card.ability.extra.destroy_cards + 1] = context.other_card
                return {
                    x_mult = Kino.jump_scare_mult, 
                    message = localize('k_jump_scare'),
                    colour = HEX("372a2d"),
                    card = context.other_card
                }
            end
        end

        if context.destroying_card and #card.ability.extra.destroy_cards > 0 then
            for i, card in ipairs(card.ability.extra.destroy_cards) do
                if context.destroying_card == card then
                    return true
                end
            end
        end
    end
}