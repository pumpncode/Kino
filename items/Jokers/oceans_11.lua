SMODS.Joker {
    key = "oceans_11",
    order = 132,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 3},
    cost = 15,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Heist", "Crime", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Booster packs are free
        
    end,
    add_to_deck = function(self, card, from_debuff)
		for i = 1, #G.shop_booster.cards do
            G.shop_booster.cards[i]:set_cost(true)
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        for i = 1, #G.shop_booster.cards do
            G.shop_booster.cards[i]:set_cost()
        end
	end,
}