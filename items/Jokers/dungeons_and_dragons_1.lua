SMODS.Joker {
    key = "dungeons_and_dragons_1",
    order = 191,
    config = {
        extra = {
            stacks = 0,
            a_stacks = 1,
            a_mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11849,
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

            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain stacks when not in the active slot, turn stacks into mult in the active slot
        if context.cast_spell then
            card.ability.extra.stacks = card.ability.extra.stacks + context.strength * card.ability.extra.a_stacks
        end

        if context.joker_main and G.jokers.cards[1] == card then
            local _mult = card.ability.extra.stacks * card.ability.extra.a_mult
            card.ability.extra.stacks = 0
            return {
                mult = _mult
            }
        end
    end
}