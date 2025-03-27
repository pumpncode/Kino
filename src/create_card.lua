
local _occ = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local _card = _occ(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    -- Confection Changes --
    if G.GAME.used_vouchers.v_kino_special_treats and _type == "confection" then
        -- chance for golden 1/10
        -- chance for chocolate 1/10
        -- chance for XL 1/10 
        if pseudorandom("snack_boost_golden") < Kino.goldleaf_chance/10 then
            SMODS.Stickers['kino_goldleaf']:apply(_card, true)
        end
        if pseudorandom("snack_boost_choco") < Kino.choco_chance/10 then
            SMODS.Stickers['kino_choco']:apply(_card, true)
        end
        if pseudorandom("snack_boost_XL") < Kino.xl_chance/10 then
            SMODS.Stickers['kino_extra_large']:apply(_card, true)
        end
    end

    if next(find_joker("j_kino_charlie_and_the_chocolate_factory")) and _type == "confection" then
        if not _card.ability.kino_choco then
            SMODS.Stickers['kino_choco']:apply(_card, true)
        end
    end

    -- Joker Changes --
    if G.GAME.used_vouchers.v_kino_awardsbait and _type == 'Joker' then
        if pseudorandom("snack_boost_golden") < Kino.awardschance/100 then
            SMODS.Stickers['kino_award']:apply(_card, true)
        end
    end

    if G.GAME.modifiers.kino_bacon and _type == 'Joker' 
    and _card.kino_joker then
        SMODS.Stickers['kino_bacon']:apply(_card, true)
    end

    if G.GAME.modifiers and G.GAME.modifiers.genre_bonus then
        if _type == 'Joker' or _type == G.GAME.modifiers.genre_bonus then
            if is_genre(_card, G.GAME.modifiers.genre_bonus) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:set_multiplication_bonus(_card, 'card_back', 1.5)
                        return true
                    end
                }))
            end   
        end
    end

    return _card
end

function forced_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

end