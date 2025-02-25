-- Support Functions Needed:
-- 1. Create a tooltip for the genre
-- 2. Create a tooltip for the director
-- 3a. make jokers be able to check their cast, and compare.
-- 3b. start displaying cast members over the corresponding jokers if they're present in at least 3 owned jokers.

-- Is genre

-- Genre tooltip

-- Is director

-- Is cast

-- Director tooltip

-- Get Random hand type (Based on the neutronstarrandomhand function from Cryptid. (Planets.lua - line 830 - 853))
function get_random_hand()
    local rand_hand
    while true do
        rand_hand = pseudorandom_element(G.handlist, pseudoseed("random"))
        if G.GAME.hands[rand_hand].visible then
            break
        end
    end

    return rand_hand
end

-- Add a function to trigger jokers when money is spend in the shop (Based on cryptid, exotic.lua, l. 1407-1413)
local base_ease_dollars = ease_dollars
function ease_dollars(mod, x)
    base_ease_dollars(mod, x)

    for i = 1, #G.jokers.cards do 
        local effects = G.jokers.cards[i]:calculate_joker({kino_ease_dollars = mod})
    end
    
end

-- Add a function to randomize suits for jokers that need that (added to the ancient card functionality)
-- also resets sci-fi cards upgraded
local rac = reset_ancient_card
function reset_ancient_card()
    rac()
    if not G.GAME.current_round.kino_thing_card then
        G.GAME.current_round.kino_thing_card = { suit = "Spades" }
    end

    local thing_suits = {}
    for k, v in ipairs({'Spades','Hearts','Clubs','Diamonds'}) do
        if v ~= G.GAME.current_round.kino_thing_card.suit then thing_suits[#thing_suits + 1] = v end
    end
    local thing_card = pseudorandom_element(thing_suits, pseudoseed('thing'..G.GAME.round_resets.ante))
    G.GAME.current_round.kino_thing_card.suit = thing_card
end

-- Catch me if you can, select random rank
function generate_cmifc_rank()
    if not G.GAME.current_round.kino_cmifc_rank then
        G.GAME.current_round.kino_cmifc_rank = 2
    end

    local ranks = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
    G.GAME.current_round.kino_cmifc_rank = pseudorandom_element(ranks, "cmifc")
end

-- For everything that needs to be done when the shop is closed.
function end_shopping()
    G.GAME.current_round.sci_fi_upgrades_last_round = 0
end

---- Add Scrap functionality
function update_scrap(num, is_set)
    -- num is the number to increment or set the scrap by
    -- is_set == true will set instead of increment
    if not G.GAME.current_round.scrap_total then
        G.GAME.current_round.scrap_total = 0
    end

    if is_set then
        G.GAME.current_round.scrap_total = num
    else
        G.GAME.current_round.scrap_total = G.GAME.current_round.scrap_total + num
    end
end

---- Add Matchmaking functionality
function update_matches(num, is_set)
    -- num is the number to increment or set the scrap by
    -- is_set == true will set instead of increment
    if not G.GAME.current_round.matchmade_total then
        G.GAME.current_round.matchmade_total = 0

    end

    if is_set then
        G.GAME.current_round.matchmade_total = num
    else
        G.GAME.current_round.matchmade_total = G.GAME.current_round.matchmade_total + num
    end
end


-- Booster:Set_cost hook for oceans_11	
local b_sc = Card.set_cost
function Card:set_cost()
    b_sc(self)
    if self.ability.set == "Booster" and next(find_joker('j_kino_oceans_11')) then
        self.cost = 0
    end
end

-- level_up_hand hook to allow for interstellar functionality
local luh = level_up_hand
function level_up_hand(card, hand, instant, amount, interstellar)
    if card and card.ability.set == "Planet" and next(find_joker('j_kino_interstellar'))
    and not interstellar then
        SMODS.calculate_context({interstellar = true, planet = card})
    else
        luh(card, hand, instant, amount)
    end
end

-- Upgrade Hand functionality for alternative upgrades.
function upgrade_hand(card, hand, chips, mult, x_chips, x_mult)
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

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
end

-- Hook to add repetition tag functionality
local smods_calculate_repetitions = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
    
    -- tag
    for i = 1, #G.GAME.tags do
        local _reps = G.GAME.tags[i]:apply_to_run({type = 'repetition_check', card = card})

        if _reps and _reps.repetitions then
            for r = 1, _reps.repetitions do
                reps[#reps + 1] = {key = _reps}
            end        
        end 
    end

    reps = smods_calculate_repetitions(card, context, reps)

    return reps
end

-- Hook to add card upgrade tag functionality
local smods_score_card = SMODS.score_card
SMODS.score_card = function(card, context)

    for i = 1, #G.GAME.tags do
        G.GAME.tags[i]:apply_to_run({type = 'card_scoring', card = card, before = true})
    end

    smods_score_card(card, context)

    for i = 1, #G.GAME.tags do
        G.GAME.tags[i]:apply_to_run({type = 'card_scoring', card = card, after = true})
    end
end

-- Changes the can_discard function to account for monster cards
local can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    -- checks if _monster_cards exist
    local _monster = false
    for k, v in pairs(G.hand.highlighted) do
        if SMODS.has_enhancement(v, "m_kino_monster") then
            _monster = true
            break
        end
    end

    if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 or _monster then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'discard_cards_from_highlighted'
    end
end

----------------------
-- COLOURS --
local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = HEX("0a4a59")
    G.ARGS.LOC_COLOURS["Animation"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Comedy"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Christmas"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Crime"] = HEX("6a4c47") 
    G.ARGS.LOC_COLOURS["Drama"] = HEX("694c77")
    G.ARGS.LOC_COLOURS["Family"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Fantasy"] = HEX("087ad9")
    G.ARGS.LOC_COLOURS["Gangster"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Heist"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Historical"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Horror"] = HEX("372a2d")
    G.ARGS.LOC_COLOURS["Musical"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Romance"] = HEX("c8117d") 
    G.ARGS.LOC_COLOURS["Sci-fi"] = HEX("1eddd4")
    G.ARGS.LOC_COLOURS["Silent"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Sports"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Superhero"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Thriller"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["War"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Western"] = HEX("0086a5") -- No color picked yet

    return genrecolors(_c, _default)
end

--- Global Variables ---
Kino.jump_scare_mult = 3