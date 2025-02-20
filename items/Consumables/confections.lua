-- Most confections create a tag when used in specific contents.

-- Upgrade the next hand you play with +2 mult
SMODS.Consumable {
    key = "popcorn",
    set = "confection",
    order = 1,
    pos = {x = 0, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            mult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_popcorn'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "popcorn",
    atlas = "kino_tags",
    pos = {x = 0, y = 0},

    config = {type = 'hand_played', mult = 2},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.mult}}
    end,
    apply = function(self, tag, context)
        if context.type == self.config.type then
            if context.before then
                upgrade_hand(nil, context.scoring_name, 0, self.config.mult)
                tag:yep('+', G.C.MULT, function()
                    return true
                end, 0)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function()
		return false
	end
}

-- Upgrade the next hand you play with +10 chips
SMODS.Consumable {
    key = "icecream",
    set = "confection",
    order = 2,
    pos = {x = 1, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_icecream'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "icecream",
    atlas = "kino_tags",
    pos = {x = 1, y = 0},

    config = {type = 'hand_played', chips = 10},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.chips}}
    end,
    apply = function(self, tag, context)
        if context.type == self.config.type then
            if context.before then
                upgrade_hand(nil, context.scoring_name, self.config.chips, 0)
                tag:yep('+', G.C.MULT, function()
                    return true
                end, 0)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function()
		return false
	end
}

