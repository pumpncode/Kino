SMODS.Joker {
    key = "blair_witch",
    order = 150,
    config = {
        extra = {
            cur_chance = 0,
            chance = 100
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Rerolls are free. Every time you reroll, increase the chance by 5 to destroy all current jokers.
    end
}