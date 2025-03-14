-- Balatro Goes Kino
-- general_functions.lua
-- General functions and hooks

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

-- Changes the can_discard function to account for monster cards
local can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    -- checks if _monster_cards exist
    local _monster = 0
    for k, v in pairs(G.hand.highlighted) do
        if SMODS.has_enhancement(v, "m_kino_monster") then
            _monster = _monster + 1
            break
        end
    end

    local _monster_exemptions = 0
    for i, _joker in ipairs(G.jokers.cards) do
        if _joker and _joker.ability and type(_joker.ability.extra) == "table" and
        _joker.ability.extra.stacked_monster_exemptions then
            _monster_exemptions = _monster_exemptions + _joker.ability.extra.stacked_monster_exemptions
        end
    end

    if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 or 
    (_monster > 0 and _monster > _monster_exemptions)then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'discard_cards_from_highlighted'
    end
end

--------- Joker fascilitation hooks ---------

local base_gcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    
    local ret = base_gcb(self)

    local _factor = 1

    for i, joker in ipairs(G.jokers.cards) do
        if joker.ability and joker.ability.extra and joker.ability.extra.nominal_mult_factor then
            _factor = _factor * joker.ability.extra.nominal_mult_factor
        end
    end

    if _factor == 1 then
        _factor = 0
    end

    return ret + (self.base.nominal * _factor)
end

local base_ease_dollars = ease_dollars
function ease_dollars(mod, x)
    base_ease_dollars(mod, x)

    for i = 1, #G.jokers.cards do 
        local effects = G.jokers.cards[i]:calculate_joker({kino_ease_dollars = mod})
    end
end

local b_sc = Card.set_cost
function Card:set_cost(oceans)
    b_sc(self)
    if oceans or (self.ability and self.ability.set == "Booster" and next(find_joker('j_kino_oceans_11')) )then
        self.cost = 0
    end
end

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

--------- Game data setting --------- 

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

function end_shopping()
    G.GAME.current_round.sci_fi_upgrades_last_round = 0
end