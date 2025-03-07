SMODS.Joker {
    key = "dungeons_and_dragons_4",
    order = 192,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 5, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 493529,
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
    pools, k_genre = {"Fantasy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you cast a spell, earn money equal to its spell level
        if context.cast_spell then
            ease_dollars(context.strength * card.ability.extra.money)
        end
    end
}