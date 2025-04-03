-- Code by Dilly_the_Dillster

SMODS.Joker {
    key = "lucky_number_slevin",
    order = 141,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            increase_amount_non = 1,
            main_eval = false
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 186,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.increase_amount_non,
                G.GAME.last_seven_count or 0
            }
        }
    end,
    calculate = function(self, card, context)

        if (context.cardarea and not context.cardarea == G.jokers) or not G.GAME or not G.GAME.probabilities or not G.hand then return end

        if context.main_eval and not card.ability.extra.main_eval then
            card.ability.extra.main_eval = true
        elseif context.main_eval and card.ability.extra.main_eval then
            return
        elseif not context.main_eval then
            card.ability.extra.main_eval = false
        end

        local current_seven_count = 0  
        for _, hand_card in ipairs(G.hand.cards) do
            if hand_card:get_id() == 7 then
                current_seven_count = current_seven_count + 1
            end
        end

        local last_seven_count = G.GAME.last_seven_count or 0

        
        local seven_difference = current_seven_count - last_seven_count
        if seven_difference ~= 0 then
            -- print(string.format("[DEBUG] 7s in hand changed! Adjusting probabilities by %+d.", seven_difference))


            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = math.max(0, (v or 0) + (seven_difference * card.ability.extra.increase_amount_non))
            end


            G.GAME.last_seven_count = current_seven_count  

            return {
                message = string.format("Lucky Sevens! Probabilities adjusted by %+d!", seven_difference),
                colour = G.C.GREEN
            }
        end
    end
}