SMODS.Consumable {
    key = "slasher",
    set = "Tarot",
    order = 1,
    pos = {x = 0, y = 5},
    atlas = "kino_atlas_2",
    config = {
        mod_conv = 'm_kino_sci_fi', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_sci_fi
        ----
        --
        --
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end

}