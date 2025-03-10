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
    local _ret = SMODS.calculate_context({pre_abduct = true}, {stop_abduction = false})

    if _ret and _ret.stop_abduction then
        return
    end

    if abducted_card.ability.set ~= 'Joker' then
        abducted_card.abducted = true
        G.GAME.current_round.abduction_waitinglist[#G.GAME.current_round.abduction_waitinglist + 1] = {
            abductor = card,
            abducted_card = abducted_card,
            abducted_from = abducted_card.area
        }
    else

    end
    --     card:juice_up()

    --     -- grab the abducted_card and move it to the abducted zone
    --     G.GAME.current_round.cards_abducted = G.GAME.current_round.cards_abducted + 1

    --     abducted_card.area.config.card_limit = abducted_card.area.config.card_limit - ((abducted_card.edition and abducted_card.edition.negative) and 1 or 0)
        
    --     if not card.ability.extra.cards_abducted then
    --         card.ability.extra.cards_abducted = {
    --             -- Cards should be formatted as such
    --             -- {
    --             --     -- card = card,
    --             --     -- abudcted_from = cardarea,
    --             --     -- abducted_when = when,
    --             -- }
    --         }
    --     end

    --     card.ability.extra.cards_abducted[#card.ability.extra.cards_abducted + 1] = {
    --         card = abducted_card,
    --         abducted_from = abducted_card.area
    --     }
       
    --     abducted_card.area:remove_card(abducted_card)

    --     -- Make sure to remove it from deck
    --     if G.playing_cards then
    --         for k, v in ipairs(G.playing_cards) do
    --             if v == abducted_card then
    --                 table.remove(G.playing_cards, k)
    --                 break
    --             end
    --         end
    --         for k, v in ipairs(G.playing_cards) do
    --             v.playing_card = k
    --         end
    --     end
    --     Kino.abduction:emplace(abducted_card)
    SMODS.calculate_context({abduct = true, joker = card, abducted_card = abducted_card})
end

Card.abduct = function(abductor)


end

Kino.unabduct_cards = function(card)
    if not card or not card.area then return end
    if not card.ability.extra.cards_abducted or #card.ability.extra.cards_abducted == 0 then return end

    local _table = card.ability.extra.cards_abducted

    for i, abductee in ipairs(_table) do
        abductee.card.area:remove_card(abductee.card)
        abductee.card.abducted = false

        local _cardarea = G.deck
        if abductee.abducted_from ~= G.play and
        abductee.abducted_from ~= G.hand then
            _cardarea = abductee.abducted_from 
        end

        _cardarea:emplace(abductee.card)
        table.remove(_table, i)
        if _cardarea ~= G.jokers and 
        _cardarea ~= G.consumeables then
            table.insert(G.playing_cards, abductee.card)
        end
    end

    return _table

end

Kino.abduction_end = function()

    SMODS.calculate_context({abduction_ending = true})
    
end

G.FUNCS.draw_from_area_to_abduction = function(e)
    
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.1,
        func = function()
            local _cards_to_be_abducted = G.GAME.current_round.abduction_waitinglist

            for _, command in ipairs(_cards_to_be_abducted) do
                local _abductor = command.abductor
                local _abductee = command.abducted_card
                local _abducted_from = command.abducted_from

                _abductor:juice_up()
                
                G.GAME.current_round.cards_abducted = G.GAME.current_round.cards_abducted + 1

                _abductee.area.config.card_limit = _abductee.area.config.card_limit - ((_abductee.edition and _abductee.edition.negative) and 1 or 0)
                
                if not _abductor.ability.extra.cards_abducted then
                    _abductor.ability.extra.cards_abducted = {
                        -- Cards should be formatted as such
                        -- {
                        --     -- card = card,
                        --     -- abudcted_from = cardarea,
                        --     -- abducted_when = when,
                        -- }
                    }
                end

                _abductor.ability.extra.cards_abducted[#_abductor.ability.extra.cards_abducted + 1] = {
                    card = _abductee,
                    abducted_from = _abducted_from
                }

                _abductee.area:remove_card(_abductee)
                
                if G.playing_cards then
                    for k, v in ipairs(G.playing_cards) do
                        if v == _abductee then
                            table.remove(G.playing_cards, k)
                            break
                        end
                    end
                    for k, v in ipairs(G.playing_cards) do
                        v.playing_card = k
                    end
                end

                Kino.abduction:emplace(_abductee)

            end

            
            G.GAME.current_round.abduction_waitinglist = {}
            return true end
    }))

end