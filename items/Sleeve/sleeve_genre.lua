if CardSleeves then
    CardSleeves.Sleeve {
        key = "spooky",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 0 },
        config = {
            genre_bonus = "Horror"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus = "Horror"
        end
    }

    CardSleeves.Sleeve {
        key = "flirty",
        atlas = "kino_sleeves",
        pos = { x = 1, y = 0 },
        config = {
            genre_bonus = "Romance"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus = "Romance"
        end
    }

    CardSleeves.Sleeve {
        key = "dangerous",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 0 },
        config = {
            genre_bonus = "Action"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus = "Action"
        end
    }

    CardSleeves.Sleeve {
        key = "tech",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 0 },
        config = {
            genre_bonus = "Sci-fi"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus = "Sci-fi"
        end
    }

    CardSleeves.Sleeve {
        key = "enchanted",
        atlas = "kino_sleeves",
        pos = { x = 4, y = 0 },
        config = {
            genre_bonus = "Fantasy"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus = "Fantasy"
        end
    }
end