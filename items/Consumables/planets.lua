-- Gives 30 chips and 3 mult to a random hand.
SMODS.Consumable {
    key = "ego",
    set = "Planet",
    order = 1,
    pos = {x = 0, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 30,
            mult = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    use = function(self, card, area, copier)
        -- Select random planet
        local _hand = get_random_hand()
        upgrade_hand(card, _hand, card.ability.extra.chips, card.ability.extra.mult)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- your most played hand gains +mult and +2 * chips equal to its level
SMODS.Consumable {
    key = "pandora",
    set = "Planet",
    order = 2,
    pos = {x = 1, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    use = function(self, card, area, copier)

        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        upgrade_hand(card, _hand, card.ability.extra.chips * _tally , 0)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- Arrakis: double the mult and chips of one of your least played hands.
SMODS.Consumable {
    key = "arrakis",
    set = "Planet",
    order = 3,
    pos = {x = 2, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            x_mult = 2,
            x_chips = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_chips,
            }
        }
    end,
    use = function(self, card, area, copier)

        local _hand, _tally = nil, nil
        local _hands = {}
		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played < _tally) then
				_hand = v
                _hands = {}
				_tally = G.GAME.hands[v].played
			end
            if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played == _tally) then
				_hands[#_hands] = v
			end
		end

        if #_hands >= 2 then
            _hand = pseudorandom_element(_hands, pseudoseed("arrakis"))
        end

        upgrade_hand(card, _hand, 0, 0, card.ability.extra.x_chips, card.ability.extra.x_mult)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- Krypton: level up your most played hand once for each level it has.
-- 1/100 chance to reset it back to 1 instead. double the chance whenever you use
-- krypton
SMODS.Consumable {
    key = "krypton",
    set = "Planet",
    order = 4,
    pos = {x = 3, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chance_cur = 1,
            a_chance = 2,
            chance_max = 100,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.min(G.GAME.probabilities.normal * (2 ^ (G.GAME.current_round.kryptons_used - 1)), card.ability.extra.chance_max),
                card.ability.extra.chance_max,
                G.GAME.current_round.kryptons_used
            }
        }
    end,
    use = function(self, card, area, copier)

        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played > _tally) then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        if pseudorandom("krypton") < ((G.GAME.probabilities.normal * (2 ^ (G.GAME.current_round.kryptons_used - 1))) / card.ability.extra.chance_max) then
            level_up_hand(card, _hand, nil, (-1 * G.GAME.hands[_hand].level) + 1)
        else
            level_up_hand(card, _hand, nil, G.GAME.hands[_hand].level)
        end

        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )

        G.GAME.current_round.kryptons_used = G.GAME.current_round.kryptons_used + 1
    end
}

-- Cybertron: upgrade a random hand with X0.1 for each time a sci-fi card was upgraded this round.
if kino_config.sci_fi_enhancement then
SMODS.Consumable {
    key = "cybertron",
    set = "Planet",
    order = 5,
    pos = {x = 4, y = 4},
    atlas = "kino_tarot",
    enhancement_gate = "m_kino_sci_fi",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            x_mult = 0.1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                1 + G.GAME.current_round.sci_fi_upgrades_last_round * card.ability.extra.x_mult
            }
        }
    end,
    use = function(self, card, area, copier)

        local _hand = get_random_hand()
        local _x_mult = G.GAME.current_round.sci_fi_upgrades_last_round * card.ability.extra.x_mult
        upgrade_hand(card, _hand, 0, 0, 0, _x_mult)

        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}
end

-- LV426. Upgrade your most played hand and debuff two random cards in your deck.
SMODS.Consumable {
    key = "lv426",
    set = "Planet",
    order = 6,
    pos = {x = 5, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            debuff_num = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.debuff_num
            }
        }
    end,
    use = function(self, card, area, copier)

        -- Find most played hand
        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played > _tally) then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        for i = 1, card.ability.extra.debuff_num do
            local _card = nil
            local _found_target = false
            while not _found_target do
                _card = pseudorandom_element(G.deck.cards)
                if not _card.debuff then
                    _found_target = true
                end
            end
                
            SMODS.debuff_card(_card, true, card.config.center.key)
        end

        level_up_hand(card, _hand, nil, 1)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}