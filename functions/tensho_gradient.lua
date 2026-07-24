-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Aplica efeitos de gradiente de cores personalizadas em textos e sílabas, permitindo transições cromáticas lineares ou dinâmicas no Aegisub.

function tensho_gradient_gui(subs, sel, ADD, ADP, ak) 
    --logg("Abrindo GUI de Gradiente (Multi-Ponto, Checkbox Target)...")
    
    if #sel == 0 then
        aegisub.dialog.display({{class="label", label=T("g_warn")}},{"OK"})
        return sel
    end

    local gradient_gui = {
        {class="label", label=T("g_title")},
        
        {class="checkbox", x=0, y=1, width=2, name="rem_gradient", label=T("rem_last"), value=true},
        {class="checkbox", x=0, y=2, width=2, name="use_hsl", label=T("g_hsl"), value=false},
        {class="label", x=0, y=3, width=1, label="" }, 

        {class="label",     x=0, y=4, width=1, label=T("g_apply")},
        {class="checkbox",  x=0, y=5, width=1, name="target_c1", label=T("g_c1"), value=true},
        {class="checkbox",  x=0, y=6, width=1, name="target_c3", label=T("g_c3"), value=true},
        {class="checkbox",  x=0, y=7, width=1, name="target_c4", label=T("g_c4"), value=true},

        {class="label", x=2, y=1, width=1, label="" }, 

        {class="label",    x=3, y=1, width=3, name="use_p1", label=T("g_p1")},
        {class="label",    x=3, y=2, width=1, height=1, label=T("g_pri")},
        {class="color",    x=4, y=2, width=2, height=1, name="p1_c1", value="#FF0000"},
        
        {class="label",    x=3, y=3, width=1, height=1, label=T("g_bor")},
        {class="color",    x=4, y=3, width=2, height=1, name="p1_c3", value="#430000"},
        {class="label",    x=3, y=4, width=1, height=1, label=T("g_shad")},
        {class="color",    x=4, y=4, width=2, height=1, name="p1_c4", value="#1C0000"},

        {class="label",    x=3, y=6, width=3, name="use_p2", label=T("g_p2")},
        {class="label",    x=3, y=7, width=1, height=1, label=T("g_pri")},
        {class="color",    x=4, y=7, width=2, height=1, name="p2_c1", value="#EC00FF"},
        {class="label",    x=3, y=8, width=1, height=1, label=T("g_bor")},
        {class="color",    x=4, y=8, width=2, height=1, name="p2_c3", value="#410047"},
        {class="label",    x=3, y=9, width=1, height=1, label=T("g_shad")},
        {class="color",    x=4, y=9, width=2, height=1, name="p2_c4", value="#210025"},

        {class="label",    x=6, y=1, width=2, label="  " }, 

        {class="checkbox", x=8, y=1, width=3, name="use_p3", label=T("g_i1")},
        {class="label",    x=8, y=2, width=1, height=1, label=T("g_pri")},
        {class="color",    x=9, y=2, width=2, height=1, name="p3_c1", value="#F7FF00"},
        {class="label",    x=8, y=3, width=1, height=1, label=T("g_bor")},
        {class="color",    x=9, y=3, width=2, height=1, name="p3_c3", value="#3E4000"},
        {class="label",    x=8, y=4, width=1, height=1, label=T("g_shad")},
        {class="color",    x=9, y=4, width=2, height=1, name="p3_c4", value="#1E1F00"},

        {class="label",    x=8, y=5, width=3, label="" }, 

        {class="checkbox", x=8, y=6, width=3, name="use_p4", label=T("g_i2")},
        {class="label",    x=8, y=7, width=1, height=1, label=T("g_pri")},
        {class="color",    x=9, y=7, width=2, height=1, name="p4_c1", value="#0EFF00&"},
        {class="label",    x=8, y=8, width=1, height=1, label=T("g_bor")},
        {class="color",    x=9, y=8, width=2, height=1, name="p4_c3", value="#032E00"},
        {class="label",    x=8, y=9, width=1, height=1, label=T("g_shad")},
        {class="color",    x=9, y=9, width=2, height=1, name="p4_c4", value="#011700"},

        {class="label",    x=8, y=10, width=3, label="" }, 

        {class="checkbox", x=8, y=11, width=3, name="use_p5", label=T("g_i3")},
        {class="label",    x=8, y=12, width=1, height=1, label=T("g_pri")},
        {class="color",    x=9, y=12, width=2, height=1, name="p5_c1", value="#2100FF"},
        {class="label",    x=8, y=13, width=1, height=1, label=T("g_bor")},
        {class="color",    x=9, y=13, width=2, height=1, name="p5_c3", value="#08003E"},
        {class="label",    x=8, y=14, width=1, height=1, label=T("g_shad")},
        {class="color",    x=9, y=14, width=2, height=1, name="p5_c4", value="#040023"},

        {class="label", x=0, y=15, width=1, label="" }
    }
    
    if gradient_remembered and gradient_last_res and gradient_last_res.rem_gradient then 
        for _, control in ipairs(gradient_gui) do
            if control.name and gradient_last_res[control.name] ~= nil then 
                 control.value = gradient_last_res[control.name] 
            end
        end
    end

    local btn_g, res_g = ADD(gradient_gui, {T("btn_apply"), T("btn_styles"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn_g == T("btn_back") then return "BACK" end
    if btn_g == T("btn_help") then abrir_help(); return tensho_gradient_gui(subs, sel, ADD, ADP, ak) end
    if btn_g == T("btn_styles") then return tensho_gradient_styles_gui(subs, sel, ADD, ADP, ak) end

    if btn_g == T("btn_apply") then
        if res_g.rem_gradient then gradient_last_res = res_g; gradient_remembered = true end
        
        local key_colors = {} 
        local function add_key_color(n)
             table.insert(key_colors, {
                 c1 = (res_g["p"..n.."_c1"] or "#FFFFFF"):gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&"),
                 c3 = (res_g["p"..n.."_c3"] or "#FFFFFF"):gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&"),
                 c4 = (res_g["p"..n.."_c4"] or "#FFFFFF"):gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")
             })
        end
        add_key_color(1) 
        if res_g.use_p3 then add_key_color(3) end
        if res_g.use_p4 then add_key_color(4) end
        if res_g.use_p5 then add_key_color(5) end
        add_key_color(2) 

        local num_key_colors = #key_colors
        local num_intervals = num_key_colors - 1

        for z, target_line_idx in ipairs(sel) do
            aegisub.progress.set(100 * z / #sel)
            local line = subs[target_line_idx]
            
            local new_text_parts = {} 
            local current_visible_char_index = 0 
            local inline_tag_idx = 1
            local visible_chars = {} 
            local inline_tags = {} 
            local char_count = 0

            if line.class == "dialogue" then
                local original_text = line.text or ""
                local initial_tags = original_text:match(STAG) or "" 
                local text_to_process = original_text:gsub(STAG,"") 

                local temp_text = text_to_process
                repeat
                    local tag_match = temp_text:match("^(%b{})") 
                    if tag_match then
                        table.insert(inline_tags, {pos = char_count, tag = tag_match})
                        temp_text = temp_text:sub(#tag_match + 1)
                    else
                        local char_match = re.find(temp_text, ".") 
                        if char_match then
                            local char_str = char_match[1].str
                            table.insert(visible_chars, char_str) 
                            if char_str ~= " " and char_str ~= "\t" then char_count = char_count + 1 end
                            temp_text = temp_text:sub(char_match[1].last + 1)
                        else temp_text = "" end
                    end
                until temp_text == ""
                
                if char_count < 2 then goto finish_gradient end

                local clean_tags = initial_tags:gsub("\\[134]?c&H%x+&", "")
                if clean_tags ~= "" and clean_tags ~= "{}" then table.insert(new_text_parts, tagmerge(clean_tags)) end

                for _, char_str in ipairs(visible_chars) do
                    local is_space = (char_str == " " or char_str == "\t") 
                    if not is_space then current_visible_char_index = current_visible_char_index + 1 end

                    while inline_tags[inline_tag_idx] and inline_tags[inline_tag_idx].pos == current_visible_char_index - (is_space and 0 or 1) do 
                        table.insert(new_text_parts, inline_tags[inline_tag_idx].tag)
                        inline_tag_idx = inline_tag_idx + 1
                    end

                    if not is_space and char_count > 1 then 
                        local global_factor = (current_visible_char_index - 1) / (char_count - 1) 
                        local interval_float = global_factor * num_intervals 
                        local interval_idx = math.min(math.floor(interval_float) + 1, num_intervals)
                        local local_factor = interval_float - (interval_idx - 1)

                        local cStart = key_colors[interval_idx]
                        local cEnd = key_colors[interval_idx + 1]

                        local color_tag = "{"
                        if res_g.target_c1 then color_tag = color_tag .. "\\c" .. acgrad(cStart.c1, cEnd.c1, 100, local_factor*100 + 1, 1) end
                        if res_g.target_c3 then color_tag = color_tag .. "\\3c" .. acgrad(cStart.c3, cEnd.c3, 100, local_factor*100 + 1, 1) end
                        if res_g.target_c4 then color_tag = color_tag .. "\\4c" .. acgrad(cStart.c4, cEnd.c4, 100, local_factor*100 + 1, 1) end
                        color_tag = color_tag .. "}"
                        table.insert(new_text_parts, color_tag)
                    end
                    table.insert(new_text_parts, char_str)
                end

                line.text = tagmerge(table.concat(new_text_parts, "")):gsub("{(\\N)}","%1")
                subs[target_line_idx] = line
            end
            ::finish_gradient:: 
        end 
    else
        if ak then ak() else aegisub.cancel() end 
    end
    return sel
end

function tensho_gradient_styles_gui(subs, sel, ADD, ADP, ak)
    local style_names = {}
    for i = 1, #subs do
        if subs[i].class == "style" then table.insert(style_names, subs[i].name) end
    end

    local st_gui = {
        {class="label", label=T("gs_title"), x=0, y=0, width=4},
        {x=0,y=1,width=3,class="label",label=""}, 

        {class="label", label=T("gs_s1"), x=0, y=2},
        {class="dropdown", name="s1", items=style_names, value=style_names[1], x=1, y=2, width=3},
        
        {class="label", label=T("gs_s2"), x=0, y=3},
        {class="dropdown", name="s2", items=style_names, value=style_names[1], x=1, y=3, width=3},

        {class="checkbox", name="use_s3", label=T("gs_s3"), x=0, y=4, width=1},
        {class="dropdown", name="s3", items=style_names, value=style_names[1], x=1, y=4, width=3},

        {x=0,y=5,width=3,class="label",label=""}, 

        {class="label", label=T("gs_props"), x=0, y=6, width=4},
        {class="checkbox", name="t_colors", label=T("gs_colors"), value=true, x=0, y=7},
        {class="checkbox", name="t_sizes", label=T("gs_sizes"), value=true, x=1, y=7},

        {x=0,y=8,width=3,class="label",label=""}
    }

    local btn, res = ADD(st_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return tensho_gradient_gui(subs, sel, ADD, ADP, ak) end
    if btn == T("btn_help") then abrir_help(); return tensho_gradient_styles_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    local S1 = stylechk(subs, res.s1)
    local S2 = stylechk(subs, res.s2)
    local S3 = res.use_s3 and stylechk(subs, res.s3) or nil

    for z, idx in ipairs(sel) do
        local line = subs[idx]
        local text_clean = line.text:gsub("%b{}", ""):gsub("\\N", "")
        local chars = {}
        for char in text_clean:gmatch("[%z\1-\127\194-\244][\128-\191]*") do table.insert(chars, char) end
        
        local num_chars = #chars
        if num_chars < 1 then goto next_line end

        local new_text = ""
        local pos_tag = line.text:match("\\pos%b()") or ""
        local an_tag = line.text:match("\\an%d") or ""

        for i, char in ipairs(chars) do
            local factor = (i - 1) / (num_chars - 1)
            if num_chars == 1 then factor = 0.5 end

            local start_s, end_s, local_factor
            if S3 then
                if factor < 0.5 then
                    start_s, end_s, local_factor = S1, S3, factor * 2
                else
                    start_s, end_s, local_factor = S3, S2, (factor - 0.5) * 2
                end
            else
                start_s, end_s, local_factor = S1, S2, factor
            end

            local char_tags = ""
            
            if res.t_colors then
                char_tags = char_tags .. string.format("\\c%s\\2c%s\\3c%s\\4c%s",
                    acgrad(start_s.color1:gsub("H%x%x", "H"), end_s.color1:gsub("H%x%x", "H"), 100, local_factor*100+1, 1),
                    acgrad(start_s.color2:gsub("H%x%x", "H"), end_s.color2:gsub("H%x%x", "H"), 100, local_factor*100+1, 1),
                    acgrad(start_s.color3:gsub("H%x%x", "H"), end_s.color3:gsub("H%x%x", "H"), 100, local_factor*100+1, 1),
                    acgrad(start_s.color4:gsub("H%x%x", "H"), end_s.color4:gsub("H%x%x", "H"), 100, local_factor*100+1, 1))
            end

            if res.t_sizes then
                char_tags = char_tags .. string.format("\\fs%d\\bord%.1f\\shad%.1f",
                    numgrad(start_s.fontsize, end_s.fontsize, 100, local_factor*100+1, 1),
                    numgrad(start_s.outline, end_s.outline, 100, local_factor*100+1, 1),
                    numgrad(start_s.shadow, end_s.shadow, 100, local_factor*100+1, 1))
            end

            new_text = new_text .. "{" .. char_tags .. "}" .. char
        end

        line.text = tagmerge("{" .. pos_tag .. an_tag .. "}" .. new_text)
        subs[idx] = line
        ::next_line::
    end
    return sel
end
