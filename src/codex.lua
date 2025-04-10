-- codex code

-- Types of Codex
-- Suit Codex (only suits matter)
-- Rank Codex (only ranks matter)
-- Complex Codex (both ranks and suits matter)
-- Varied Codex (each entry can be rank or suit)
-- Supervaried Codex (each entry can be rank, suit or complex)

---check if the given sequence of cards matches the codex
---@param card Card
---@param codex table
---@param checking_cards table
---@return table?
function Kino.check_codex(card, codex, checking_cards) 
    local _solved_codex = {}
    local _result = true

    for i = 1, #codex do
        local _card = checking_cards[i]
        local _suitmatch = false
        local _rankmatch = false

        _solved_codex[i] = {suit = nil, rank = nil}

        if codex[i].suit and _card:is_suit(codex[i].suit) then
            _solved_codex[i].suit = codex[i].suit
            _suitmatch = true
        elseif not codex[i].suit then
            _suitmatch = true
        else
            _solved_codex[i].suit = nil
        end

        if _card:get_id() == codex[i].rank then
            _solved_codex[i].rank = codex[i].suit
            _rankmatch = true
        elseif not codex[i].rank then
            _rankmatch = true
        else
            _solved_codex[i].rank = nil
        end

        if not _suitmatch or not _rankmatch then
            _result = false
        end
    end

    return _solved_codex, _result
end

---creates a codex sequence of rank and suits
---@param loc_limits table
---@param type string
---@param length number
---@param codexseed string
---@return table?
function Kino.create_codex(loc_limits, type, length, codexseed)
    if not G.playing_cards then return false end

    type = string.lower(type)
    if not length then
        length = 5
    end

    local _available_cards = copy_table(G.playing_cards)
    local _selected_cards = {}

    for i = 1, length do 
        local _card = pseudorandom_element(_available_cards, pseudoseed("codex_" .. codexseed))

        _selected_cards[#_selected_cards + 1] = _card
    end

    local _ret_codex = {}
    for _, _pcard in ipairs(_selected_cards) do
        _ret_codex[#_ret_codex + 1] = {suit = nil, rank = nil}
        if type == "suit" or type == "complex" then
            _ret_codex[#_ret_codex].suit = _pcard.base.suit
        end
        if type == "rank" or type == "complex" then
            _ret_codex[#_ret_codex].rank = _pcard.base.id
        end
    end

    return _ret_codex
end