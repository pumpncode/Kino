SMODS.Back {
    name = "Spooky Deck",
    key = "spooky",
    atlas = "kino_backs",
    pos = {x = 0, y = 0},
    config = {
        genre_bonus = "Horror"
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Horror"
    end
}

SMODS.Back {
    name = "Flirty Deck",
    key = "flirty",
    atlas = "kino_backs",
    pos = {x = 1, y = 0},
    config = {
        genre_bonus = "Romance"
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Romance"
    end
}

SMODS.Back {
    name = "Dangerous Deck",
    key = "dangerous",
    atlas = "kino_backs",
    pos = {x = 2, y = 0},
    config = {
        genre_bonus = "Action"
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Action"
    end
}

SMODS.Back {
    name = "Tech Deck",
    key = "tech",
    atlas = "kino_backs",
    pos = {x = 3, y = 0},
    config = {
        genre_bonus = "Sci-fi"
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Sci-fi"
    end
}

SMODS.Back {
    name = "Enchanted Deck",
    key = "enchanted",
    atlas = "kino_backs",
    pos = {x = 4, y = 0},
    config = {
        genre_bonus = "Fantasy"
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Fantasy"
    end
}



