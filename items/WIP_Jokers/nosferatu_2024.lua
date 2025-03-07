SMODS.Joker {
    key = "nosferatu_2024",
    order = 124,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    pools, k_genre = {"Fantasy", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        
    end
}