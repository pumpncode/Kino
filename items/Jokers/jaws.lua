SMODS.Joker {
    key = "jaws",
    order = 11,
    config = {
        extra = {
            chips = 30
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 1 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Unscored cards give +30 chips
        -- and get debuffed
        if context.individual and context.cardarea == "unscored" then
            local _card = context.other_card
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                _card:juice_up()
                card_eval_status_text(_card, 'extra', nil, nil, nil,
                { message = localize('k_jaws'), colour = G.C.BLACK })
                SMODS.debuff_card(_card, true, card.config.center.key)
            return true end }))

            return {
                chips = card.ability.extra.chips,
                card = context.other_card
            }
        end
    end
}