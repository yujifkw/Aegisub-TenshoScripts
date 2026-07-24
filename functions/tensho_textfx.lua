-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Suíte focada em manipulações avançadas de texto e caracteres por bloco, facilitando a aplicação de efeitos tipográficos customizados.

function tensho_textfx_gui(subs, sel, ADD, ADP, ak)
    local tf_gui = {
        {class="label", label=T("tf_title"), x=0, y=0, width=4},
        
        {x=0,y=2,width=6,class="label",label=""}, 

        {class="label", label=T("tf_mode"), x=0, y=3},
        {class="dropdown", name="mode", items={T("tf_m_rf"), T("tf_m_type"), T("tf_m_unscr"), T("tf_m_sym"), T("tf_m_inv")}, value=T("tf_m_rf"), x=1, y=3, width=3},

        {class="label", label=T("tf_p_rf"), x=0, y=5, width=4},
        {class="label", label=T("tf_step"), x=0, y=6},
        {class="intedit", name="step_rf", value=40, min=40, max=500, x=1, y=6},
        {class="checkbox", name="rf_char", label=T("tf_rf_char"), value=false, x=0, y=7, width=2},
        {class="label", label=T("tf_var"), x=2, y=7},
        {class="intedit", name="size_var", value=0, x=3, y=7},

        {class="label", label=T("tf_p_tu"), x=0, y=9, width=4},
        {class="label", label=T("tf_step"), x=0, y=10},
        {class="intedit", name="step_tu", value=40, min=40, max=500, x=1, y=10},
        {class="label", label=T("tf_speed"), x=2, y=10},
        {class="intedit", name="speed_tu", value=50, x=3, y=10},
        {class="checkbox", name="dyn_jump", label=T("tf_dyn"), value=false, x=0, y=11, width=4},

        {class="label", label=T("tf_p_sym"), x=0, y=13, width=4},
        {class="label", label=T("tf_step"), x=0, y=14},
        {class="intedit", name="step_sym", value=40, min=40, max=500, x=1, y=14},

        {class="label", label=T("tf_p_inv"), x=0, y=16, width=4},
        {class="label", label=T("tf_inv_dir"), x=0, y=17},
        {class="dropdown", name="inv_dir", items={T("tf_opt_x"), T("tf_opt_y"), T("tf_opt_xy")}, value=T("tf_opt_x"), x=1, y=17, width=2},

        {x=0,y=18,width=6,class="label",label=""}, 
    
        {class="checkbox", name="rem", label=T("rem_last"), value=true, x=0, y=1, width=2}
    }

    if randomfont_remembered and randomfont_last_res and randomfont_last_res.rem then 
        for _, control in ipairs(tf_gui) do
            if control.name and randomfont_last_res[control.name] ~= nil then control.value = randomfont_last_res[control.name] end
        end
    end

    local btn, res = ADD(tf_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_textfx_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end
    if res.rem then randomfont_last_res = res; randomfont_remembered = true end

    -- DICIONÁRIOS DE DADOS
    local fonts = {"Roboto", "Monotype Corsiva", "Times New Roman", "Lucida Console", "Courier New", "Comic Sans MS", "Carrois Gothic SC"}
    local font_scales = {["Roboto"]=1.0, ["Monotype Corsiva"]=1.1, ["Times New Roman"]=1.0, ["Lucida Console"]=0.8, ["Courier New"]=1.0, ["Comic Sans MS"]=1.0, ["Carrois Gothic SC"]=0.9}
    local symbols = {"*", "&", "%", "@", "#", "!", "$", "+", "=", "?", "§", "Δ", "0", "1", "7"}
    
    local map_x = {
        A="A", B="ᗺ", C="Ɔ", D="ᗡ", E="Ǝ", F="ꟻ", G="⅁", H="H", I="I", J="Ⴑ", K="ꓘ", L="⅃", M="M", N="И", O="O", P="ꟼ", Q="Ọ", R="Я", S="Ƨ", T="T", U="U", V="V", W="W", X="X", Y="Y", Z="Z",
        a="ɒ", b="d", c="ɔ", d="b", e="ɘ", f="ꟻ", g="ǫ", h="d", i="i", j="ꞁ", k="ʞ", l="l", m="m", n="n", o="o", p="q", q="p", r="ɿ", s="ƨ", t="t", u="u", v="v", w="w", x="x", y="y", z="z"
    }
    local map_y = {
        A="∀", B="B", C="C", D="D", E="E", F="Ⅎ", G="G", H="H", I="I", J="ſ", K="K", L="⅂", M="W", N="N", O="O", P="d", Q="Q", R="R", S="S", T="⊥", U="∩", V="Λ", W="M", X="X", Y="⅄", Z="Z",
        a="ɐ", b="p", c="ɔ", d="q", e="ǝ", f="ɟ", g="ƃ", h="ɥ", i="ı", j="ɾ", k="ʞ", l="l", m="ɯ", n="u", o="o", p="b", q="d", r="ɹ", s="s", t="ʇ", u="n", v="ʌ", w="ʍ", x="x", y="ʎ", z="z"
    }
    local map_both = {
        A="∀", B="ᗺ", C="Ɔ", D="ᗡ", E="Ǝ", F="Ⅎ", G="⅁", H="H", I="I", J="ſ", K="ꓘ", L="⅂", M="W", N="N", O="O", P="d", Q="Q", R="R", S="S", T="⊥", U="∩", V="Λ", W="M", X="X", Y="⅄", Z="Z",
        a="ɐ", b="q", c="ɔ", d="p", e="ǝ", f="ɟ", g="ƃ", h="ɥ", i="ı", j="ɾ", k="ʞ", l="l", m="ɯ", n="u", o="o", p="d", q="b", r="ɹ", s="s", t="ʇ", u="n", v="ʌ", w="ʍ", x="x", y="ʎ", z="z"
    }

    local new_subs_indices = {}

    for z = #sel, 1, -1 do
        local idx = sel[z]
        local line = subs[idx]
        local st, et = line.start_time, line.end_time
        local style = stylechk(subs, line.style)

        -- Extrai o fade original da linha
        local fad_in, fad_out = line.text:match("\\fad%(([%d%.]+),([%d%.]+)%)")
        fad_in, fad_out = tonumber(fad_in) or 0, tonumber(fad_out) or 0
        local global_st, global_et = line.start_time, line.end_time
        
        local STAG = "^{\\[^}]-}"
        local initial_tags = line.text:match(STAG) or ""

        local initial_tags_clean = initial_tags:gsub("\\fad%([^%)]-%)", "")
        if initial_tags_clean == "" then initial_tags_clean = "{}" end

        local clean_initial = initial_tags:gsub("\\fad%([^%)]-%)", ""):gsub("\\alpha&H%x%x&", "")
        if clean_initial == "" then clean_initial = "{}" end


        local text_to_process = line.text:gsub(STAG, ""):gsub("\\N", "")
        
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
                    current_tags = "" -- Reseta a mochila após entregar as tags para a letra
                    temp_text = temp_text:sub(char_match[1].last + 1)
                else
                    temp_text = ""
                end
            end
        end
        
        local num_chars = #tokens
        if num_chars == 0 then goto skip_line end

        local base_fs = tonumber(line.text:match("\\fs([%d%.]+)")) or style.fontsize
        local base_alpha = line.text:match("\\alpha(&H%x%x&)") or "&H00&"
        
        -- Monta o texto limpo mas COM as tags inline para os frames finais (Clean Passes)
        local reconstruct_full_line = ""
        for i=1, num_chars do 
            reconstruct_full_line = reconstruct_full_line .. tokens[i].tags .. tokens[i].char 
        end

        local offset = 1

        -- SEÇÃO 1: INVERTER LETRAS
        if res.mode == T("tf_m_inv") then
            local inv_text = ""
            local mirror_x = (res.inv_dir == T("tf_opt_x") or res.inv_dir == T("tf_opt_xy"))
            
            local start_i, end_i, step_i = 1, num_chars, 1
            if mirror_x then start_i, end_i, step_i = num_chars, 1, -1 end

            local char_index = 1
            for i = start_i, end_i, step_i do
                local char = tokens[i].char
                local new_char = char
                if res.inv_dir == T("tf_opt_x") then 
                    new_char = map_x[char] or char
                elseif res.inv_dir == T("tf_opt_y") then 
                    new_char = map_y[char] or char
                else 
                    new_char = map_both[char] or char 
                end
                
                inv_text = inv_text .. tokens[char_index].tags .. new_char
                char_index = char_index + 1
            end
            
            local nl = table.copy(line)
            nl.start_time, nl.end_time = st, et
            local original_fad = line.text:match("\\fad%([^%)]-%)") or ""
            local clean_initial = initial_tags:gsub("\\fad%([^%)]-%)", "")
            if clean_initial == "" then clean_initial = "{}" end
            local tags_with_fade = clean_initial:gsub("}$", original_fad .. "}")
            
            nl.text = tagmerge(tags_with_fade .. inv_text)
            nl.effect = "Inverted"
            subs.insert(idx + offset, nl)
            table.insert(new_subs_indices, idx + offset)

        -- SEÇÃO 2: TYPEWRITER
        elseif res.mode == T("tf_m_type") then
            local actual_step = math.max(res.step_tu, 40)
            local anim_dur = num_chars * res.speed_tu
            local anim_end = math.min(st + anim_dur, et)
            if anim_end <= st then anim_end = et end

            local text = ""

            for t = st, anim_end - 1, actual_step do
                local t_end = math.min(t + actual_step, anim_end)
                local current_rel_ms = t - st
                local final_text = ""

                for i, m in ipairs(tokens) do
                    local trigger_t = (i - 1) * res.speed_tu
                    if current_rel_ms >= trigger_t then
                        final_text = final_text .. m.tags .. string.format("{\\alpha%s}%s", base_alpha, m.char)
                    else
                        if not res.dyn_jump then final_text = final_text .. m.tags .. "{\\alpha&HFF&}" .. m.char end
                    end
                end

                text = final_text

                local nl = table.copy(line)
                nl.start_time, nl.end_time = t, t_end 
                
                -- Cálculo seguro
                local smart_alpha = get_smart_alpha(nl.start_time, nl.end_time, global_st, global_et, fad_in, fad_out)
                local effective_alpha = (smart_alpha ~= "") and smart_alpha or ("\\alpha" .. base_alpha)
                
                -- Injeção segura
                local tags_with_alpha = clean_initial:gsub("}$", effective_alpha .. "}")
                nl.text = tagmerge(tags_with_alpha .. final_text)

                nl.comment, nl.effect = false, "Typewriter"
                subs.insert(idx + offset, nl)
                table.insert(new_subs_indices, idx + offset)
                offset = offset + 1
            end

            if anim_end < et then
                local clean_l = table.copy(line)
                clean_l.start_time, clean_l.end_time = anim_end, et
                clean_l.comment, clean_l.effect = false, ""

                local original_fad_out = (fad_out > 0) and string.format("\\fad(0,%d)", fad_out) or ""

                local clean_initial = initial_tags:gsub("\\fad%([^%)]-%)", ""):gsub("\\alpha&H%x%x&", "")
                if clean_initial == "" then clean_initial = "{}" end

                local final_initial_tags = clean_initial:gsub("}$", "\\alpha" .. base_alpha .. original_fad_out .. "}")

                clean_l.text = tagmerge(final_initial_tags .. reconstruct_full_line)
                
                subs.insert(idx + offset, clean_l)
                table.insert(new_subs_indices, idx + offset)
            end

        -- SEÇÃO 3: UNSCRAMBLE
        elseif res.mode == T("tf_m_unscr") then
            local actual_step = math.max(res.step_tu, 40)
            local scramble_time = 120
            local anim_dur = (num_chars - 1) * res.speed_tu + scramble_time
            local anim_end = math.min(st + anim_dur, et)
            if anim_end <= st then anim_end = et end

            for t = st, anim_end - 1, actual_step do
                local t_end = math.min(t + actual_step, anim_end)
                local current_rel_ms = t - st
                local final_text = ""

                for i, m in ipairs(tokens) do
                    local trigger_t = (i - 1) * res.speed_tu
                    if current_rel_ms < trigger_t then
                        if not res.dyn_jump then final_text = final_text .. m.tags .. "{\\alpha&HFF&}" .. m.char end
                    elseif current_rel_ms >= trigger_t and current_rel_ms < trigger_t + scramble_time then
                        local r_sym = symbols[math.random(1, #symbols)]
                        final_text = final_text .. m.tags .. string.format("{\\alpha%s}%s", base_alpha, r_sym)
                    else
                        final_text = final_text .. m.tags .. string.format("{\\alpha%s}%s", base_alpha, m.char)
                    end
                end

                text = final_text

                local nl = table.copy(line)
                nl.start_time, nl.end_time = t, t_end 
                
                -- Cálculo seguro
                local smart_alpha = get_smart_alpha(nl.start_time, nl.end_time, global_st, global_et, fad_in, fad_out)
                local effective_alpha = (smart_alpha ~= "") and smart_alpha or ("\\alpha" .. base_alpha)
                
                -- Injeção segura
                local tags_with_alpha = clean_initial:gsub("}$", effective_alpha .. "}")
                nl.text = tagmerge(tags_with_alpha .. final_text)

                nl.comment, nl.effect = false, "Unscramble"
                subs.insert(idx + offset, nl)
                table.insert(new_subs_indices, idx + offset)
                offset = offset + 1
            end

            if anim_end < et then
                local clean_l = table.copy(line)
                clean_l.start_time, clean_l.end_time = anim_end, et
                clean_l.comment, clean_l.effect = false, ""

                local original_fad_out = (fad_out > 0) and string.format("\\fad(0,%d)", fad_out) or ""

                local clean_initial = initial_tags:gsub("\\fad%([^%)]-%)", ""):gsub("\\alpha&H%x%x&", "")
                if clean_initial == "" then clean_initial = "{}" end

                local final_initial_tags = clean_initial:gsub("}$", "\\alpha" .. base_alpha .. original_fad_out .. "}")

                clean_l.text = tagmerge(final_initial_tags .. reconstruct_full_line)
                
                subs.insert(idx + offset, clean_l)
                table.insert(new_subs_indices, idx + offset)
            end

        -- SEÇÃO 4: SÍMBOLOS
        elseif res.mode == T("tf_m_sym") then
            local actual_step = math.max(res.step_sym, 40)
            
            for t = st, et - 1, actual_step do
                local t_end = math.min(t + actual_step, et)
                local final_text = ""

                for i, m in ipairs(tokens) do
                    if math.random(1, 100) <= 30 then
                        final_text = final_text .. m.tags .. symbols[math.random(1, #symbols)]
                    else
                        final_text = final_text .. m.tags .. m.char
                    end
                end

                local nl = table.copy(line)
                nl.start_time, nl.end_time = t, t_end 
                local smart_alpha = get_smart_alpha(nl.start_time, nl.end_time, global_st, global_et, fad_in, fad_out)
                local tags_com_alpha = initial_tags_clean:gsub("}$", "\\" .. smart_alpha .. "}")
                nl.text = tagmerge(tags_com_alpha .. final_text)
                nl.comment, nl.effect = false, "Caos"
                subs.insert(idx + offset, nl)
                table.insert(new_subs_indices, idx + offset)
                offset = offset + 1
            end

        -- SEÇÃO 5: RANDOM FONTS
        elseif res.mode == T("tf_m_rf") then
            local actual_step = math.max(res.step_rf, 40)
            
            for t = st, et - 1, actual_step do
                local t_end = math.min(t + actual_step, et)
                local final_text = ""

                if res.rf_char then
                    for i, m in ipairs(tokens) do
                        local picked_f = fonts[math.random(1, #fonts)]
                        local active_s = font_scales[picked_f] or 1.0
                        local fs_val = math.floor((base_fs * active_s) + 0.5) + math.random(-res.size_var, res.size_var)
                        final_text = final_text .. m.tags .. string.format("{\\fn%s\\fs%d}%s", picked_f, fs_val, m.char)
                    end
                else
                    local picked_f = fonts[math.random(1, #fonts)]
                    local active_s = font_scales[picked_f] or 1.0
                    local fs_val = math.floor((base_fs * active_s) + 0.5) + math.random(-res.size_var, res.size_var)
                    final_text = string.format("{\\fn%s\\fs%d}", picked_f, fs_val)
                    for i, m in ipairs(tokens) do
                        final_text = final_text .. m.tags .. m.char
                    end
                end

                local nl = table.copy(line)
                nl.start_time, nl.end_time = t, t_end 
                local smart_alpha = get_smart_alpha(nl.start_time, nl.end_time, global_st, global_et, fad_in, fad_out)
                local tags_com_alpha = initial_tags_clean:gsub("}$", "\\" .. smart_alpha .. "}")
                nl.text = tagmerge(tags_com_alpha .. final_text)
                nl.comment, nl.effect = false, "RandFont"
                subs.insert(idx + offset, nl)
                table.insert(new_subs_indices, idx + offset)
                offset = offset + 1
            end
        end

        line.comment = true
        subs[idx] = line

        ::skip_line::
    end
    return new_subs_indices
end
