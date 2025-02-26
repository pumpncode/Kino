SMODS.Joker {
    key = "steel",
    order = 180,
    config = {
        extra = {
            chips = 0,
            a_chips = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains +3 chips for each steel chip in hand

        if context.after and not context.blueprint then
            for i = 1, #G.hand.cards do
                if SMODS.get_enhancements(G.hand.cards[i], "m_steel") and not G.hand.cards[i].debuff then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips
                end
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}