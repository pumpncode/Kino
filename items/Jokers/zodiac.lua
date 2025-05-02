SMODS.Joker {
    key = "zodiac",
    order = 77,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.dummy_codex,
            codex_type = 'rank',
            codex_length = 5,
            solved = false,
            stacks = 0,
            lower_by = 10
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 19491,
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
    pools, k_genre = {"Crime", "Mystery"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.lower_by,
                card.ability.extra.stacks
            },
            main_end = Kino.codex_ui(card.ability.extra.codex_solve)
        }
    end,
    calculate = function(self, card, context)

        -- Set the next boss blind to 10% of the goal if you have a stack. Gain a stack when you solve a codex
        -- the codex is ENCRYPTED


        if context.joker_main then
            local result = false
            if not context.blueprint and not context.repetition then
                card.ability.extra.codex_solve, result = Kino.check_codex(card, card.ability.extra.codex, context.full_hand, card.ability.extra.codex_solve)
                if result == true then
                    card.ability.extra.solved = true
                end
            end

            if card.ability.extra.solved then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
                card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'zodiac')
            end
        end

        -- lower the blind
        if context.setting_blind and G.GAME.blind.boss and card.ability.extra.stacks > 0 then
            card.ability.extra.stacks = card.ability.extra.stacks - 1
            G.GAME.blind.chips = math.max((G.GAME.blind.chips * ((card.ability.extra.lower_by) / 100)), 0)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
        
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'zodiac')
   
    end,
}