SMODS.Atlas {
    key = "kino_blinds",
    atlas_table = "ANIMATION_ATLAS",
    path = "kino_blinds.png",
    px = 34,
    py = 34,
    frames = 21
}

--- Final hand is Destroyed
-- WORKS
SMODS.Blind{
    key = "hannibal",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('4f6367'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    debuff = {

    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)
    end,
    calculate = function(self, blind, context)
        if context.destroy_card and context.cardarea == G.hand and
        to_big((hand_chips * mult)) + to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips) then
            return true
        end
    end
}

-- WORKS
--- Darth Vader. Force choke a joker by decreasing its power by 25% every round. If it reaches 0, destroy it
SMODS.Blind{
    key = "vader",
    dollars = 5,
    mult = 2,
    boss_colour = G.C.BLACK,
    atlas = 'kino_blinds', 
    boss = {min = 2, max = 10},
    pos = { x = 0, y = 1},
    debuff = {
        vader_damage = 0.33
    },
    loc_vars = function(self)
        
    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)
        
    end,
    calculate = function(self, blind, context)
        if context.final_scoring_step then
            if G.jokers.cards and G.jokers.cards[1] then
                local _target = G.jokers.cards[1]
                local _is_affected =  _target:get_multiplier_by_source(_target, "vader_blind")
                if _is_affected then
                    if _is_affected <= 0.25 then
                        -- Destroy the joker
                        _target.getting_sliced = true
                        blind:wiggle()
                        G.E_MANAGER:add_event(Event({func = function()
                            card_eval_status_text(_target, 'extra', nil, nil, nil,
                            { message = localize('k_blind_vader_1'), colour = G.C.BLACK})
                            _target:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                else 
                    _is_affected = 1
                end
                G.E_MANAGER:add_event(Event({func = function()
                    blind:wiggle()
                    card_eval_status_text(_target, 'extra', nil, nil, nil,
                    { message = localize('k_blind_vader_2'), colour = G.C.BLACK})
                    _target:set_multiplication_bonus(_target, "vader_blind", _is_affected - self.debuff.vader_damage)
                    return true end }))
            end
        end
    end
}

-- WORKS
--- Decrease base mult and chips by -1 and -10 for each consumable you've used
SMODS.Blind{
    key = "mama",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('642b2b'),
    atlas = 'kino_blinds', 
    boss = {min = 3, max = 10},
    pos = { x = 0, y = 2},
    debuff = {
        chips_debuff = 10,
        mult_debuff = 1,
    },
    loc_vars = function(self)
        return {
            vars = {
                10,
                1
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                10,
                1
            }
        }
    end,
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        local _consumeables_used = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0
        -- return mult, chips, true
        return (math.max(0, mult - (_consumeables_used * self.debuff.mult_debuff))), math.max(0, (hand_chips - (_consumeables_used * self.debuff.chips_debuff))), true
    end
}

-- WORKS
--- -1 mult for every card destroyed
SMODS.Blind{
    key = "cruella",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('dcdcdc'),
    atlas = 'kino_blinds', 
    boss = {min = 3, max = 10},
    pos = { x = 0, y = 3},
    debuff = {
        mult_debuff = 1
    },
    loc_vars = function(self)
        return {
            vars = {
                1,
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                1
            }
        }
    end,
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        -- return mult, chips, true
        return (math.max(0, mult - ((G.GAME.cards_destroyed or 0) * self.debuff.mult_debuff))), hand_chips, true
    end
}

-- SMODS.Blind{
--     key = "voldemort",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('a74ce8'),
--     atlas = 'kino_blinds', 
--     boss = {min = 1, max = 10},
--     pos = { x = 0, y = 4},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,
--     modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
--         local _consumeables_used = G.GAME.consumeable_usage_total.all
--         -- return mult, chips, true
--         return (mult - (_consumeables_used * self.debuff.mult_debuff)), (hand_chips - (_consumeables_used * self.debuff.chips_debuff)), true
--     end
-- }

-- WORKS
--- each scoring card has a 1/10 chance to double your gold, or make you bust
SMODS.Blind{
    key = "gekko",
    dollars = 10,
    mult = 2,
    boss_colour = G.C.MONEY,
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 5},
    debuff = {
        chance = 10
    },
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal,
                10
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal,
                10
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("gekko_blind_double") < (G.GAME.probabilities.normal / self.debuff.chance) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_gekko_1'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    ease_dollars(G.GAME.dollars)
                    play_sound('tarot2', 1, 0.4)
                    blind:wiggle()
                return true end }))

            elseif pseudorandom("gekko_blind_bust") < (G.GAME.probabilities.normal / self.debuff.chance) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_gekko_2'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    ease_dollars(-G.GAME.dollars)
                    play_sound('tarot2', 1, 0.4)
                    blind:wiggle()
                return true end }))
            end
        end
    end
}

