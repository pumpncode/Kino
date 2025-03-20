-- Quests should check at the following moments
-- After scoring, check if the scored hand is quest compatible
-- When the blind ends, check if everything is quest compatible
-- When the shop is left, check if everything is quest compatible
-- When an item is used 
SMODS.Quests = {}

SMODS.Quest = SMODS.Center:extend({
    obj_table = SMODS.Spells,
    obj_buffer = {},
    required_params = {
        "key",
    },
    inject = function() end,
    set = "Quest",
    class_prefix = "quest",
    discovered = true,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_quest'), G.C.PURPLE, G.C.WHITE, 1.2 )
    end,
    check = function(strength)
        -- return true if it succeeds
    end
})