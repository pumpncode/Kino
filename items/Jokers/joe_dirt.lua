SMODS.Joker {
    key = "joe_dirt",
    order = 28,
    config = {
        extra = {
            chips = 0,
            chips_mod = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and context.other_card:is_suit("Spades") then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod

            return {
                message = localize('k_upgrade_ex'),
                card = self,
                colour = G.C.CHIPS
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                message = localize({ type = 'variable', key = 'a_chips', vars = { card.abilit.extra.chips}})
            }
        end
    end
}