-- WORKS
--- Possess your last played hand. If played, set its level to 1
SMODS.Blind{
    key = "pazuzu",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('47361b'),
    atlas = 'kino_blinds', 
    boss = {min = 2, max = 10},
    pos = { x = 0, y = 6},
    debuff = {
        hand_target = ""
    },
    loc_vars = function(self)
        return {
            G.GAME.last_hand_played
        }
    end,
    collection_loc_vars = function(self)
        return{
            "Two of a Kind"
        }
    end,
    calculate = function(self, blind, context)
        if context.after then
            local _handname = blind.debuff.hand_target
            if context.scoring_name == _handname and
            to_big(G.GAME.hands[_handname].level) > to_big(1) then

                level_up_hand(blind.children.animatedSprite, _handname, nil, 1 + -G.GAME.hands[_handname].level)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_pazuzu_1'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    play_sound('tarot2', 1, 0.4)
                    blind:wiggle()
                return true end }))
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_pazuzu_2'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    blind:wiggle()
                return true end }))
            end

            blind.debuff.hand_target = G.GAME.last_hand_played
        end
    end
}

-- WORKS
-- Debuff scored hand, chance 
SMODS.Blind{
    key = "xenomorph",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('267508'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 7},
    debuff = {
        chance = 3
    },
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal,
                3
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal,
                3
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("alien_blind") < (G.GAME.probabilities.normal / blind.debuff.chance) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    if context.other_card then
                        SMODS.debuff_card(context.other_card, true, "xenomorph_blind")
                    end
                return true end }))
            end
        end
    end
}

-- TEST AGAIN
-- -- Hand may not contain specific rank or suit
SMODS.Blind{
    key = "bonnieandclyde",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('f2c0e5'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 8},
    debuff = {
    },
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.current_round.bonnierank,
                G.GAME.current_round.clydesuit
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                2,
                "Spades"
            }
        }
    end,

	debuff_hand = function(self, cards, hand, handname, check)
        for _, _card in ipairs(cards) do
            if _card:get_id() == G.GAME.current_round.bonnierank or 
            _card:is_suit(G.GAME.current_round.clydesuit) then
                return true
            end
        end

        return false
    end
}

-- WORKS
-- Debuff cards
SMODS.Blind{
    key = "dracula",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('5f5f5f'),
    atlas = 'kino_blinds', 
    boss = {min = 2, max = 10},
    pos = { x = 0, y = 9},
    debuff = {
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    calculate = function(self, blind, context)
        if context.after then
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                    enhanced[#enhanced+1] = v
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end

            if #enhanced > 1 then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_dracula_1'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    blind:wiggle()
                return true end }))
            end
        end
    end
}

-- Works
SMODS.Blind{
    key = "wickedwitch",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('a74ce8'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 10},
    debuff = {
        
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    calculate = function(self, blind, context)
        if context.pre_discard then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    for i = 1, 2 do
                        local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                        local _card = create_playing_card({
                            front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                            center = G.P_CENTERS.m_kino_flying_monkey}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    end
                    return true
                end}))
        end
    end
}

-- WORKS
SMODS.Blind{
    key = "frankbooth",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('19379f'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 11},
    debuff = {
        chips_debuff = 10,
        mult_debuff = 1,
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    press_play = function(self)
        if G.GAME.current_round.hands_played > 0 then
            if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
                if not G.jokers.cards[3].getting_sliced then
                    G.E_MANAGER:add_event(Event({func = function()
                        G.jokers.cards[3]:juice_up(0.8, 0.8)
                        G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
            end
        end
    end,
}

-- WORKS
SMODS.Blind{
    key = "joker",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('62319d'),
    atlas = 'kino_blinds', 
    boss = {min = 2, max = 11},
    pos = { x = 0, y = 12},
    debuff = {

    },
    set_blind = function(self)
        G.GAME.current_round.boss_blind_joker_counter = 0
    end,
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    calculate = function(self, blind, context)
        if context.final_scoring_step then
            G.GAME.current_round.boss_blind_joker_counter = G.GAME.current_round.boss_blind_joker_counter + 1
            if G.GAME.current_round.boss_blind_joker_counter < 2 then
                local _num = G.GAME.current_round.boss_blind_joker_counter
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_joker_' .. _num),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    blind:wiggle()
                return true end })) 
            end

            if G.GAME.current_round.boss_blind_joker_counter >= 2 then
                G.GAME.current_round.boss_blind_joker_counter = 0
                local _card = pseudorandom_element(G.jokers.cards, pseudoseed("joker_blind"))
                
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_blind_joker_final'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    blind:wiggle()
                    _card:flip()
                    _card:juice_up()
                    _card:set_ability("j_joker")
                    _card:flip()

                return true end }))
            end
        end


    end
}

