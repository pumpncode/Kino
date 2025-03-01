SMODS.Joker {
    key = "bttf",
    order = 10,
    config = {
        extra = {
            card_1 = "???",
            card_2 = "???",
            card_3 = "???",
            colours = {"nil","nil","nil"},
            amount = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 1 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 105,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.card_1,
                card.ability.extra.card_2,
                card.ability.extra.card_3,
                card.ability.extra.amount
            }
        }
    end,
    calculate = function(self, card, context)
        -- Shows you the top three cards

        card.ability.extra.card_1 = "" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or "?")..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or '??')
        card.ability.extra.card_2 = "" .. (G.deck and G.deck.cards[2] and G.deck.cards[#G.deck.cards -1].base.id or "???")..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards-1].base.suit:sub(1,1) or '??')
        card.ability.extra.card_3 = "" .. (G.deck and G.deck.cards[3] and G.deck.cards[#G.deck.cards -2].base.id or "???")..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards-2].base.suit:sub(1,1) or '??')
    end
}