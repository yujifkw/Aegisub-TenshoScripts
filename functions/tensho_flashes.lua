-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Gera efeitos de brilho intermitente ou flashes dinâmicos em partes específicas do texto da legenda para destacar momentos de impacto.

function tensho_flashes_gui(subs, sel, ADD, ADP, ak)
    local flash_gui = {
        {class="label", label=T("fl_title"), x=0, y=0, width=2},
        
        {class="label", label=T("fl_col"), x=0, y=3},
        {class="color", name="flash_color", value="&HFFFFFF&", x=1, y=3},
        {class="label", label=T("fl_int"), x=0, y=4},
        {class="intedit", name="interval", value=150, min=20, x=1, y=4},
        {class="checkbox", name="smoothing", label=T("fl_smooth"), value=true, x=3, y=4, width=2},
        
        {class="label", label=T("fl_apply"), x=0, y=6},
        {class="checkbox", name="target_c1", label=T("fl_c1"), value=true, x=1, y=6},
        {class="checkbox", name="target_c2", label=T("fl_c2"), value=false, x=1, y=7},
        {class="checkbox", name="target_c3", label=T("fl_c3"), value=false, x=1, y=8},
        {class="checkbox", name="target_c4", label=T("fl_c4"), value=false, x=1, y=9},

        {class="checkbox", name="rem_flashes", label=T("rem_last"), value=true, x=0, y=1, width=2},

        {class="label", x=0, y=10, width=1, label="" }
    }

    if flashes_remembered and flashes_last_res and flashes_last_res.rem_flashes then 
        for _, control in ipairs(flash_gui) do
            if control.name and flashes_last_res[control.name] ~= nil then 
                control.value = flashes_last_res[control.name] 
            end
        end
    end

    local btn, res_f = ADD(flash_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_flashes_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    if res_f.rem_flashes then flashes_last_res = res_f; flashes_remembered = true end

    for z, idx in ipairs(sel) do
        aegisub.progress.set(100 * z / #sel)
        local line = subs[idx]
        local style = stylechk(subs, line.style)
        local dur = line.end_time - line.start_time
        
        -- Cores base da linha (caso não haja gradiente)
        local c1_orig_g = line.text:match("\\c(&H%x+&)") or style.color1:gsub("H%x%x", "H")
        local c2_orig_g = line.text:match("\\2c(&H%x+&)") or style.color2:gsub("H%x%x", "H")
        local c3_orig_g = line.text:match("\\3c(&H%x+&)") or style.color3:gsub("H%x%x", "H")
        local c4_orig_g = line.text:match("\\4c(&H%x+&)") or style.color4:gsub("H%x%x", "H")

        -- 1. TOKENIZAÇÃO INTELIGENTE: Pega a linha toda, sem isolar o primeiro bloco
        local text_to_process = line.text:gsub("\\N", "")
        
        local tokens = {}
        local temp_text = text_to_process
        local current_tags = ""
        
        while temp_text ~= "" do
            local tag_match = temp_text:match("^(%b{})")
            if tag_match then
                current_tags = current_tags .. tag_match
                temp_text = temp_text:sub(#tag_match + 1)
            else
                local char_match = re.find(temp_text, ".")
                if char_match and #char_match > 0 then
                    local char_str = char_match[1].str
                    table.insert(tokens, {char = char_str, tags = current_tags})
                    current_tags = ""
                    temp_text = temp_text:sub(char_match[1].last + 1)
                else
                    temp_text = ""
                end
            end
        end

        -- Flash logic
        local interval = res_f.interval
        local flash_c = res_f.flash_color:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")
        
        for _, token in ipairs(tokens) do
            -- IGNORAMOS ESPAÇOS: Não injeta \t em espaços em branco para economizar código inútil
            if token.char:match("%S") then
                
                -- Captura a cor original DESTA letra (ou cai pro fallback global)
                local c1_orig = token.tags:match("\\[1]?c(&H%x+&)") or c1_orig_g
                local c2_orig = token.tags:match("\\2c(&H%x+&)") or c2_orig_g
                local c3_orig = token.tags:match("\\3c(&H%x+&)") or c3_orig_g
                local c4_orig = token.tags:match("\\4c(&H%x+&)") or c4_orig_g

                local flash_tags = ""
                local current_t = 0
                local is_flash_state = true
                
                while current_t < dur do
                    local next_t = math.min(current_t + interval, dur)
                    local t_end_transform = res_f.smoothing and next_t or current_t
                    local target_tags = ""
                    
                    if is_flash_state then
                        -- Estado de FLASH: aplica cor do flash
                        if res_f.target_c1 then target_tags = target_tags .. "\\c" .. flash_c end
                        if res_f.target_c2 then target_tags = target_tags .. "\\2c" .. flash_c end
                        if res_f.target_c3 then target_tags = target_tags .. "\\3c" .. flash_c end
                        if res_f.target_c4 then target_tags = target_tags .. "\\4c" .. flash_c end
                    else
                        -- Estado NORMAL: força o retorno à cor original
                        if res_f.target_c1 then target_tags = target_tags .. "\\c" .. c1_orig end
                        if res_f.target_c2 then target_tags = target_tags .. "\\2c" .. c2_orig end
                        if res_f.target_c3 then target_tags = target_tags .. "\\3c" .. c3_orig end
                        if res_f.target_c4 then target_tags = target_tags .. "\\4c" .. c4_orig end
                    end
                    
                    if target_tags ~= "" then
                        flash_tags = flash_tags .. string.format("\\t(%d,%d,%s)", current_t, t_end_transform, target_tags)
                    end
                    
                    current_t = next_t
                    is_flash_state = not is_flash_state
                end
                
                -- Injeção manual dentro da chave existente
                if token.tags ~= "" then
                    token.tags = token.tags:gsub("}$", flash_tags .. "}")
                else
                    token.tags = "{" .. flash_tags .. "}"
                end
            end
        end

        -- 3. RECONSTRUÇÃO DA LINHA
        local new_text = ""
        for _, token in ipairs(tokens) do
            new_text = new_text .. token.tags .. token.char
        end

        line.text = new_text
        subs[idx] = line
    end

    return sel
end
