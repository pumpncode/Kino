SMODS.Booster {
    key = "snack_booster_normal",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 0, y = 8},
    config = {
        extra = 3,
        choose = 1
    },
    cost = 3,
    order = 1,
    weight = 2,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "snack_booster_jumbo",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 1, y = 8},
    config = {
        extra = 5,
        choose = 1
    },
    cost = 5,
    order = 1,
    weight = 1,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "snack_booster_mega",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 2, y = 8},
    config = {
        extra = 5,
        choose = 2
    },
    cost = 7,
    order = 1,
    weight = 0.5,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}