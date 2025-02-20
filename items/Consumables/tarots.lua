SMODS.Consumable {
    key = "slasher",
    set = "Tarot",
    order = 1,
    pos = {x = 0, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_horror', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_horror
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "droid",
    set = "Tarot",
    order = 2,
    pos = {x = 1, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_sci_fi', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_sci_fi
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "demon",
    set = "Tarot",
    order = 3,
    pos = {x = 2, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_demonic', 
        max_highlighted = 1,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_demonic
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "witch",
    set = "Tarot",
    order = 4,
    pos = {x = 5, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_fantasy', 
        max_highlighted = 2,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_demonic
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "meetcute",
    set = "Tarot",
    order = 5,
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