-- WORKS
SMODS.Blind{
    key = "hansgruber",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('4f4858'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 13},
    debuff = {
        chips_debuff = 10,
        mult_debuff = 1,
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    in_pool = function(self)
        if to_big(G.GAME.dollars) > to_big(25) then
            return true
        end
        return false
    end,
    press_play = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            ease_dollars(-1 * round_number(G.GAME.dollars / 2, 0))
            return true end })) 
    end,
}

-- WORKS
SMODS.Blind{
    key = "blofeld",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('c0c0bc'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 14},
    debuff = {
        h_size_le = G.GAME and G.GAME.current_round.boss_blind_blofeld_counter or 100000
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    defeat = function(self)
        G.GAME.current_round.boss_blind_blofeld_counter = 10000
    end,
    disable = function(self)
        G.GAME.current_round.boss_blind_blofeld_counter = 10000
    end,
    calculate = function(self, blind, context)
        if context.after then
            G.GAME.current_round.boss_blind_blofeld_counter = #context.full_hand
        end
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if (G.GAME.current_round.boss_blind_blofeld_counter or 100000) < #cards then
            return true
        end

        return false

        
    end
}

-- UPDATE 0.9 Blinds

-- WORKS
SMODS.Blind{
    key = "loki",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('632c82'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 15},
    debuff = {
        suit = 'Hearts'
    },
    loc_vars = function(self)
        return {
            vars = {
                self.debuff.suit
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                self.debuff.suit
            }
        }
    end,

    calculate = function(self, blind, context)
        if context.after then
            local _suit = pseudorandom_element(SMODS.Suits, pseudoseed("kino_source_code"))
            

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                blind.debuff.suit = _suit.key
                print(_suit.key)
                attention_text({
                    text = localize('k_blind_loki'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = G.play,
                    align = 'tm',
                    offset = {x = 0, y = -1},
                    silent = true
                })
                blind:wiggle()
                for _, _pcard in ipairs(G.playing_cards) do
                    SMODS.recalc_debuff(_pcard)
                end
            return true end }))

            
        end
    end
}

-- WORKS
SMODS.Blind{
    key = "ratched",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('FFFFFF'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 16},
    debuff = {
        cardcount = 3
    },
    loc_vars = function(self)
        return {
            vars = {
                self.debuff.cardcount
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                self.debuff.cardcount
            }
        }
    end,

	debuff_hand = function(self, cards, hand, handname, check)
        local _suitcount = 0
        for suitname, suitdetails in pairs(SMODS.Suits) do
            for _, _pcard in ipairs(G.hand.cards) do
                local _highlighted = false
                for __, _cardmatch in ipairs(G.hand.highlighted) do
                    if _cardmatch == _pcard then
                        _highlighted = true
                        break
                    end
                end

                if _pcard:is_suit(suitname) and _highlighted == false then
                    _suitcount = _suitcount + 1
                    break
                end
            end
        end

        if _suitcount < self.debuff.cardcount then
            return true
        else
            return false
        end
    end
}

