-- Most confections create a tag when used in specific contents.

-- Upgrade the next hand you play with +2 mult
SMODS.Consumable {
    key = "popcorn",
    set = "confection",
    order = 1,
    pos = {x = 0, y = 0},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_mult = 1,
        extra = {
            mult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.mult
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_mult
        end
        return {
            
            vars = {
                _return
            }
        } 
    end,
    use = function(self, card, area, copier)
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then

            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_popcorn')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_mult)
                    end
                    
                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
	end,
    set_chocolate_bonus = function(self, chocolate_bonus)

        if chocolate_bonus then

            self.config.mult = self.config.mult + chocolate_bonus

        end
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
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 5,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_icecream')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)
                    
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
	end,
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.chips = self.config.chips + chocolate_bonus
        end

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
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_candy')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
	end,
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.h_size = self.config.h_size + chocolate_bonus
        end

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
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()

                    local _tag = Tag('tag_kino_peanut')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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

                tag:yep('+', G.C.GOLD,function() 
                    return true
                end)
            tag.triggered = true
            return false
        end
    end,
    in_pool = function()
		return false
	end,
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.dollars = self.config.dollars + chocolate_bonus
        end

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
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_pizza')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)

                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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

        -- Check for right context.
        if context.type == tag.config.type then

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
	end,
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.retriggers = self.config.retriggers + chocolate_bonus
        end

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
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_soda')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.retriggers = self.config.retriggers + chocolate_bonus
        end

    end
}

-- Draw 2 cards.
SMODS.Consumable {
    key = "chocolate_bar",
    set = "confection",
    order = 7,
    pos = {x = 0, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
        extra = {
            cards_drawn = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_drawn
            }
        } 
    end,
    -- Create a tag while in shop, just do it while in game
    use = function(self, card, area, copier)
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _cards_drawn = card.ability.extra.cards_drawn
                    if card.ability.kino_choco then
                        _cards_drawn = card.ability.extra.cards_drawn + self.config.choco_bonus
                    end


                    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
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

    config = {type = 'round_start_bonus', cards_drawn = 2},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.cards_drawn}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            G.FUNCS.draw_from_deck_to_hand(tag.config.cards_drawn)
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.cards_drawn = self.config.cards_drawn + chocolate_bonus
        end

    end
}



-- Upgrade the next scoring card with +10 chips
SMODS.Consumable {
    key = "fries",
    set = "confection",
    order = 8,
    pos = {x = 1, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if self.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 5,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_fries')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end
                    
                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
            context.card.ability.perma_bonus = context.card.ability.perma_bonus + self.config.bonus_chips
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.bonus_chips = self.config.bonus_chips + chocolate_bonus
        end

    end
}


-- level up the next hand played
SMODS.Consumable {
    key = "hotdog",
    set = "confection",
    order = 9,
    pos = {x = 2, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _tag = Tag('tag_kino_hotdog')
                    if card.ability.kino_choco then
                        _tag:set_chocolate_bonus(self.config.choco_bonus)
                    end

                    add_tag(_tag)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
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
        if context.type == self.config.type then
            level_up_hand(tag, context.scoring_name, nil, self.config.level)
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.level = self.config.level + chocolate_bonus
        end

    end
}

-- Gain +1 hand this round.
SMODS.Consumable {
    key = "cookie",
    set = "confection",
    order = 10,
    pos = {x = 3, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _extra_hands = card.ability.extra.hands
                    if card.ability.kino_choco then
                        _extra_hands = _extra_hands + self.config.choco_bonus
                    end
                    ease_hands_played(_extra_hands)
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

    config = {type = 'round_start_bonus', hands = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.hands}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.hands = self.config.hands + chocolate_bonus
        end

    end
}

-- Gain +1 discard this round.
SMODS.Consumable {
    key = "gum",
    set = "confection",
    order = 11,
    pos = {x = 4, y = 1},
    atlas = "kino_confections",
    can_use = function(self, card)
        if G.GAME.blind.in_blind or card.area == G.pack_cards then
		    return true
        end
	end,
    keep_on_use = function(self, card)
        if card.area == G.pack_cards then
            return true
        end

        if card.ability.kino_extra_large then
            if not card.config.used_once then
                card.config.used_once = true
                return true
            end
        end
    end,
    config = {
        choco_bonus = 1,
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
        if G.GAME.blind.in_blind and card.area ~= G.pack_cards then
            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local _extra_discards = card.ability.extra.discards
                    if card.ability.kino_choco then
                        _extra_discards = _extra_discards + self.config.choco_bonus
                    end

                    ease_discard(card.ability.extra.discards)
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

    config = {type = 'round_start_bonus', discards = 1},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.discards}}
    end,
    apply = function(self, tag, context)
        if context.type == tag.config.type then
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
    set_chocolate_bonus = function(self, chocolate_bonus)
        
        if chocolate_bonus then
            self.config.discards = self.config.discards + chocolate_bonus
        end

    end
}