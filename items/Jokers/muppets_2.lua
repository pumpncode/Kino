SMODS.Joker {
    key = "muppets_2",
    order = 25,
    config = {
        extra = {
            min_mult = -5,
            max_mult = 35
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.min_mult,
                card.ability.extra.max_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        context.other_card:is_suit("Diamonds") then
            local mult = pseudorandom("muppets_2", card.ability.extra.min_mult, card.ability.extra.max_mult)
            return {
                mult = mult,
                card = context.other_card
            }
        end
    end
}