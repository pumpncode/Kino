--- Abduction UI ---
Kino.create_abduction_ui = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                minh = 0.6,
                maxh = 1.2,
                minw = 0.6,
                maxw = 2,
                r = 0.001,
                padding = 0,
                align = 'cm',
                colour = G.C.CLEAR,
                shadow = false,
                ref_table = card
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        minh = 1,
                        maxh = 1,
                        minw = 1,
                        maxw = 1,
                        align = 'tr',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                w = 1, 
                                h = 1,
                                can_collide = false, 
                                object = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=0, y=0}), 
                                tooltip = {text = "Abductions"}
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = "3",
                                        colour = G.C.WHITE, 
                                        scale = 0.4, 
                                        shadow = true
                                    }  
                                }
                            }
                        }
                        -- {
                        --     n = G.UIT.T,
                        --     config = {
                        --         text = "2",
                        --         colour = G.C.WHITE, 
                        --         scale = 0.4, 
                        --         shadow = true
                        --     }  
                        -- }
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

Kino.create_abduction_ui_2 = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                minh = 1.3,
                maxh = 1.3,
                minw = 1,
                maxw = 1,
                r = 0.001,
                padding = 0,
                align = 'cm',
                colour = G.C.CLEAR,
                shadow = false,
                ref_table = card
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = 'tr',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability.extra,
                                ref_value = "num_cards_abducted_non",
                                colour = G.C.WHITE, 
                                scale = 0.3, 
                                shadow = true
                            }  
                        }
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

Kino.create_active_ui = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                padding = 0,
                align = 'cm',
                colour = G.C.CLEAR,
                shadow = false,
                ref_table = card
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = 'cm',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                can_collide = false, 
                                object = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS["kino_ui_large"], {x=0, y=0}), 
                                tooltip = {text = "Active"}
                            },
                        }
                    }
                }
            }
        },
        config = {
            align = "cm",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

-- function ufo_sprite(pos, value)
--     local text_colour = G.C.BLACK

--     local t_s = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=pos.x or 0, y=pos.y or 0})
--     t_s.states.drag.can = false
--     t_s.states.hover.can = false
--     t_s.states.collide.can = false
--     return {
--         n=G.UIT.C, 
--         config= {
--             align = "cm", 
--             padding = 0.07,
--             force_focus = true,  
--             focus_args = {type = 'sprite'}, 
--             tooltip = {text = "Abductions"}
--         }, 
--         nodes = {{
--             n= G.UIT.R, 
--             config = {
--                 align = "cm", 
--                 r = 0.1, 
--                 padding = 0.04, 
--                 emboss = 0.05, 
--                 colour = G.C.JOKER_GREY
--             }, 
--             nodes={{
--                 n = G.UIT.O, 
--                 config = {
--                     w = 0.5, 
--                     h = 0.5,
--                     can_collide = false, 
--                     object = t_s, 
--                     tooltip = {text = "Abductions"}
--                 }
--             }}
--         },
--         {
--             n = G.UIT.R, 
--             config = {
--                 align = "cm"
--             }, 
--             nodes = {{
--                 n = G.UIT.T, 
--                 config = {
--                     text = value,
--                     colour = text_colour, 
--                     scale = 0.4, 
--                     shadow = true
--                 }
--             },}
--         }}
--     }
-- end

--- CODE BASED ON THE card_ui.lua IMPLEMENTATION
--- FROM JOYOUSSPRING BY 'N
--- Creates UI to display genres above movie jokers
---@param card Card
---@return table
Kino.get_genre_text = function(card)
    local _scale_base = 0.8
    local _genres = card and card.config.center.k_genre or {}
    if #_genres < 1 then
        return {

        }
    end 

    local _full_text = ""
    local _genre_table = {}
    for i, _genre in ipairs(_genres) do
        _full_text = _full_text .. _genre
        if i < #_genres then
            _full_text = _full_text .. "|"
        end
    end

    for i, _genre in ipairs(_genres) do
        _genre_table[#_genre_table + 1] = {
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
                    scale = (0.4 - 0.004* #_full_text) * _scale_base
                })
            }
        }
    end
    local separator = {
        n = G.UIT.T,
        config = {
            text = "/",
            colour = G.C.UI.TEXT_LIGHT,
            scale = (0.4 - 0.004 * #_full_text) * _scale_base
        }
    }

    return {
        _genre_table[1],
        _genre_table[2] and separator or nil,
        _genre_table[2],
        _genre_table[3] and separator or nil,         
        _genre_table[3],
    }
end

---@param self table
---@param info_queue table
---@param card Card
---@param desc_nodes table
---@param specific_vars table
---@param full_UI_table table
Kino.generate_info_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
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