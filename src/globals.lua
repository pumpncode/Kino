-- Balatro Goes Kino
-- Globals.lua
-- Contains all global base values for the mod

-- Current Round 'globals' --

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    ret.current_round.sci_fi_upgrades_last_round = 0
    ret.current_round.sacrifices_made = 0
    ret.current_round.kryptons_used = 0
    ret.current_round.beaten_run_high = 0
    ret.current_round.horror_transform = 0
    ret.current_round.cards_abducted = 0
    ret.genre_synergy_treshold = 5
    
    ret.spells_cast = 0
    ret.last_spell_cast = {
        key = "",
        rank = 1
    }

    ret.confections_used = 0

    ret.current_round.abduction_waitinglist = {}
    return ret
end

-- General globals
Kino.jump_scare_mult = 3
Kino.goldleaf_chance = 3
Kino.choco_chance = 2
Kino.xl_chance = 1
Kino.actor_synergy = {1, 1, 1.2, 1.4, 1.6, 1.8, 2}
Kino.award_mult = 2

-- DEBUG GLOBALS
Kino.debug_string = "Base"

-- Colour Data

G.C.KINO = {
    ACTION = HEX("0a4a59"),
    ADVENTURE = HEX("0086a5"), -- No color picked yet
    ANIMATION = HEX("0086a5"), -- No color picked yet
    BIOPIC = HEX("0086a5"), -- No color picked yet
    COMEDY = HEX("0086a5"), -- No color picked yet
    CHRISTMAS = HEX("0086a5"), -- No color picked yet
    CRIME = HEX("6a4c47"),
    DRAMA = HEX("694c77"),
    FAMILY = HEX("0086a5"), -- No color picked yet
    FANTASY = HEX("087ad9"),
    GANGSTER = HEX("0086a5"), -- No color picked yet
    HEIST = HEX("0086a5"), -- No color picked yet
    HISTORICAL = HEX("0086a5"), -- No color picked yet
    HORROR = HEX("372a2d"),
    MUSICAL = HEX("0086a5"), -- No color picked yet
    MYSTERY = HEX("0086a5"), -- No color picked yet
    ROMANCE = HEX("c8117d"),
    SCIFI = HEX("1eddd4"),
    SILENT = HEX("0086a5"), -- No color picked yet
    SPORTS = HEX("0086a5"), -- No color picked yet
    SUPERHERO = HEX("0086a5"), -- No color picked yet
    THRILLER = HEX("0086a5"), -- No color picked yet
    WAR = HEX("0086a5"), -- No color picked yet
    WESTERN = HEX("0086a5"),
    PINK = HEX("f7b7f2")
}

local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = G.C.KINO.ACTION
    G.ARGS.LOC_COLOURS["Adventure"] = G.C.KINO.ADVENTURE
    G.ARGS.LOC_COLOURS["Animation"] = G.C.KINO.ANIMATION
    G.ARGS.LOC_COLOURS["Biopic"] = G.C.KINO.BIOPIC
    G.ARGS.LOC_COLOURS["Comedy"] = G.C.KINO.COMEDY
    G.ARGS.LOC_COLOURS["Christmas"] = G.C.KINO.CHRISTMAS
    G.ARGS.LOC_COLOURS["Crime"] = G.C.KINO.CRIME
    G.ARGS.LOC_COLOURS["Drama"] = G.C.KINO.DRAMA
    G.ARGS.LOC_COLOURS["Family"] = G.C.KINO.FAMILY
    G.ARGS.LOC_COLOURS["Fantasy"] = G.C.KINO.FANTASY
    G.ARGS.LOC_COLOURS["Gangster"] = G.C.KINO.GANGSTER
    G.ARGS.LOC_COLOURS["Heist"] = G.C.KINO.HEIST
    G.ARGS.LOC_COLOURS["Historical"] = G.C.KINO.HISTORICAL
    G.ARGS.LOC_COLOURS["Horror"] = G.C.KINO.HORROR
    G.ARGS.LOC_COLOURS["Musical"] = G.C.KINO.MUSICAL
    G.ARGS.LOC_COLOURS["Mystery"] = G.C.KINO.MYSTERY
    G.ARGS.LOC_COLOURS["Romance"] = G.C.KINO.ROMANCE
    G.ARGS.LOC_COLOURS["Sci-fi"] = G.C.KINO.SCIFI
    G.ARGS.LOC_COLOURS["Silent"] = G.C.KINO.SILENT
    G.ARGS.LOC_COLOURS["Sports"] = G.C.KINO.SPORTS
    G.ARGS.LOC_COLOURS["Superhero"] = G.C.KINO.SUPERHERO
    G.ARGS.LOC_COLOURS["Thriller"] = G.C.KINO.THRILLER
    G.ARGS.LOC_COLOURS["War"] = G.C.KINO.WAR
    G.ARGS.LOC_COLOURS["Western"] = G.C.KINO.WESTERN

    return genrecolors(_c, _default)
end