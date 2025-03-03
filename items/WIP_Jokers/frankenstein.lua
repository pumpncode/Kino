SMODS.Joker {
    key = "frankenstein",
    order = 99,
    config = {
        extra = {
            is_used = false,
            chips = 0,
            mult = 0,
            xmult = 0,
            xchips = 0

        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3035,
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
    pools, k_genre = {"Horror", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.is_used,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is destroyed, gain all its upgrades

        if context.destroying_card and not context.blueprint 
        and not context.repetition and not card.ability.extra.is_used then
            local _card = context.destroying_card
            card.ability.extra.chips = card.ability.extra.chips + _card.ability.extra.base  + _card.ability.extra.bonus
            card.ability.extra.mult = card.ability.extra.mult + _card.ability.extra.mult + _card.ability.extra.perma_mult
            card.ability.extra.xmult = card.ability.extra.xmult + _card.ability.extra.perma_xmult
            -- card.ability.extra.chips = card.ability.extra.chips + _card.ability.extra.base  + _card.ability.extra.perma_
            return true
        end

        if context.after and not context.repetition and not context.blueprint then
            card.ability.extra.is_used = true
        end

        if context.joker_main and card.ability.extra.is_used then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult
            }
        end
    end
}