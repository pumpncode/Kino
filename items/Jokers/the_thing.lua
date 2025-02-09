SMODS.Joker {
    key = "the_thing",
    order = 35,
    config = {
        extra = {
            
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 0},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades", "suits_singular"),
                colours = {
                    G.C.SUITS[G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades"]
                }
            }
        }
    end
}