-- BASE CODE WRITTEN AND PROVIDED BY ARSON

--Function to alter Scoring Joker effects
local base_calculate_joker = Card.calculate_joker
function Card.calculate_joker(self,context)
    local ret = base_calculate_joker(self, context)

    if self.ability.output_powerchange then
        -- calculate the multiplier. Numbers are always percentages
        local multiplier = 1
        for _source, _num in pairs(self.ability.output_powerchange) do
            multiplier = multiplier * _num
        end
        
        if self.ability.name == 'Blueprint' or self.ability.name == 'Brainstorm' and not context.end_of_round then
                return ret
        end

        if not ret then return ret end

        -- Mult
        if ret.x_mult then ret.x_mult = ret.x_mult * multiplier end
        if ret.h_mult then ret.h_mult = ret.h_mult * multiplier end
        if ret.mult then ret.mult = ret.mult * multiplier end

        -- Message overrides
        if ret.Xmult_mod then 
            ret.x_mult = ret.Xmult_mod * multiplier
            ret.message = nil 
        end
        if ret.mult_mod then 
            ret.mult = ret.mult_mod * multiplier 
            ret.message = nil
        end


        -- Chips
        if ret.chip_mod then 
            ret.chips = ret.chip_mod * multiplier 
            ret.message = nil
        end

        if ret.chips then ret.chips = ret.chips * multiplier end
        return ret
    else 
        return ret
    end
end

function Kino.setpowerchange(card, source, powerchange)
    if not card.ability.output_powerchange then
        card.ability.output_powerchange = {}
    end

    local _source = source
    local _num = powerchange

    -- Add the source, or replace it if already existing
    if _source and _num then
        if card.ability.output_powerchange[_source] == _num then
            return false
        elseif card.ability.output_powerchange[_source] ~= nil and _num == 1 then
            for index, item in ipairs(card.ability.output_powerchange) do
                if card.ability.output_powerchange[_source] == item then
                    table.remove(card.ability.output_powerchange, index)
                end    
            end
        end 

        card.ability.output_powerchange[_source] = _num        
    end

    return true
end