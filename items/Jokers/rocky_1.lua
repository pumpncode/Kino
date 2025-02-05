SMODS.Joker {
    key = "rocky_1",
    order = 11,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 1 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- upgrade hand if it's the final hand.
        if context.before and G.GAME.current_round.hands_left == 0 then
            print("FINAL HAND, SHOULD WORK BRUV")
            return {
                card = self,
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end
}