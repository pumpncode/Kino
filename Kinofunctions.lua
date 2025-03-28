-- Support Functions Needed:
-- 1. Create a tooltip for the genre
-- 2. Create a tooltip for the director
-- 3a. make jokers be able to check their cast, and compare.
-- 3b. start displaying cast members over the corresponding jokers if they're present in at least 3 owned jokers.

-- Genre tooltip

-- Is director

-- Is cast

-- Director tooltip

function is_genre(joker, genre)
    if G.GAME.modifiers.egg_genre == genre then
        return true
    end

    if joker.config.center.k_genre then
        for i = 1, #joker.config.center.k_genre do
            if genre == joker.config.center.k_genre[i] then
                return true
            end
        end
    end
    return false
end

function has_cast(joker, actor)
    local _center = nil
    if joker.kino_joker then
        _center = joker.kino_joker
    else
        if joker.config.center and joker.config.center.kino_joker then
            _center = joker.config.center.kino_joker
        else
            _center = joker.kino_joker
            return false
        end 
    end


    for _, _castmember in ipairs(_center.cast) do
        if actor == _castmember then
            return true
        end
    end

    return false
end

function create_cast_list()
    local _castlist = {}
    local _hash = {}

    for _, _joker in ipairs(G.jokers.cards) do
        if _joker.config.center.kino_joker then
            for _, _castmember in ipairs(_joker.config.center.kino_joker.cast) do
                if not _hash[_castmember] then
                    _castlist[#_castlist + 1] = _castmember
                    _hash[_castmember] = true
                end
            end
        end
    end

    return _castlist
end

function has_cast_from_table(joker, actor_table)
    for _, _castmember in ipairs(actor_table) do
        if has_cast(joker, _castmember) then
            return true
        end
    end
    return false
end

function display_egg_message()
    if not G.GAME.egg_message then
        G.GAME.egg_message = UIBox{
            definition = 
            {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
                {n=G.UIT.R, config = {align = 'cm', maxw = 1}, nodes={
                    {n=G.UIT.O, config={object = DynaText({scale = 0.7, string = localize('ph_egg'), maxw = 9, colours = {G.C.WHITE},float = true, shadow = true, silent = true, pop_in = 0, pop_in_rate = 6})}},
                }}
            }}, 
            config = {
                align = 'cm',
                offset ={x=0,y=-3.1}, 
                major = G.play,
            }
        }
        G.GAME.egg_message.attention_text = true
        G.GAME.egg_message.states.collide.can = false
    end

    if G.GAME.egg_message then
        G.GAME.egg_message:remove()
        G.GAME.egg_message = nil
    end
end

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

    reset_raiders_card()
    reset_bonnieandclyde()
end

 -- Indiana Jones checks
