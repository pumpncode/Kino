-- Abducted objects can be any card object
-- Abductions happen on trigger, and are ended when a Boss blind is defeated
-- After an abduction ends, the source of the abduction is checked
-- and an effect happens. If no specifics are given,
-- the abducted card is returned to the cardarea it came from
-- regardless of whether there is space

-- If the source of an abduction is sold or destroyed, the abducted items are sold or destroyed with them
local _o_gsr = Game.start_run
function Game:start_run(args)
    self.kino_abductionarea = CardArea(
        0,
        0,
        self.CARD_W * 4.95,
        self.CARD_H * 0.95,
        {
            card_limit = 999,
            type = "abduction",
            highlight_limit = 0
        }
    )
    self.kino_abductionarea.states.visible = false
    Kino.abduction = G.kino_abductionarea
    Kino.abduction_table = {}
    _o_gsr(self, args)
end

-- Abduction functions
Kino.abduct_card = function(card, abducted_card)
    if not card or not card.area then return end
    if not abducted_card or not abducted_card.area then return end
    card:juice_up()

    -- grab the abducted_card and move it to the abducted zone
    G.GAME.current_round.cards_abducted = G.GAME.current_round.cards_abducted + 1

    abducted_card.area.config.card_limit = abducted_card.area.config.card_limit - ((abducted_card.edition and abducted_card.edition.negative) and 1 or 0)
    
    if not card.ability.extra.cards_abducted then
        card.ability.extra.cards_abducted = {}
    end

    card.ability.extra.cards_abducted[#card.ability.extra.cards_abducted + 1] = card
    
    abducted_card.area:remove_card(abducted_card)

    -- Make sure to remove it from deck
    if G.playing_cards then
        for k, v in ipairs(G.playing_cards) do
            if v == abducted_card then
                table.remove(G.playing_cards, k)
                break
            end
        end
        for k, v in ipairs(G.playing_cards) do
            v.playing_card = k
        end
    end
    --

    Kino.abduction:emplace(abducted_card)
end


--- Abduction UI ---
AbductionDisplayBox = UIBox:extend()

function AbductionDisplayBox:init(parent, func, args)
    args = args or {
        n = G.UIT.ROOT,
        config = {
            minh = 0.6,
            minw = 2,
            maxw = 2,
            r = 0.001,
            padding = 0.1,
            align = 'cm',
            colour = adjust_alpha(darken(G.C.BLACK, 0.2), 0.8),
            shadow = true,
            func = func,
            ref_table = parent
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { ref_table = parent, align = "cm", func = "joker_display_style_override" },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { id = "sprite", ref_table = parent, align = "cm" },
                    },
                    {
                        n = G.UIT.R,
                        config = { id = "num", ref_table = parent, align = "cm" },
                    }
                }
            },
        }
    }

    args.config = args.config or {}
    args.config.align = args.config.align or "bm"
    args.config.parent = parent
    args.config.offset = { x = 0, y = -0.1 }
end