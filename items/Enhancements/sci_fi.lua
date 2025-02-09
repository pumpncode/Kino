SMODS.Enhancement {
    key = "sci_fi",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 0},
    config = {
        extra = {
            a_mult = 1,
            a_chips = 5,
            mult = 0,
            bonus = 0
            --
            --
            --
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.extra.a_mult or self.config.extra.a_mult,
                card and card.ability.extra.a_chips or self.config.extra.a_chips,
                card and card.ability.extra.mult or self.config.extra.mult,
                card and card.ability.extra.bonus or self.config.extra.bonus
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play then
            -- Sets values, as upgrade should happen after scoring
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
            card.ability.extra.bonus = card.ability.extra.bonus + card.ability.extra.a_chips
        end
    end
}