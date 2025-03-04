function create_UIBox_spells()
	local _pool = {}
	for i, v in pairs(SMODS.Spells) do
        _pool[i] = v
	end

	return SMODS.card_collection_UIBox(_pool, { 5, 5 }, {
		snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
        -- center = 'c_base',
        h_mod = 1.03,
		back_func = 'your_collection_other_gameobjects',
		modify_card = function(card, center)
            card.ignore_pinned = true
            -- center:apply(card, true)
        end,
	})
end

-- local function create_sleeve_button(mod_id)
--     -- creates the sleeve UIBox button in (collection/additions -> other) for given `mod_id`
--     local count = get_sleeve_tally_of(mod_id)
--     return UIBox_button {
--         count = {tally = count.tally, of = count.of},
--         button = 'your_collection_sleeves', label = {localize("k_sleeve")}, minw = 5, id = 'your_collection_sleeves'
--     }
-- end

Kino.custom_collection_tabs = function()
    return {
        UIBox_button({
			button = 'your_collection_spells', 
			label = {'Spells'}, 
			minw = 5,
			minh = 1, 
			id = 'your_collection_spells', 
			focus_args = {snap_to = true}
		})
    }
end

G.FUNCS.your_collection_spells = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
	  definition = create_UIBox_spells(),
	}
end