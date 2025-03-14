-- Balatro Goes Kino
-- confection_function.lua
-- Functionality used by the confection consumeable

------------ TAG functionality ------------
function Tag:set_chocolate_bonus(chocolate_bonus)
    local obj = SMODS.Tags[self.key]
    if obj and obj.set_chocolate_bonus and type(obj.set_chocolate_bonus) == 'function' then
        obj:set_chocolate_bonus(chocolate_bonus)
    end
    return true
end

----------- CONFECTION CHANGES -------------
local _occ = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local _card = _occ(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.GAME.used_vouchers.v_kino_special_treats and _type == "confection" then
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

    return _card
end