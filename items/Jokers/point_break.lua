SMODS.Joker {
    key = "point_break",
    order = 80,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a pair, destroy a random card in your hand and gain mult equal to its rank.

        if context.before and context.cardarea == G.jokers 
        and context.scoring_name == "Pair" then
            local _card = pseudorandom_element(G.hand.cards)

            local _rank = 0
            if _card.config.center ~= G.P_CENTERS.m_stone then
                _rank = _card.base.id
            end 
            
            _card.marked_to_destroy_by_point_break = true

            for i, v in ipairs(context.scoring_hand) do
                v.ability.perma_mult = v.ability.perma_mult or 0
                v.ability.perma_mult = v.ability.perma_mult + _rank
                card_eval_status_text(v, 'extra', nil, nil, nil,
                { message = localize("k_upgrade_ex"), colour = G.C.MULT })
            end
        end

        if context.destroy_card and context.cardarea == G.hand then
            
            if context.destroy_card.marked_to_destroy_by_point_break then
                return {remove = true}
            end
        end
    end
}