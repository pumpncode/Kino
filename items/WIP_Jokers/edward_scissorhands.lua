SMODS.Joker {
    key = "edward_scissorhands",
    order = 51,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If your first played hand of the round is only a single high card,
        -- cut it in half after scoring.

        if context.after and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            if #context.full_hand == 1 then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1

                local _suit = context.full_hand[1].base.suit
                local _rank = math.floor(context.full_hand[1].base.id / 2, 2)
                local _uneven = false

                if _rank % 1 == 0.5 then
                    _uneven = true
                end
                
                for i = 2, 2 do
                    local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)

                    if _uneven then
                        if i == 1 then
                            _rank = _rank - 0.5
                        end
                        if i == 2 then
                            _rank = _rank + 0.5
                        end
                    end
                    SMODS.change_base(_card, nil, _rank)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                end
                
            end
        end


        
    end
}