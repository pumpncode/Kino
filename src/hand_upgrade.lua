-- Balatro Goes Kino
-- hand_upgrade.lua
-- Contains the functions that allow for specific incremental upgrades to hand types

-- level_up_hand hook to allow for interstellar functionality
local luh = level_up_hand
function level_up_hand(card, hand, instant, amount, interstellar)
    if card and card.ability and card.ability.set == "Planet" and next(find_joker('j_kino_interstellar'))
    and not interstellar then
        SMODS.calculate_context({interstellar = true, planet = card})
    else
        luh(card, hand, instant, amount)
    end
end



-- Upgrade Hand functionality for alternative upgrades.
function upgrade_hand(card, hand, chips, mult, x_chips, x_mult, instant)
    -- card = the source of the upgrade
    -- hand = the hand type being upgraded
    -- chips = the increase in chips
    -- xchips = multiply the chips
    -- xmult = multiply the mult
    -- boolean islevelup = whether the level increases
    chips = chips or 0
    mult = mult or 0
    x_chips = x_chips or 0
    x_mult = x_mult or 0

    
    -- upgrades should be put into an array with whether they were a level up.
    -- the level_up_hand function should be modified to upgrade the hand
    -- after the normal level calc is done.
    local _chips = chips + (G.GAME.hands[hand].chips * x_chips)
    local _mult = mult + (G.GAME.hands[hand].mult * x_mult)

    -- Set mult
    G.GAME.hands[hand].mult_bonus = (G.GAME.hands[hand].mult_bonus or 0) + _mult
    
    -- Set chips
    G.GAME.hands[hand].chips_bonus = (G.GAME.hands[hand].chips_bonus or 0) + _chips 

    -- Set both
    G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1) +  G.GAME.hands[hand].mult_bonus, 1)
    G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1) +  G.GAME.hands[hand].chips_bonus, 1)
    -- play animation

    if not instant then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
end