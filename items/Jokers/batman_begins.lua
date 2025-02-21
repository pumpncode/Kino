SMODS.Joker {
    key = "batman_begins",
    order = 102,
    config = {
        extra = {
            money = 1,
            total = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    is_batman = true,
    pools, k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.total
            }
        }
    end,
    calculate = function(self, card, context)
        -- At the end of the round, gain $1 for each open joker slot (Batman jokers are excluded)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.total = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.mult
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.j_is_batman then card.ability.extra.total = card.ability.extra.total * card.ability.extra.mult end
            end
        end
    end,
    calc_dollar_bonus = function(self, card)

        return card.ability.extra.money + card.ability.extra.total
    end
}