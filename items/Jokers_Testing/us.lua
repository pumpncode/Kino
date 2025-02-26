SMODS.Joker {
    key = "us",
    order = 43,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a Horror card wakes up, gain x0.1
        if context.monster_awaken and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT })
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

    end
}