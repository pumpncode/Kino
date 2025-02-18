SMODS.Booster {
    key = "romance_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "romance_booster",
    pos = {x = 0, y = 4},
    config = {
        extra = 3,
        choose = 1
    },
    cost = 4,
    order = 1,
    weight = 1,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Romance", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}