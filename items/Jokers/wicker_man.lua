SMODS.Joker {
    key = "wicker_man",
    order = 110,
    config = {
        extra = {
            mult = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- when your first discard is only 1 card,
        -- destroy it and gain mult equal to its chips       
        -- resets after you defeat a boss blind

        if context.discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1
        and not context.hook and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + context.other_card.base.nominal + context.other_card.ability.bonus
            return {
                message = localize('k_upgrade_ex'),
                remove = true,
                card = card
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.mult = 0
        end
        
    end
}