function reset_raiders_card()
    if not G.GAME.current_round.kino_indiana_key then
        G.GAME.current_round.kino_indiana_rank = 2
        G.GAME.current_round.kino_indiana_suit = "Spades"
        G.GAME.current_round.kino_indiana_key = "S_2"
    end

    local valid_raiders_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            valid_raiders_cards[#valid_raiders_cards+1] = v
        end
    end

    if valid_raiders_cards[1] then 
        local idol_card = pseudorandom_element(valid_raiders_cards, pseudoseed('raiders'..G.GAME.round_resets.ante))
        G.GAME.current_round.kino_indiana_rank = idol_card:get_id()
        G.GAME.current_round.kino_indiana_suit = idol_card.base.suit
        G.GAME.current_round.kino_indiana_key = idol_card.config.card_key
    end
end

function reset_bonnieandclyde()
    if not G.GAME.current_round.bonnierank then
        G.GAME.current_round.bonnierank = 2
        G.GAME.current_round.clydesuit = "Spades"
    end

    local _ranks = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
    local _suits = {"Hearts", "Diamonds", "Spades", "Clubs"}

    G.GAME.current_round.bonnierank = pseudorandom_element(_ranks, pseudoseed("bonnie_boss"))
    G.GAME.current_round.clydesuit = pseudorandom_element(_suits, pseudoseed("clyde_boss"))
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
function Card:set_cost(oceans)
    b_sc(self)
    if oceans or (self.ability and self.ability.set == "Booster" and next(find_joker('j_kino_oceans_11')) )then
        self.cost = 0
    end
end



---- Kino Syngery system ----
function check_genre_match(joker)
    -- Checks to see how many jokers share a genre with the joker that the function uses
    if not joker.config.center.kino_joker then
        return 
    end

    local _jokers_that_share_genre = 0
    -- iterate through each genre
    for _, _genre in ipairs(joker.k_genre) do 
        for __, _joker_comp in ipairs(G.jokers.cards) do
            if _joker_comp ~= joker and
            is_genre(_joker_comp, _genre) then
                _jokers_that_share_genre = _jokers_that_share_genre + 1
                break
            end
        end
    end

    if G.GAME.modifiers.kino_genre_variety and
    _jokers_that_share_genre > 0 then
        SMODS.debuff_card(joker, true, "kino_genre_variety")
    end
end

function check_genre_snob()
    -- active joker ==
    if not G.jokers or not G.jokers.cards or (#G.jokers.cards < 1) then return end
    if not G.jokers.cards[1].config.center.kino_joker then return end

    local _active_genres = G.jokers.cards[1].config.center.k_genre

    for i = 2, #G.jokers.cards do
        local _genre_match = false
        local _joker = G.jokers.cards[i]
        for _, _genre in ipairs(_active_genres) do
            if is_genre(_joker, _genre) then
                _genre_match = true
                break
            end
        end

        if _genre_match == false then
            SMODS.debuff_card(_joker, true, "kino_genre_snob")
        end
    end
end

function check_genre_synergy()
    -- check jokers, then if 5 of them share a genre, add a joker slot
    if not G.jokers or not G.jokers.cards or not kino_config.genre_synergy then
        return false
    end

    local five_of_genres = {}

    if not G.jokers.config.synergyslots then
        G.jokers.config.synergyslots = 0
    end

    G.jokers.config.card_limit = G.jokers.config.card_limit - G.jokers.config.synergyslots

    for i, genre in ipairs(kino_genres) do
        local count = 0
        for j, joker in ipairs(G.jokers.cards) do
            if is_genre(joker, genre) then
                count = count + 1
            end
        end
        
        if count >= G.GAME.current_round.genre_synergy_treshold then
            five_of_genres[#five_of_genres + 1] = genre
        end
    end

    if #five_of_genres > G.jokers.config.synergyslots then
        -- Genre synergy!
        for i, genre in ipairs(five_of_genres) do
            for j, joker in ipairs(G.jokers.cards) do
                if joker and is_genre(joker, genre) then
                    joker:juice_up(0.8, 0.5)
                    
                    if G.GAME.modifiers.egg_genre and genre == "Romance" then
                        card_eval_status_text(joker, 'extra', nil, nil, nil,
                        { message = localize('k_genre_synergy_egg'), colour = G.ARGS.LOC_COLOURS[genre]})
                    else
                        card_eval_status_text(joker, 'extra', nil, nil, nil,
                        { message = localize('k_genre_synergy'), colour = G.ARGS.LOC_COLOURS[genre]})
                    end

                end
            end
        end
    end

    G.jokers.config.synergyslots = #five_of_genres

    G.jokers.config.card_limit = G.jokers.config.card_limit + G.jokers.config.synergyslots
end

function check_actor_synergy()

    if not kino_config.actor_synergy or not G.jokers then
        return false
    end

    for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
    end
end

function Card:kino_synergy(card)
    -- Iterate through all other jokers and check the following:
    -- If they share a genre
    -- If they share a director
    -- If they share an actor

    -- If they have the Bacon sticker

    -- If 5 share an actor, x2 all values
    -- if 3 share an actor, start shaking (and display the actor)
    if not kino_config.actor_synergy  or not self.config.center.kino_joker then
        return false
    end

    local _my_pos = nil

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            _my_pos = i
        end
    end

    local _left = _my_pos - 1
    local _right = _my_pos + 1

    local _actors = self.config.center.kino_joker.cast
    card.ability.current_synergy_actors = {
        -- actor_ID = num of matches
    }

    -- Iterate through actor list
    for _, actor in pairs(_actors) do
        -- Iterate through other jokers
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then
                if G.jokers.cards[i].config.center.kino_joker then
                    local _compared_actors = G.jokers.cards[i].config.center.kino_joker.cast

                    -- now iterate through the checked jokers and see if there's a match
                    for _j, comp_actor in pairs(_compared_actors) do
                        if actor == comp_actor then

                            if not card.ability.current_synergy_actors[actor] then
                                card.ability.current_synergy_actors[actor] = 1
                            end
                            card.ability.current_synergy_actors[actor] = card.ability.current_synergy_actors[actor] + 1
                        end
                    end
                end
            end
        end
    end

    local _count = 0
    for actor_id, frequency in pairs(card.ability.current_synergy_actors) do
        local _num = ((frequency + G.GAME.current_round.actors_table_offset) <= #Kino.actor_synergy) and frequency + G.GAME.current_round.actors_table_offset or #Kino.actor_synergy
        local _order = Kino.actor_synergy[_num]
        if frequency < G.GAME.current_round.actors_check then
            card:set_multiplication_bonus(card, actor_id, _order, true)
        end
        if frequency >= G.GAME.current_round.actors_check and _count <= 2 then
            _count = _count + 1
            local _multiplier = card:set_multiplication_bonus(card, actor_id, _order, true)
        end
    end

    if _count > 0 then
        card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize('k_actor_synergy'), colour = G.C.LEGENDARY})
        card:juice_up()
    end

    if self.ability.kino_bacon or G.GAME.modifiers.bacon_bonus then

        local _found_match = false
        local _found_match_right = false
        local _found_match_left = false
        
        for _i, actor in pairs(_actors) do
            -- test left
            if G.jokers.cards[_left] and G.jokers.cards[_left].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_left].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_left = true
                    
                        break
                    end
                end
            end

            -- test right
            if G.jokers.cards[_right] and G.jokers.cards[_right].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_right].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_right = true
                        break
                    end
                end
            end
        end

        if self.ability.kino_bacon then
            if not _found_match then
                SMODS.debuff_card(card, true, "bacon")
            else
                SMODS.debuff_card(card, false, "bacon")
            end
        end
        
        if G.GAME.modifiers.bacon_bonus then
            if not _found_match_right then
                card:set_multiplication_bonus(card, "bacon_deck_right", 1)
            else
                card:set_multiplication_bonus(card, "bacon_deck_right", G.GAME.modifiers.bacon_bonus)
            end

            if not _found_match_left then
                card:set_multiplication_bonus(card, "bacon_deck_left", 1)
            else
                card:set_multiplication_bonus(card, "bacon_deck_left", G.GAME.modifiers.bacon_bonus)
            end
        end

    end
