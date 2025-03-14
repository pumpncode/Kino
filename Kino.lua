Kino = {}
mod_dir = ''..SMODS.current_mod.path

kino_config = SMODS.current_mod.config

-- Kino = SMODS.current_mod
Kino.jokers = {}

Kino.optional_features = function()
    return {
        retrigger_joker = true,
        cardareas = {unscored = true}
    }
end

optional_features = function()
    return {
        retrigger_joker = true,
        cardareas = {unscored = true}
    }
end

local files_to_load = {
    "card_ui.lua",
    "Kinofunctions.lua",
    "src/globals.lua",
    "jokers.lua",
    "src/genre.lua",
    "src/movie_info.lua",
    "KinoUI.lua",

}



local helper, load_error = SMODS.load_file("card_ui.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end
-- Load additional files
local helper, load_error = SMODS.load_file("Kinofunctions.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/globals.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("jokers.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end


-- Register the Jokers
local _usedjokers = {}
local _options = {
    {kino_config.vampire_jokers, vampire_objects},
    {kino_config.sci_fi_enhancement, sci_fi_objects},
    {kino_config.spellcasting, spellcasting_objects},
    {kino_config.demonic_enhancement, demonic_objects},
    {kino_config.horror_enhancement, horror_objects},
    {kino_config.romance_enhancement, romance_objects},
    {kino_config.jumpscare_mechanic, jumpscare_objects}
}

for _i, joker in ipairs(joker_list) do
    -- for each joker_list
    local _add = true
    for i = 1, #_options do
        -- if option is turned off
        if not _options[i][1] then
            for _j, joker_banned in ipairs(_options[i][2].jokers) do
                if joker == joker_banned then
                    _add = false
                end
            end
        end
    end

    if _add then
        _usedjokers[#_usedjokers + 1] = joker
    end
end

-- NEW JOKER LOADING --
for _, joker in ipairs(_usedjokers) do
    assert(SMODS.load_file("Items/Jokers/" .. joker .. ".lua"))()
    Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. joker
end

-- Register the Enhancements
local files = NFS.getDirectoryItems(mod_dir .. "Items/Enhancements")
for _, file in ipairs(files) do
    local _add = true
    for i = 1, #_options do
        -- if option is turned off
        if not _options[i][1] then
            for _j, enhancement_banned in ipairs(_options[i][2].enhancements) do
                if file == (enhancement_banned .. ".lua") then
                    _add = false   
                end
            end
        end
    end
    if _add then
        assert(SMODS.load_file("Items/Enhancements/" .. file))()
    end
end

-- Register the Consumable Types
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumable_types")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumable_types/" .. file))()
end


-- Register the Consumables
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumables")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumables/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(mod_dir .. "Items/Boosters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Boosters/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(mod_dir .. "Items/Vouchers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Vouchers/" .. file))()
end

local files = NFS.getDirectoryItems(mod_dir .. "Items/Stickers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Stickers/" .. file))()
end

if kino_config.spellcasting then
    local files = NFS.getDirectoryItems(mod_dir .. "Items/Spells")
    for _, file in ipairs(files) do
        assert(SMODS.load_file("Items/Spells/" .. file))()
    end
end

-- Register the genres
local helper, load_error = SMODS.load_file("src/genre.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/movie_info.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("KinoUI.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/abduction.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

kino_genre_init()


--
-- SMODS.Keybind{
-- 	key = 'start_synergy_check',
-- 	key_pressed = 'a',
--     held_keys = {'rctrl'}, -- other key(s) that need to be held

--     action = function(self)
--         for i = 1, #G.jokers.cards do
--             G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
--         end
--     end,
-- }

-- SMODS.Keybind{
-- 	key = 'start_genre_check',
-- 	key_pressed = 's',
--     held_keys = {'rctrl'}, -- other key(s) that need to be held

--     action = function(self)
--         check_genre_synergy()
--     end,
-- }

