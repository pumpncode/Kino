SMODS.Joker {
    key = "turner_and_hooch",
    order = 29,
    config = {
        extra = {
            mult = 30,
            one_face = false,
            one_nface = false
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.one_face,
                card.ability.extra.one_nface
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a pair of face cards, add the highest rank of numbered card in your hand to this joker's chips.
        

    end
}