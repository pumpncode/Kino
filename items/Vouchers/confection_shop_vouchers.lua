SMODS.Voucher {
    key = "confection_merchant",
    atlas = "kino_vouchers",
    order = 1,
    set = "Voucher",
    pos = { x = 0, y = 0 },
    config = {increase = 2},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {self.config.increase} }
    end,
    redeem = function(self)
        G.GAME["confection_rate"] = G.GAME["confection_rate"]* self.config.increase
    end,
    unredeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]/ self.config.increase
    end
}

SMODS.Voucher {
    key = "confection_tycoon",
    atlas = "kino_vouchers",
    order = 2,
    set = "Voucher",
    pos = { x = 0, y = 1 },
    config = {increase = 2, total = 4},
    discovered = true,
    unlocked = true,
    available = true,
    requires = { "v_kino_confection_merchant"},
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {self.config.total} }
    end,
    redeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]* self.config.increase
    end,
    unredeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]/ self.config.increase
    end
}

SMODS.Voucher {
    key = "special_treats",
    atlas = "kino_vouchers",
    order = 3,
    set = "Voucher",
    pos = { x = 1, y = 0 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end
}