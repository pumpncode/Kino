if CardSleeves then
    CardSleeves.Sleeve {
        key = "bacon",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 1 },
        config = {
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.bacon_bonus = 1.5
        end
    }

    CardSleeves.Sleeve {
        key = "northernlion",
        atlas = "kino_sleeves",
        pos = { x = 1, y = 1 },
        config = {
            egg_genre = "Romance"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.egg_genre = "Romance"
        end
    }

    CardSleeves.Sleeve {
        key = "c2n",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 1 },
        config = {
        },
        apply = function()
            G.GAME.modifiers.kino_back_c2n = true
        end
    }

    CardSleeves.Sleeve {
        key = "producer",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 1 },
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
                        _percentage = _percentage + (_movie_info.box_office / _movie_info.budget)
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
end