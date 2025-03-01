SMODS.Sticker{ -- bacon sticker
    key = 'bacon',

    apply = function(self, card, val)
        if card.ability.kino_bacon then return end
        card.ability[self.key] = val
    end,

    badge_colour = HEX('9eacbe'),

    order = 5,

    pos = { x = 0, y = 0},
    atlas = 'kino_stickers'
}