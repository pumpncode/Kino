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

    print("This is the thing card = " .. G.GAME.current_round.kino_thing_card.suit)
end

----------------------
-- COLOURS --
local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["action"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["animation"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["christmas"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["crime"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["drama"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["fantasy"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["gangster"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["heist"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["historical"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["horror"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["musical"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["romance"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["scifi"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["silent"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["sports"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["superhero"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["thriller"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["war"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["western"] = HEX("0086a5")

    return genrecolors(_c, _default)
end