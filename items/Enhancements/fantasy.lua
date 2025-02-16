SMODS.Enhancement {
    key = "fantasy",
    atlas = "kino_enhancements",
    pos = { x = 4, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- checks the two left most cards, and casts a random effect based on their suits.
    end
}