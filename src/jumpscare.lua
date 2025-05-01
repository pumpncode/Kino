function Kino.jumpscare_check(source, source_seed, target, cur_chance, tot_chance)
    if pseudorandom(source_seed) < (G.GAME.probabilities.normal * cur_chance) / tot_chance then
        
        SMODS.calculate_context({jump_scare = true, source = source, target = target})
        
        source.ability.extra.destroy_cards[#source.ability.extra.destroy_cards + 1] = target
        return {
            x_mult = Kino.jump_scare_mult, 
            message = localize('k_jump_scare'),
            colour = HEX("372a2d"),
            card = target
        }
    end
end

function Kino.jumpscare_destroy(source, target)

    if source.ability.extra.destroy_cards > 0 then
        for i, card in ipairs(source.ability.extra.destroy_cards) do
            if target == card then
                return true
            end
        end
    end
end