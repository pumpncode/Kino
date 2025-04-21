SMODS.Joker {
    key = "arrival",
    order = 221,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.dummy_codex,
            codex_type = 'rank',
            codex_length = 5,
            solved = false,
            decrease = 2
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 0},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 329865,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            },
            main_end = Kino.codex_ui(card.ability.extra.codex_solve)
        }
    end,
    calculate = function(self, card, context)
        -- if the codex is solved, go back 2 antes and destroy this joker

        if context.joker_main then
            local result = false
            if not context.blueprint and not context.repetition then
                card.ability.extra.codex_solve, result = Kino.check_codex(card, card.ability.extra.codex, context.full_hand, card.ability.extra.codex_solve)
                if result == true then
                    card.ability.extra.solved = true
                end
            end

            if card.ability.extra.solved then
                ease_ante(-card.ability.extra.decrease)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.decrease
                if card.ability.eternal then
                    SMODS.debuff_card(card, true, "kino_arrival")
                else
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        card:juice_up(0.8, 0.8)
                        card:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
            end
        end
        
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'arrival')
   
    end,
}