end

function Card:set_multiplication_bonus(card, source, num, is_actor)

    -- Keys that should be exempt:
    -- goal
    -- keys that start with "base_"
    -- chance
    -- chance_cur
    -- "stacked_"
    -- keys ending in "_non"
    -- non-integers
    -- "time_"
    if not kino_config.actor_synergy  or not self.config.center.kino_joker then
        return false
    end

    if not card.ability.multipliers then
        card.ability.base = {}
        for key, val in pairs(card.ability.extra) do
            card.ability.base[key] = val
        end
        card.ability.multipliers = {}
    end

    local _multipliers = card.ability.multipliers
    local _source = source
    local _num = num

    -- Add the source, or replace it if already existing
    if _source and _num then
        if card.ability.multipliers[_source] == _num then
            return false
        elseif card.ability.multipliers[_source] ~= nil and _num == 1 then
            for index, item in ipairs(card.ability.multipliers) do
                if card.ability.multipliers[_source] == item then
                    table.remove(card.ability.multipliers, index)
                end    
            end
        end 

        _multipliers[_source] = _num        
    end

    -- Check for the award sticker
    if card.ability.kino_award then
        _multipliers["kino_award"] = Kino.award_mult
    end
    local _cardextra = card and card.ability.extra
    local _baseextra = card.ability.base

    for name, value in pairs(_cardextra) do

        -- check the values

        if check_variable_validity_for_mult(name) and type(_cardextra[name]) == "number" then
            _cardextra[name] = _baseextra[name]
            for source, mult in pairs(_multipliers) do
                _cardextra[name] = _cardextra[name] * mult
                
            end
        end
    end
    return true
