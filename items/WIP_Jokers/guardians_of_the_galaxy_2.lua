SMODS.Joker {
    key = "file_name",
    order = 153,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 1},
    cost = 6,
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
       -- transform every planet into ego when you select a blind

    end
}