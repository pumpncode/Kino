SMODS.Joker {
    key = "ghostbusters_1",
    order = 68,
    config = {
        extra = {
            chips = 0,
            a_chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 620,
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
    pools, k_genre = {"Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a debuffed card,
        -- destroy it, and gain +5 chips.

        if context.destroying_card and context.cardarea == G.play and context.destroying_card.debuff and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips
            return { remove = true }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
}