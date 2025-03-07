SMODS.Joker {
    key = "turner_and_hooch",
    order = 33,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            is_turner = true,
            evidence = 0,
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6951,
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
    pools, k_genre = {"Action", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.is_turner,
                card.ability.extra.evidence,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Alternates between Turner & Hooch after each hand played.
        -- Turner: Turner, gather evidence. 1 evidence for each card played.
        -- Hooch: Each card gives mult equal to evidence.

        if context.individual and context.cardarea == G.play then
            -- Turner
            if card.ability.extra.is_turner and not context.blueprint then
                card.ability.extra.evidence = card.ability.extra.evidence + 1
            -- Hooch
            else
                return {
                    mult = card.ability.extra.evidence
                }
            end
            
        end

        if context.after then
            if card.ability.extra.is_turner then
                card.ability.extra.is_turner = false
            else
                card.ability.extra.is_turner = true
            end
        end

    end
}