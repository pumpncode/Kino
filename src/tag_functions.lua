-- Balatro Goes Kino
-- tag_functions.lua
-- Hooks functions to add the correct calculations for tags

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