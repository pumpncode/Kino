SMODS.Booster {
    key = "action_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "action_booster",
    pos = {x = 0, y = 1},
    config = {
        extra = 3,
        choose = 1,
        genre = "Action"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Action", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "comedy_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "comedy_booster",
    pos = {x = 0, y = 3},
    config = {
        extra = 3,
        choose = 1,
        genre = "Comedy"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Comedy", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "horror_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "horror_booster",
    pos = {x = 0, y = 0},
    config = {
        extra = 3,
        choose = 1,
        genre = "Horror"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0

        end
        return self.weight
    end,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Horror", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "romance_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "romance_booster",
    pos = {x = 0, y = 4},
    config = {
        extra = 3,
        choose = 1,
        genre = "Romance"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Romance", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}

SMODS.Booster {
    key = "sci_fi_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "sci_fi_booster",
    pos = {x = 0, y = 2},
    config = {
        extra = 3,
        choose = 1,
        genre = "Sci-fi"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        return create_card("Sci-fi", G.pack_cards, nil, nil, true, true, nil, nil)
    end
}