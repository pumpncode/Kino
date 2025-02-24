SMODS.Joker {
    key = "the_number_23",
    order = 147,
    config = {
        extra = {
            mult = 23
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +23 mult if the combined value of ranks played is 23
        if context.joker_main then
            local _tally = 0
            for i = 1, #context.full_hand do
                _tally = _tally + context.full_hand[i].base.nominal
            end

            print(_tally)

            if _tally == 23 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}