end

function Card:get_multiplier_by_source(card, source)
    if not card.ability.multipliers or not card.ability.multipliers[source] then
        return false
    end

    return card.ability.multipliers[source]
end

function check_variable_validity_for_mult(name)

    if not kino_config.actor_synergy then
        return false
    end

    local _non_valid = {
        "stacks",
        "goal",
        "chance",
        "chance_cur",
        "reset",
        "threshold",
    }

    local _non_valid_element = {
        {"base_", 5},
        {"stacked_", 8},
        {"time_", 4},
        {"_non", 4},
        {"rank_", 5}
    }

    for i = 1, #_non_valid do
        if name == _non_valid[i] then
            return false
        end
    end

    for i = 1, #_non_valid_element do
        if _non_valid_element[i][1][1] == "_" then
            if string.sub(name, -_non_valid_element[i][2]) == _non_valid_element[i][1] then
                return false
            end
        else
            if string.sub(name, 1, _non_valid_element[i][2]) == _non_valid_element[i][1] then
                return false
            end
        end
    end

    return true
end
------------------------------

local base_atd = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    base_atd(self, from_debuff)

    if G.GAME.modifiers.kino_genre_variety then
        check_genre_match()            
    end
    check_genre_synergy()
    check_actor_synergy()
end

local base_rmd = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    base_rmd(self, from_debuff)
    
    if G.GAME.modifiers.kino_genre_variety then
        check_genre_match()            
    end
    check_genre_synergy()
    check_actor_synergy()
end

local base_set_rank = CardArea.set_ranks
function CardArea:set_ranks()
    -- Do synergy checks
    base_set_rank(self)

    if self == G.jokers then
        if G.GAME.modifiers.kino_genre_variety then
            check_genre_match()            
        end
        check_genre_synergy()
        check_actor_synergy()
    end
end

local base_align_cards = CardArea.align_cards
function CardArea:align_cards()
    base_align_cards(self)

    if self == G.jokers then
        if G.GAME.modifiers.kino_genre_variety then
            check_genre_match()            
        end
        check_genre_synergy()
        check_actor_synergy()
    end
end

function Card:get_release(card)
    if card.config.center.kino_joker then
        local _joker = card.config.center.kino_joker

        local _year = tonumber(string.sub(_joker.release_date, 1, 4))
        local _month = tonumber(string.sub(_joker.release_date, 6, 7))
        local _day = tonumber(string.sub(_joker.release_date, 9, 10))

        return {_year, _month, _day}
    end

    return false
end

local base_gcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    
    local ret = base_gcb(self)

    local _factor = 1

    for i, joker in ipairs(G.jokers.cards) do
        if joker.ability and joker.ability.extra and type(joker.ability.extra) == "table" 
        and joker.ability.extra.nominal_mult_factor then
            _factor = _factor * joker.ability.extra.nominal_mult_factor
        end
    end

    if _factor == 1 then
        _factor = 0
    end

    return ret + (self.base.nominal * _factor)
end
-------------------------------

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

------------ TAG functionality ------------
function Tag:set_chocolate_bonus(chocolate_bonus)
    local obj = SMODS.Tags[self.key]
    if obj and obj.set_chocolate_bonus and type(obj.set_chocolate_bonus) == 'function' then
        obj:set_chocolate_bonus(chocolate_bonus)
    end
    return true
end


to_big = to_big or function(x, y)
    return x
end

--- Award Bonus & actor synergy mechanics ---

----------------------
-- COLOURS --

