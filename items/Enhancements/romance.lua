SMODS.Enhancement {
    key = "romance",
    atlas = "kino_enhancements",
    pos = { x = 3, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- If a hand contains 2 scoring romance cards, 2x chips, 2x mult.
    end
}