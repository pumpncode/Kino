SMODS.Joker {
    key = "glass",
    order = 153,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_glass",
    pools, k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- non glass cards give +6 mult and have a 1/4 chance
    end
}