-- Gain +1 hand size until the end of this round
SMODS.Consumable {
    key = "candy",
    set = "confection",
    order = 3,
    pos = {x = 2, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            hand_size = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_candy'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "candy",
    atlas = "kino_tags",
    pos = {x = 2, y = 0},

    config = {type = 'round_start_bonus', h_size = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.h_size}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            tag:yep('+', G.C.BLUE,function() 
                return true
            end)
            G.hand:change_size(tag.config.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + tag.config.h_size
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end
}

-- Double the interest this round
SMODS.Consumable {
    key = "peanuts",
    set = "confection",
    order = 4,
    pos = {x = 3, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            extra = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.extra
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_peanut'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))



    end
}

SMODS.Tag{
    key = "peanut",
    atlas = "kino_tags",
    pos = {x = 3, y = 0},

    config = {type_one = 'eval_interest', type = 'shop_start', dollars = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.dollars}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type_one then
            G.GAME.interest_amount = G.GAME.interest_amount + tag.config.dollars
        end
        if context.type == tag.config.type then
            G.GAME.interest_amount = G.GAME.interest_amount - tag.config.dollars
            print(G.GAME.interest_amount)
                tag:yep('+', G.C.GOLD,function() 
                    return true
                end)
            tag.triggered = true
            return false
        end
    end,
    in_pool = function()
		return false
	end
}

-- Retrigger the first card of each suit a second time this round.
SMODS.Consumable {
    key = "pizza",
    set = "confection",
    order = 5,
    pos = {x = 4, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            retriggers = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_pizza'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "pizza",
    atlas = "kino_tags",
    pos = {x = 4, y = 0},

    config = {type = 'repetition_check', type_end = 'hand_played', retriggers = 1},
    loc_vars = function(self, info_queue)
        return {
            vars = {
                self.config.retriggers
            }}
    end,
    set_ability = function(self, tag)
        tag.ability.suits = {}
    end,
    apply = function(self, tag, context)

        print("TESTING WTH  " .. context.type .. " & " .. tag.config.type)
        -- Check for right context.
        if context.type == tag.config.type then
            print("entered")
            print(#tag.ability.suits .. " suits when entered")
            -- Check for suits already encountered
            local _is_viable = true
            for i = 1, #tag.ability.suits do
                if context.card.config.card.suit == tag.ability.suits[i] then
                    _is_viable = false
                    break
                end 
            end

            if _is_viable and 
            context.card.config.center ~= G.P_CENTERS.m_stone then
                tag.ability.suits[#tag.ability.suits + 1] = context.card.config.card.suit
                print(#tag.ability.suits .. " suits before return")
                return {
                    card = context.card,
                    effect = nil,
                    repetitions = tag.config.retriggers,
                    message = localize('k_again_ex')
                }
            end
        end

        -- after hand is played, disappear
        if context.type == tag.config.type_end and context.after then
            tag:yep('+', G.C.GOLD,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end
}

-- retrigger the first scoring card twice
SMODS.Consumable {
    key = "soda",
    set = "confection",
    order = 6,
    pos = {x = 5, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            retriggers = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_soda'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "soda",
    atlas = "kino_tags",
    pos = {x = 5, y = 0},

    config = {type = 'repetition_check', retriggers = 2},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.retriggers}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            print("Soda print")
            tag:yep('+', G.C.GREEN,function() 
                return true
            end)
            tag.triggered = true
            return {
                card = context.card,
                effect = nil,
                repetitions = tag.config.retriggers,
                message = localize('k_again_ex')
            }
        end
    end,
    in_pool = function()
		return false
	end,
}

-- Draw 2 cards.
SMODS.Consumable {
    key = "chocolate_bar",
    set = "confection",
    order = 7,
    pos = {x = 0, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            hand_size = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size
            }
        } 
    end,
    -- Create a tag while in shop, just do it while in game
    use = function(self, card, area, copier)

        if G.GAME.blind.in_blind then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        else
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_kino_chocolate'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}

SMODS.Tag{
    key = "chocolate",
    atlas = "kino_tags",
    pos = {x = 0, y = 1},

    config = {type = 'immediate', cards_drawn = 2},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.cards_drawn}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type and G.GAME.blind.in_blind then
            G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
            tag:yep('+', G.C.GOLD,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end,
}



-- Upgrade the next scoring card with +10 chips
SMODS.Consumable {
    key = "fries",
    set = "confection",
    order = 8,
    pos = {x = 1, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            bonus_chips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus_chips
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_fries'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "fries",
    atlas = "kino_tags",
    pos = {x = 1, y = 1},

    config = {type = 'card_scoring', bonus_chips = 10},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.bonus_chips}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            context.card.ability.perma_bonus = context.card.ability.perma_bonus + tag.config.bonus_chips
            tag:yep('+', G.C.CHIPS,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end,
}


-- level up the next hand played
SMODS.Consumable {
    key = "hotdog",
    set = "confection",
    order = 9,
    pos = {x = 2, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            level = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.level
            }
        } 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_kino_hotdog'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
}

SMODS.Tag{
    key = "hotdog",
    atlas = "kino_tags",
    pos = {x = 2, y = 1},

    config = {type = 'hand_played', level = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.level}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            level_up_hand(tag, context.scoring_name, nil, tag.config.level)
            tag:yep('+', G.C.GOLD,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end,
}

-- Gain +1 hand this round.
SMODS.Consumable {
    key = "cookie",
    set = "confection",
    order = 10,
    pos = {x = 3, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            hands = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands
            }
        } 
    end,
    use = function(self, card, area, copier)
        if G.GAME.blind.in_blind then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_hands_played(self.ability.extra.hands)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        else
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_kino_cookie'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}

SMODS.Tag{
    key = "cookie",
    atlas = "kino_tags",
    pos = {x = 3, y = 1},

    config = {type = 'immediate', hands = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.hands}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type and G.GAME.blind.in_blind then
            ease_hands_played(tag.config.hands)
            tag:yep('+', G.C.GOLD,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end,
}

-- Gain +1 discard this round.
SMODS.Consumable {
    key = "gum",
    set = "confection",
    order = 11,
    pos = {x = 4, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            discards = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discards
            }
        } 
    end,
    use = function(self, card, area, copier)
        if G.GAME.blind.in_blind then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_discard(card.ability.extra.discards)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        else
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_kino_gum'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}

SMODS.Tag{
    key = "gum",
    atlas = "kino_tags",
    pos = {x = 4, y = 1},

    config = {type = 'immediate', discards = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.discards}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type and G.GAME.blind.in_blind then
            ease_discard(tag.config.discards)
            tag:yep('+', G.C.GOLD,function() 
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function()
		return false
	end,
}