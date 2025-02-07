SMODS.Joker {
    key = "jaws",
    order = 11,
    config = {
        extra = {
            rank_discard = 12,
            rank_retrieved = {11, 13}
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 1 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When cards are discarded, check how many were queens.
        -- if there were queens, check the deck for remaining jacks or kings. 
        -- then, EITHER, for each queen, put a random j or k on top of the deck.
        -- -- or draw them, then lower the cards to be added by the number of discarded queens.
        --     if context.discard and not context.blueprint and
        --         not context.other_card.debuff and context.other_card.rank == 12 then
        --             if G.deck and G.deck.cards[1].base.id == 11 or G.deck.cards[1].base.id ==  
        --     end
        -- TEST
        if context.individual and context.cardarea == G.play then
            print("Testing jaws func")
            local is_splash = context.other_card.splash_bonus
            if is_splash then
                print("TRUE - SPLASH FOUND")
            end
            return {
                message = localize({type='variable', key='a_mult', vars = {is_splash}})
            }
        end
    end
}