mod_dir = ''..SMODS.current_mod.path

-- Kino_config = SMODS.current_mod.config
-- Kino.enabled = copy_table(Kino_config)

SMODS.Atlas {
    key = "kino_atlas_1",
    px = 71,
    py = 95,
    path =  'kino_jokers_1.png'
}
SMODS.Atlas {
    key = "kino_atlas_2",
    px = 71,
    py = 95,
    path =  'kino_jokers_2.png'
}

SMODS.Atlas {
    key = 'modicon',
    px = 32,
    py = 32,
    path = 'modicon.png'
}

-- Load additional files
local helper, load_error = SMODS.load_file("Kinofunctions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end

-- Add Mult Bonus (Code adapted from AutumnMood (https://github.com/AutumnMood924/AutumnMoodMechanics/blob/main/amm.lua))
local alias__Card_get_chip_mult = Card.get_chip_mult;
function Card:get_chip_mult()
    if self.debuff then return 0 end
    local ret = alias__Card_get_chip_mult(self) + (self.ability.perma_mult or 0)
	return ret
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other["card_extra_mult"] = {
		text = {
			"{C:mult}+#1#{} extra Mult"
		}
	}
end
-- End of adapted code

-- Register the Jokers
local files = NFS.getDirectoryItems(mod_dir .. "Items/Jokers")
for _, file in ipairs(files) do
    print("Loading file: " .. file)
    local status, err = pcall(function()
        return NFS.load(mod_dir .. "/Items/Jokers/" .. file)()
    end)
    sendDebugMessage("Loaded Joker: " .. file, "--KINO")

    if not status then
        error(file .. ": " .. err)
    end
end