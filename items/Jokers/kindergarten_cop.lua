SMODS.Joker {
    key = "kindergarten_cop",
    order = 71,
    config = {
        extra = {
            x_mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- X2 if your hand contains no cards with a rank above 5

        if context.joker_main then
            local _will_trig = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() > 5 then
                    if context.scoring_hand[i]:get_id() ~= 14 then
                        _will_trig = false
                        break
                    end
                end
            end

            if _will_trig then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end

    end
}