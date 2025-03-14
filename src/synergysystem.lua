
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
            if joker and joker.config.center.kino_joker then
                for k, comp_genre in ipairs(joker.config.center.k_genre) do
                    if genre == comp_genre then
                        count = count + 1
                        break
                    end
                end
            end
        end
        
        if count >= G.GAME.genre_synergy_treshold then
            five_of_genres[#five_of_genres + 1] = genre
        end
    end

    if #five_of_genres > G.jokers.config.synergyslots then
        -- Genre synergy!
        for i, genre in ipairs(five_of_genres) do
            for j, joker in ipairs(G.jokers.cards) do
                if joker and joker.config.center.kino_joker then
                    for k, comp_genre in ipairs(joker.config.center.k_genre) do
                        if genre == comp_genre then
                            joker:juice_up(0.8, 0.5)
                            card_eval_status_text(joker, 'extra', nil, nil, nil,
                            { message = localize('k_genre_synergy'), colour = G.C.LEGENDARY})
                        end
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
        if frequency <= 2 then
            card:set_multiplication_bonus(card, actor_id, Kino.actor_synergy[frequency], true)
        end
        if frequency >= 3 and _count <= 2 then
            _count = _count + 1
            local _multiplier = card:set_multiplication_bonus(card, actor_id, Kino.actor_synergy[frequency], true)
            if _multiplier then
                card:juice_up(0.8, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_actor_synergy'), colour = G.C.LEGENDARY})
            end
        end
    end

    if self.ability.kino_bacon then

        local _found_match = false

        
        for _i, actor in pairs(_actors) do
            -- test left
            if G.jokers.cards[_left] and G.jokers.cards[_left].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_left].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        break
                    end
                end
            end

            -- test right
            if G.jokers.cards[_right] and G.jokers.cards[_right].config.center.kino_joker then
                _compared_actors = G.jokers.cards[_right].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        break
                    end
                end
            end
        end

        if not _found_match then
            SMODS.debuff_card(card, true, "bacon")
        else
            SMODS.debuff_card(card, false, "bacon")
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

local base_atd = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    base_atd(self, from_debuff)

    check_genre_synergy()
    check_actor_synergy()
end

local base_rmd = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    base_rmd(self, from_debuff)
    
    check_genre_synergy()
    check_actor_synergy()
end

local base_set_rank = CardArea.set_ranks
function CardArea:set_ranks()
    -- Do synergy checks
    base_set_rank(self)

    if self == G.jokers then
        check_genre_synergy()
        check_actor_synergy()
    end
end