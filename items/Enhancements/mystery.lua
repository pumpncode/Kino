SMODS.Enhancement {
    key = "mystery",
    atlas = "kino_enhancements",
    pos = { x = 5, y = 0},
    config = {
        x_mult = 2.5,
        a_xmult = 0.5,
        total_clues = 0,
        edition = false,
        suit = false,
        rank = false
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        if (context.after and context.cardarea == G.hand and not context.repetition) then
            
        end
    end
}


local _bsf = Blind.stay_flipped
function Blind:stay_flipped(area, card, from_area)
    if area == G.hand then
        if card and card.center and SMODS.has_enhancement(card, 'm_kino_mystery') then
            return true
        end
    end

    return _bsf(area, card, from_area)
end