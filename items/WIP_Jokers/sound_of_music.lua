SMODS.Joker {
    key = "sound_of_music",
    order = 41,
    config = {
        extra = {
            cards_scored = {Hearts = {}, Spades = {}, Diamonds = {}, Clubs = {}, Suitless = {}},
            mult = 0,
            a_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Musical", "Romance", "Historical"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- gains +1 mult when you score
        -- a unique rank/suit combination

        if context.individual and context.cardarea == G.play and not context.blueprint then
            for suit, table in ipairs(card.ability.extra.cards_scored) do
                if context.other_card:is_suit(suit) then
                    for i = 1, #card.ability.extra.cards_scored[suit] do
                        
                    end
                end
            end
        end

    end
}