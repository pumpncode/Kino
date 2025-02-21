SMODS.Joker {
    key = "chef",
    order = 16,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- when you select a blind, create a random confection
        if context.setting_blind then
            if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, "kino_chef")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                    card_eval_status_text(context.blueprint_card or card, 
                    'extra', nil, nil, nil, {message = localize('k_chef'), colour = G.C.CHIPS})                
            end
        end
    end
}