SMODS.Joker {
    key = "pride_and_prejudice",
    order = 147,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 4},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Drama"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- After you draw a card, if you only have 1 romance card in your hand
        -- Draw an additional romance card from your deck
        if context.hand_drawn and not context.blueprint then
            local _total_romance_cards = 0
            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], "m_kino_romance") then
                    _total_romance_cards = _total_romance_cards + 1
                end
            end

            if _total_romance_cards == 1 then
                local _rom_card = nil
                local _rom_spot = 0
                for i = 1, #G.deck.cards do
                    if SMODS.has_enhancement(G.deck.cards[i], "m_kino_romance") then
                        _rom_card = G.deck.cards[i]
                        _rom_spot = i
                        -- G.hand:emplace(G.deck.cards[i])
                        -- G.deck.cards[i]:flip()
                        -- _card.states.visible = nil
                        break
                    end
                end

                if _rom_spot ~= 0 then
                    local _buffer_card = G.deck.cards[#G.deck.cards]
                    G.deck.cards[#G.deck.cards] = _rom_card
                    G.deck.cards[_rom_spot] = _buffer_card

                    G.FUNCS.draw_from_deck_to_hand(1)
                end
            end
        end
    end
}