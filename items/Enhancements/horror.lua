SMODS.Enhancement {
    key = "horror",
    atlas = "kino_enhancements",
    pos = { x = 2, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When in hand, 4/10 chance to give x2. 1/10 chance to break.
    end
}