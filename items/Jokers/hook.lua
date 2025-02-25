SMODS.Joker {
    key = "hook",
    order = 94,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 3},
    cost = 2,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn scored face cards into random non-face card
        if context.individual and context.other_card:is_face() then
            local _ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10"}
            local _rank = pseudorandom_element(_ranks, pseudoseed("hook"))

            SMODS.change_base(context.other_card, nil, _rank)

            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_hook'), colour = G.C.MULT })
        end
    end
}