G.C.KINO = {
    ACTION = HEX("0a4a59"),
    ADVENTURE = HEX("0086a5"), -- No color picked yet
    ANIMATION = HEX("0086a5"), -- No color picked yet
    BIOPIC = HEX("0086a5"), -- No color picked yet
    COMEDY = HEX("0086a5"), -- No color picked yet
    CHRISTMAS = HEX("0086a5"), -- No color picked yet
    CRIME = HEX("6a4c47"),
    DRAMA = HEX("694c77"),
    FAMILY = HEX("0086a5"), -- No color picked yet
    FANTASY = HEX("087ad9"),
    GANGSTER = HEX("0086a5"), -- No color picked yet
    HEIST = HEX("0086a5"), -- No color picked yet
    HISTORICAL = HEX("0086a5"), -- No color picked yet
    HORROR = HEX("372a2d"),
    MUSICAL = HEX("0086a5"), -- No color picked yet
    MYSTERY = HEX("0086a5"), -- No color picked yet
    ROMANCE = HEX("c8117d"),
    SCIFI = HEX("1eddd4"),
    SILENT = HEX("0086a5"), -- No color picked yet
    SPORTS = HEX("0086a5"), -- No color picked yet
    SUPERHERO = HEX("0086a5"), -- No color picked yet
    THRILLER = HEX("0086a5"), -- No color picked yet
    WAR = HEX("0086a5"), -- No color picked yet
    WESTERN = HEX("0086a5"),
    PINK = HEX("f7b7f2")
}

local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = G.C.KINO.ACTION
    G.ARGS.LOC_COLOURS["Adventure"] = G.C.KINO.ADVENTURE
    G.ARGS.LOC_COLOURS["Animation"] = G.C.KINO.ANIMATION
    G.ARGS.LOC_COLOURS["Biopic"] = G.C.KINO.BIOPIC
    G.ARGS.LOC_COLOURS["Comedy"] = G.C.KINO.COMEDY
    G.ARGS.LOC_COLOURS["Christmas"] = G.C.KINO.CHRISTMAS
    G.ARGS.LOC_COLOURS["Crime"] = G.C.KINO.CRIME
    G.ARGS.LOC_COLOURS["Drama"] = G.C.KINO.DRAMA
    G.ARGS.LOC_COLOURS["Family"] = G.C.KINO.FAMILY
    G.ARGS.LOC_COLOURS["Fantasy"] = G.C.KINO.FANTASY
    G.ARGS.LOC_COLOURS["Gangster"] = G.C.KINO.GANGSTER
    G.ARGS.LOC_COLOURS["Heist"] = G.C.KINO.HEIST
    G.ARGS.LOC_COLOURS["Historical"] = G.C.KINO.HISTORICAL
    G.ARGS.LOC_COLOURS["Horror"] = G.C.KINO.HORROR
    G.ARGS.LOC_COLOURS["Musical"] = G.C.KINO.MUSICAL
    G.ARGS.LOC_COLOURS["Mystery"] = G.C.KINO.MYSTERY
    G.ARGS.LOC_COLOURS["Romance"] = G.C.KINO.ROMANCE
    G.ARGS.LOC_COLOURS["Sci-fi"] = G.C.KINO.SCIFI
    G.ARGS.LOC_COLOURS["Silent"] = G.C.KINO.SILENT
    G.ARGS.LOC_COLOURS["Sports"] = G.C.KINO.SPORTS
    G.ARGS.LOC_COLOURS["Superhero"] = G.C.KINO.SUPERHERO
    G.ARGS.LOC_COLOURS["Thriller"] = G.C.KINO.THRILLER
    G.ARGS.LOC_COLOURS["War"] = G.C.KINO.WAR
    G.ARGS.LOC_COLOURS["Western"] = G.C.KINO.WESTERN

    return genrecolors(_c, _default)
end

--- Global Variables ---
Kino.jump_scare_mult = 3
Kino.goldleaf_chance = 3
Kino.choco_chance = 2
Kino.xl_chance = 1

Kino.awardschance = 1

Kino.actor_synergy = {1, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.25, 2.5, 3}
Kino.award_mult = 2
