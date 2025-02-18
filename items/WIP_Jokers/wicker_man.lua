SMODS.Joker {
    key = "wicker_man",
    order = 110,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- when your first discard is only 1 card,
        -- destroy it and gain mult equal its sell value
        -- resets after you defeat a boss blind
        
    end
}