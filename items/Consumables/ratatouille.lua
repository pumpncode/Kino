
SMODS.Consumable {
    key = "ratatouille",
    set = "confection",
    order = 99,
    pos = {x = 1, y = 5},
    atlas = "kino_confections",
    hidden = true,
    soul_rate = 0,
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
        extra = {
            times_used = 0,
            stats = {
                popcorn = 0,
                icecream = 0,
                candy = 0,
                peanus = 0,
                pizza = 0,
                soda = 0,
                chocolate_bar = 0,
                fries = 0,
                hotdog = 0,
                cookie = 0,
                gum = 0,
            }
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
    end,
    calculate = function(self, card, context)

        if context.setting_blind and card.active then
            -- Cookie
            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_hands_played(card.ability.extra.stats.cookie)
                    return true
                end)
            }))
            card.ability.extra.stats.cookie = 0
            
            -- Gum
            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_discard(card.ability.extra.stats.gum)
                    return true
                end)
            }))
            card.ability.extra.stats.gum = 0
        end

        if context.hand_drawn and card.active then
            -- Chocolate Bar
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_eaten'), colour = G.C.MULT})
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.stats.chocolate_bar)
                delay(0.23)
                
            return true end }))
            card.ability.extra.stats.chocolate_bar = 0
        end

        if context.before and card.active then
            -- Hotdog
            level_up_hand(card, context.scoring_name, nil, card.ability.extra.stats.hotdog)
            card.ability.extra.stats.hotdog = 0
        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only 
        and card.active then
            -- Big Soda
            if context.scoring_hand[1] == context.other_card then
                return {
                    card = context.card,
                    effect = nil,
                    repetitions = card.ability.extra.stats.soda,
                    message = localize('k_again_ex')
                }
            end

            -- Pizza
        end

        if context.individual and context.scoring_hand[1] and card.active then
            -- Fries
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.stats.fries
            card.ability.extra.stats.fries = 0
        end
    end
}