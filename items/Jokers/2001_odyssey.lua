SMODS.Joker {
    key = "2001_odyssey",
    order = 46,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            quests = {

            }
            -- quests = {
            --     -- {Trigger context, quest_type, condition, succeeded}
            --     {trigger = nil,
            --     type = nil,
            --     condition = nil,
            --     alt_text = {
            --         "Destroy 5 cards of",
            --         "different ranks"
            --     },
            --     times = 0,
            --     goal = 10, 
            --     completion = false},
            --     {trigger = nil,
            --     type = nil,
            --     condition = nil,
            --     alt_text = {
            --         "Your deck contains more",
            --         "than 10 Sci-Fi Cards"
            --     },
            --     times = 0,
            --     goal = 10,  
            --     completion = true},
            -- }
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 0, y = 0},
    soul_pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = false,
    kino_legendary = function(card, rarity)
        -- should check each requirement
        -- then return the proper rarity if it's correct

        return false
    end,
    kino_joker = {
        id = 62,
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
        local _quest_info = card.ability.extra.quests
        info_queue[#info_queue + 1] = {
            set = "Other", 
            key = "kino_questlog",
            vars = {
            }, 
            main_end = Kino.create_quest_ui(card, _quest_info)
        }
        return {
            vars = {
            },
        }
    end,
    calculate = function(self, card, context)
        -- Each round, one random suit counts as every suit.
        -- Needs to be done through lovely inject, both to accept suit type, and current thing.
        
        -- check quests whenever calc is called
        for _, _quest in ipairs(card.ability.extra.quests) do
            if not _quest.completion then
                local _ret = card:quest_calc(card, _quest, _, context)

                if _ret.completed == true then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "Completed Quest",  colour = G.C.GREEN })
                end
            end
        end

        if context.joker_main and #card.ability.extra.quests == 0 then
            card.ability.extra.quests[#card.ability.extra.quests + 1] = Kino.create_quest("after")
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = "Received Quest!",  colour = G.C.BLACK })
        end

    end
}