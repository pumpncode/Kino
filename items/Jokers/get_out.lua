SMODS.Joker {
    key = "get_out",
    order = 44,
    config = {
        extra = {
            selected_cards = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card,
        -- Change 3 random cards in your hand into copies of it
        -- then destroy this joker

        if context.after and #context.full_hand == 1 and not context.blueprint and not context.repetition then
            local _cards = {}

            for i = 1, card.ability.extra.selected_cards do
                _cards[i] = pseudorandom_element(G.hand.cards, pseudoseed("get_out"))
            end

            for i = 1, #_cards do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    local new_card = copy_card(context.full_hand[1], _cards[i])
                    new_card:juice_up()
                    return true end }))
            end

            if card.ability.eternal then
                SMODS.debuff_card(card, true, "get_out")
            else
                card.getting_sliced = true
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    card:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
        end

    end
}