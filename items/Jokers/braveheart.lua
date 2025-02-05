SMODS.Joker {
    key = "braveheart",
    order = 22,
    config = {
        extra = {
            suit = "Hearts",
            b_chips = 10,
            chips = 10
            
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.suit,
                card.ability.extra.b_chips,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Hearts give +10 chips for each other scoring Hearts.

        if context.before and not context.blueprint then
            print(card.ability.extra.b_chips)
            local num_suit = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.card.suit == card.ability.extra.suit and not v.debuff then
                    num_suit = num_suit + 1
                end
            end
            print("Base Chips = " .. card.ability.extra.b_chips)
            card.ability.extra.chips = card.ability.extra.b_chips * num_suit
        end

        if context.individual and context.cardarea == G.play then
            print(card.ability.extra.b_chips)
            print(card.ability.extra.chips)
            print(card.ability.extra.test)
            if context.other_card:is_suit(card.ability.extra.suit) then
                return {
                    chips = card.ability.extra.chips,
                    card = context.other_card
                }
            end
        end
    end
}