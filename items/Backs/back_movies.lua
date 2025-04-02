SMODS.Back {
    name = "Bacon Deck",
    key = "bacon",
    atlas = "kino_backs",
    pos = {x = 0, y = 1},
    config = {
    },
    apply = function()
        G.GAME.modifiers.bacon_bonus = 1.5
    end
}

SMODS.Back {
    name = "Egg Deck",
    key = "northernlion",
    atlas = "kino_backs",
    pos = {x = 1, y = 1},
    config = {
        egg_genre = "Romance"
    },
    apply = function()
        G.GAME.modifiers.egg_genre = "Romance"
    end
}

-- SMODS.Back {
--     name = "Cine2Nerdle Deck",
--     key = "c2n",
--     atlas = "kino_backs",
--     pos = {x = 2, y = 1},
--     config = {
--         egg_genre = "Romance"
--     },
--     apply = function()
--         G.GAME.modifiers.egg_genre = "Romance"
--     end
-- }

SMODS.Back {
    name = "Producer Deck",
    key = "producer",
    atlas = "kino_backs",
    pos = {x = 3, y = 1},
    config = {
        dollars = 6,
        extra_hand_bonus = 0,
        extra_discard_bonus = 0,
        no_interest = true
    },
    apply = function()
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
        G.GAME.modifiers.no_blind_reward.Big = true
        G.GAME.modifiers.no_blind_reward.Boss = true
    end,
    calculate = function(self, card, context)
        if context.end_of_round 
        and not context.individual and not context.repetition and not context.blueprint then
            local _percentage = 0

            for _, _joker in ipairs(G.jokers.cards) do
                
                if _joker.config.center.kino_joker then
                    local _movie_info = _joker.config.center.kino_joker 

                    local budget = _movie_info.budget
                    local boxoffice = _movie_info.box_office

                    if budget == 0 then budget = 1 end
                    if boxoffice == 0 then boxoffice = 1.1 end

                    _percentage = _percentage + (_movie_info.box_office / budget)
                    if _percentage > 10 then
                        _percentage = 10
                    end

                    SMODS.calculate_effect({
                        message = "$" .. (_percentage * 100),
                        colour = G.C.MONEY
                    },
                    _joker)
                end
            end

            local reward = 10 * _percentage

            ease_dollars(reward - 10)
        end
    end
}