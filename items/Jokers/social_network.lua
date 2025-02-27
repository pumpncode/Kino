SMODS.Joker {
    key = "social_network",
    order = 79,
    config = {
        extra = {
            a_chips = 5,
            face_tally = 0,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}

        local face_tally = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:is_face() then face_tally = face_tally+1 end
            end
        end
        return {
            vars = {
                card.ability.extra.a_chips,
                face_tally * card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- +5 chips for each face card in your deck
        card.ability.extra.face_tally = 0
        for k, v in pairs(G.playing_cards) do
            if v:is_face() then card.ability.extra.face_tally = card.ability.extra.face_tally+1 end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.face_tally * card.ability.extra.a_chips
            }
        end
    end
}