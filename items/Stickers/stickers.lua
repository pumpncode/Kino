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

SMODS.Sticker{
    key = 'award',

    apply = function(self, card, val)
        -- once the increase val function for kino jokers is implemented
        -- this should increase by x2
    end,
    badge_colour = HEX('ffd081'),

    order = 6,

    pos = { x = 1, y = 0},
    atlas = 'kino_stickers'
}