-- NO FUNCTIONALITY
SMODS.Blind{
    key = "rico_dynamite",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('7fc9d1'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 17},
    debuff = {
        level_down = 2,
        level_up = 1
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    press_play = function(self)
        -- 
    end,
    calculate = function(self, blind, context)
        if context.before then
            if G.GAME.hands[context.scoring_name].level > to_big(1) then
                local _targethand = context.scoring_name
                local _decrease = blind.debuff.level_down
                if G.GAME.hands[context.scoring_name].level == 2 then
                    _decrease = 1
                end

                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    
                    level_up_hand(blind, _targethand, nil, -1 * _decrease)

                    for i = 1, 2 do
                        local _randomhand = get_random_hand()
                        level_up_hand(blind, _randomhand, true, 1)
                    end
                    
                    attention_text({
                        text = localize('k_blind_rico_dyn'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    blind:wiggle()
                return true end }))
            end
        end
    end
}

-- NO FUNCTIONALITY
SMODS.Blind{
    key = "mr_chow",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('cbbf9d'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 18},
    debuff = {
        chips_debuff = 10,
        mult_debuff = 1,
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    calculate = function(self, blind, context)
        if context.after then
            for _, _pcard in ipairs(context.scoring_hand) do
                _pcard.ability.perma_p_dollars = _pcard.ability.perma_p_dollars or 0
                _pcard.ability.perma_p_dollars = _pcard.ability.perma_p_dollars - 1
            end
        end
    end
}

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "deckard_shaw",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3d5a82'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 19},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }

-- WORKS
SMODS.Blind{
    key = "entity",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('403f39'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 20},
    debuff = {
        chance = 3
    },
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal, 
                self.debuff.chance
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                G.GAME.probabilities.normal, 
                self.debuff.chance
            }
        }
    end,

    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("kino_blind_entity") < G.GAME.probabilities.normal / blind.debuff.chance then
                local _pcard = context.other_card
                G.E_MANAGER:add_event(Event({func = function()
                    local _suit = pseudorandom_element(SMODS.Suits, pseudoseed("kino_source_code"))
                    local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed("kino_source_code"))
                    print(_suit.key)
                    print(_rank.key)
                    blind:wiggle()
                    _pcard:flip()
                    SMODS.change_base(_pcard, _suit.key, _rank.key)
                    _pcard:flip()
                    blind:wiggle()

                return true end }))
                
            end
        end
    end
}

-- WORKS
SMODS.Blind{
    key = "humungus",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('8f6623'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 21},
    debuff = {
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            for _, _pcard in ipairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({func = function()

                    blind:wiggle()
                    _pcard:flip()
                    SMODS.modify_rank(_pcard, -1)
                    _pcard:flip()
                    blind:wiggle()

                return true end }))
            end
        end
    end
}

-- WORKS
SMODS.Blind{
    key = "amadeus",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('c3b07d'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 22},
    debuff = {
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        local _multchange = 0
        local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(cards)
        
        for _key, _hand in pairs(G.GAME.hands) do
            if _key ~= scoring_hand then
                _multchange = _multchange + _hand.level
            end
        
        end

        -- return mult, chips, true
        return (math.max(1, mult - _multchange)), hand_chips, true
    end
}

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "sallie_tomato",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('8f6623'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 23},
--     debuff = {
--         money_earned = 3
--     },
--     loc_vars = function(self)
--         return {
--             vars = {
--                 self.debuff.money_earned,
--                 self.debuff.money_earned * 2
--             }
--         }
--     end,
--     collection_loc_vars = function(self)
--         return {
--             vars = {
--                 self.debuff.money_earned,
--                 self.debuff.money_earned * 2
--             }
--         }
--     end,
--     calculate = function(self, blind, context)
--         if context.first_hand_drawn then
            
--         end
--     end
-- }

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "agent_smith",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3f5634'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 24},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }


-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "anton_chigurh",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('228691'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 25},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "thanos",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3f5634'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 26},
--     debuff = {
--         suit_1 = 'Hearts',
--         suit_2 = 'Spades'
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,
--     set_blind = function(self)
--         -- separate all cards into two buckets

--     end,
--     press_play = function(self)
       

--     end,
--     calculate = function(self, blind, context)

--     end
-- }

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "immortan_joe",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3f5634'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 27},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "palpatine",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3f5634'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 28},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }

-- NO FUNCTIONALITY
-- SMODS.Blind{
--     key = "dr_evil",
--     dollars = 5,
--     mult = 2,
--     boss_colour = HEX('3f5634'),
--     atlas = 'kino_blinds', 
--     boss = {min = 4, max = 10},
--     pos = { x = 0, y = 29},
--     debuff = {
--         chips_debuff = 10,
--         mult_debuff = 1,
--     },
--     loc_vars = function(self)

--     end,
--     collection_loc_vars = function(self)

--     end,

--     press_play = function(self)
--         if G.GAME.current_round.hands_played > 1 then
--             if G.jokers.cards and #G.jokers.cards > 2 and G.jokers.cards[3] then
--                 if not G.jokers.cards[3].getting_sliced then
--                     G.E_MANAGER:add_event(Event({func = function()
--                         G.jokers.cards[3]:juice_up(0.8, 0.8)
--                         G.jokers.cards[3]:start_dissolve({G.C.RED}, nil, 1.6)
--                     return true end }))
--                 end
--             end
--         end
--     end,
-- }