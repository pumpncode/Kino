-- Support Functions Needed:
-- 1. Create a tooltip for the genre
-- 2. Create a tooltip for the director
-- 3a. make jokers be able to check their cast, and compare.
-- 3b. start displaying cast members over the corresponding jokers if they're present in at least 3 owned jokers.

-- Is genre

-- Genre tooltip

-- Is director

-- Is cast

-- Director tooltip

----------------------
-- COLOURS --
local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["action"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["animation"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["christmas"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["crime"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["drama"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["fantasy"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["gangster"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["heist"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["historical"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["horror"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["musical"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["romance"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["scifi"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["silent"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["sports"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["superhero"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["thriller"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["war"] = HEX("0086a5")
    G.ARGS.LOC_COLOURS["western"] = HEX("0086a5")

    return genrecolors(_c, _default)
end