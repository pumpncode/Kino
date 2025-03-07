SMODS.Joker {
    key = "oppenheimer",
    order = 108,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Historical", "Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Develop the bomb: 
            -- Three Actions
            -- Get a negative BOMB consumable.
    end
}