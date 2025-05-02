SMODS.Joker {
    key = "pirates_of_the_caribbean_1",
    order = 242,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cost_non = 10,
            cost_mod = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 22,
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
    pools, k_genre = {"Fantasy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you destroy a card, lose $10 and create a copy with a random enhancement instead

        if context.remove_playing_cards then
            for i = 1, #context.removed do

                -- check for money

                -- create card
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.4,
					func = function()
						card:juice_up(0.3, 0.4)
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _c = copy_card(context.destroy_card, nil, nil, G.playing_card)
                        local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'drwho'})
                        _c:set_ability(G.P_CENTERS[new_enhancement])
						_c:start_materialize()
						_c:add_to_deck()

						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _c)
						G.hand:emplace(_c)
						playing_card_joker_effects({ _c })
						return true
					end,
				}))

                return true
            end
        end
    end
}