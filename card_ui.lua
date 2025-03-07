--- CODE BASED ON THE card_ui.lua IMPLEMENTATION
--- FROM JOYOUSSPRING BY 'N
--- Creates UI to display genres above movie jokers
---@param card Card
---@return table
Kino.get_genre_text = function(card)
    local _genres = card and card.k_genre or {}
    print("Test")
    if #_genres < 1 then
        print("no genres?")
        return {

        }
    end 

    local _full_text = ""
    local _return_table = {}
    for i, _genre in ipairs(_genres) do
        _full_text = _full_text + _genre
        if i < #_genres then
            _full_text = _full_text + "|"
        end
    end

    for i, _genre in ipairs(_genres) do
        _return_table[#_return_table + 1] = {
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = {_genre},
                    colours = {G.ARGS.LOC_COLOURS[_genre]},
                    bump = true,
                    silent = true,
                    pop_in = 0,
                    pop_in_rate = 4,
                    maxw = 5,
                    shadow = true,
                    y_offset = 0,
                    spacing = math.max(0, 0.32 * (17 - #_full_text)),
                    scale = (0.4 - 0.004* #_full_text)
                })
            }
        }
        if i < #_genres then
            _return_table[#_return_table + 1] = {
                n = G.UIT.O,
                config = {
                    text = "|",
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = (0.4 -  0.004 * #_full_text)
                }
            } 
        end
    end

    return _return_table
end

---@param self table
---@param info_queue table
---@param card Card
---@param desc_nodes table
---@param specific_vars table
---@param full_UI_table table
Kino.generate_info_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    print("GENERATING UI")
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    full_UI_table.name = {
        {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.05 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = full_UI_table.name
                },
                {
                    n = G.UIT.R,
                    config = { align = 'cm'},
                    nodes = Kino.get_genre_text(card)
                }

            }
        }
    }
end