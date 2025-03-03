SMODS.Joker {
    key = "batman_1989",
    order = 53,
    config = {
        extra = {
            a_mult = 1,
            total = 0,
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 268,
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
    pools, k_genre = {"Superhero", "Action"},
    j_is_batman = true,

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.total,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- At the end of the round, gain +3 for each open joker slot.\
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.total = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.a_mult
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.j_is_batman then card.ability.extra.total = card.ability.extra.total + (1 * card.ability.extra.a_mult) end
            end
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.total
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}