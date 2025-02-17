SMODS.Consumable {
    key = "meetcute",
    set = "Tarot",
    order = 4,
    pos = {x = 3, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_romance', 
        max_highlighted = 2,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_romance
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end

}