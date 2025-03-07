SMODS.Joker {
    key = "smile",
    order = 118,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Face cards count as Demonic cards
        if context.check_enhancement then 
            if SMODS.Ranks[context.other_card.base.value].face then
                return {m_kino_demonic = true}
            end
        end
    end
}