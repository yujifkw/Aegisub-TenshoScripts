-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Ferramenta de contagem e numeração progressiva de quadros ou elementos para marcações técnicas em linhas de legendas.

function tensho_counter_gui(subs, sel, ADD, ADP, ak)
    local first_line = subs[sel[1]]
    local style = stylechk(subs, first_line.style)
    
    -- Extrai coordenadas base
    local ox, oy = first_line.text:match("\\pos%(([%d%.%-]+),%s*([%d%.%-]+)%)")
    if not ox then ox, oy = first_line.text:match("\\move%(([%d%.%-]+),%s*([%d%.%-]+)") end
    if not ox then ox, oy = 0, 0 end

    -- Extrai atributos visuais (Fonte, Cores e Alpha Original)
    local base_fs = tonumber(first_line.text:match("\\fs([%d%.]+)")) or style.fontsize
    local base_c1 = first_line.text:match("\\[1]?c(&H%x+&)") or style.color1:gsub("H%x%x", "H")
    local base_c3 = first_line.text:match("\\3c(&H%x+&)") or style.color3:gsub("H%x%x", "H")
    local base_c4 = first_line.text:match("\\4c(&H%x+&)") or style.color4:gsub("H%x%x", "H")
    local def_alpha_from = first_line.text:match("\\alpha(&H%x+&)") or "&H00&"

    -- Lê a configuração global do TenshoScripts para definir o modo do Alpha
    local val_alpha_from = def_alpha_from
    local class_alpha = "alpha"
    if tensho_cfg.alpha_100 then
        class_alpha = "intedit"
        val_alpha_from = alpha_to_pct(def_alpha_from)
    end

    -- Mapeia todos os estilos do arquivo para o Dropdown
    local style_list = {}
    for i = 1, #subs do
        if subs[i].class == "style" then
            table.insert(style_list, subs[i].name)
        end
    end

    -- Helpers de Cor (ASS <-> HTML)
    local function assToHtml(ass)
        if not ass then return "#FFFFFF" end
        local bb, gg, rr = ass:match("&H(%x%x)(%x%x)(%x%x)&?")
        if not bb then return "#FFFFFF" end
        return "#" .. rr .. gg .. bb
    end

    local function htmlToAss(html)
        if not html then return "&HFFFFFF&" end
        local rr, gg, bb = html:match("#(%x%x)(%x%x)(%x%x)")
        if not rr then return "&HFFFFFF&" end
        return "&H" .. bb .. gg .. rr .. "&"
    end

    -- Configuração Inicial unificada
    local config = {}
    if counter_remembered and counter_last_res then
        config = table.copy(counter_last_res)
    else
        config = {
            v_start=0, v_end=100, dur=0, px=tonumber(ox) or 0, py=tonumber(oy) or 0,
            use_an5=true, mirror=false, rem_ctr=true,
            style_name=first_line.style,
            fs_s=base_fs, fs_e=base_fs,
            c1_s=assToHtml(base_c1), c1_e=assToHtml(base_c1),
            c3_s=assToHtml(base_c3), c3_e=assToHtml(base_c3),
            c4_s=assToHtml(base_c4), c4_e=assToHtml(base_c4),
            a_s=val_alpha_from, a_e=val_alpha_from
        }
    end
    
    local ctr_gui = {
        {class="label", label=T("ct_title"), x=0, y=0, width=5},
        {class="checkbox", name="rem_ctr", label=T("rem_last"), value=config.rem_ctr, x=0, y=1, width=3},
        
        -- LADO ESQUERDO: NORMAL
        {class="label", label=T("ct_start"), x=0, y=3}, {class="intedit", name="v_start", value=config.v_start, x=1, y=3},
        {class="label", label=T("ct_end"), x=0, y=4}, {class="intedit", name="v_end", value=config.v_end, x=1, y=4},
        {class="label", label=T("ct_dur"), x=0, y=5}, {class="intedit", name="dur", value=config.dur, hint=T("ct_dur_hint"), x=1, y=5},
        {class="label", label=T("ct_px"), x=0, y=6}, {class="floatedit", name="px", value=config.px, x=1, y=6},
        {class="label", label=T("ct_py"), x=0, y=7}, {class="floatedit", name="py", value=config.py, x=1, y=7},
        {class="checkbox", name="use_an5", label=T("ct_an5"), value=config.use_an5, x=0, y=8, width=2},

        -- LADO DIREITO: AVANÇADO (Transições)
        {class="label", label=T("ct_style"), x=3, y=1}, 
        {class="dropdown", name="style_name", items=style_list, value=config.style_name, x=4, y=1, width=2},
        
        {class="label", label=T("ct_from"), x=4, y=2}, {class="label", label=T("ct_to"), x=5, y=2},
        
        {class="label", label=T("ct_fs"), x=3, y=3}, {class="floatedit", name="fs_s", value=config.fs_s, x=4, y=3}, {class="floatedit", name="fs_e", value=config.fs_e, x=5, y=3},
        {class="label", label=T("ct_c1"), x=3, y=4}, {class="color", name="c1_s", value=config.c1_s, x=4, y=4}, {class="color", name="c1_e", value=config.c1_e, x=5, y=4},
        {class="label", label=T("ct_c3"), x=3, y=5}, {class="color", name="c3_s", value=config.c3_s, x=4, y=5}, {class="color", name="c3_e", value=config.c3_e, x=5, y=5},
        {class="label", label=T("ct_c4"), x=3, y=6}, {class="color", name="c4_s", value=config.c4_s, x=4, y=6}, {class="color", name="c4_e", value=config.c4_e, x=5, y=6},
        
        -- Alpha (Interface decidida pelo modo global)
        {class="label", label="Alpha:", x=3, y=7}, 
        {class=class_alpha, name="a_s", value=config.a_s, min=0, max=100, x=4, y=7}, 
        {class=class_alpha, name="a_e", value=config.a_e, min=0, max=100, x=5, y=7},
        
        {class="checkbox", name="mirror", label=T("ct_mirror"), value=config.mirror, x=3, y=8, width=2},

        {x=0,y=9,width=6,class="label",label=""}
    }

    local btn, res = ADD(ctr_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_counter_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    if res.rem_ctr then counter_last_res = table.copy(res); counter_remembered = true end

    -- Helper: Interpolação de Cores Hex
    local function hexToRGB(hex)
        hex = hex:gsub("#", "")
        return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
    end
    
    local function interp_color(hex1, hex2, p)
        local r1, g1, b1 = hexToRGB(hex1)
        local r2, g2, b2 = hexToRGB(hex2)
        local r = r1 + (r2 - r1) * p
        local g = g1 + (g2 - g1) * p
        local b = b1 + (b2 - b1) * p
        return string.format("&H%02X%02X%02X&", b, g, r)
    end

    -- Helper: Converte a entrada da GUI (100 ou &H00&) para INT (0-255) permitindo matemática pura
    local function get_hex_int(val)
        local s = tostring(val)
        local hex = s:match("&H(%x%x)&?") or s:match("#(%x%x)") or s:match("^(%x%x)$")
        return tonumber(hex, 16) or 0
    end

    local new_indices = {}
    
    -- Leitura Dinâmica de Resolução X para o Mirror
    local res_x = 1920
    for i = 1, #subs do
        if subs[i].class == "info" and subs[i].key == "PlayResX" then
            res_x = tonumber(subs[i].value)
            break
        end
    end

    -- Blindagem do Alpha: Independente do modo (Intedit ou Alpha), o script roda via Integer 0-255
    local a_s_int, a_e_int
    if tensho_cfg.alpha_100 then
        a_s_int = get_hex_int(pct_to_alpha(res.a_s))
        a_e_int = get_hex_int(pct_to_alpha(res.a_e))
    else
        a_s_int = get_hex_int(res.a_s)
        a_e_int = get_hex_int(res.a_e)
    end
    local alpha_s_hex = string.format("%02X", a_s_int)

    for z = #sel, 1, -1 do
        local idx = sel[z]
        local line = subs[idx]
        local st = line.start_time
        local et = line.end_time
        local dur = (res.dur > 0) and res.dur or (et - st)
        
        -- Limpeza Profunda das Tags Iniciais
        local STAG = "^{\\[^}]-}"
        local initial_tags = line.text:match(STAG) or "{}"
        initial_tags = initial_tags:gsub("\\pos%b()", ""):gsub("\\move%b()", ""):gsub("\\fad%b()", ""):gsub("\\t%b()", ""):gsub("\\an%d", "")
        
        -- Monta as Tags Base (Valores Iniciais da Coluna Direita)
        local base_styles = string.format("\\fs%g\\c%s\\3c%s\\4c%s\\alpha&H%s&", 
            res.fs_s, htmlToAss(res.c1_s), htmlToAss(res.c3_s), htmlToAss(res.c4_s), alpha_s_hex)
        
        if res.use_an5 then initial_tags = initial_tags:gsub("}$", "\\an5}") end
        initial_tags = initial_tags:gsub("}$", base_styles .. string.format("\\pos(%.1f,%.1f)}", res.px, res.py))
        initial_tags = tagmerge(initial_tags)
        
        local offset = 1

        -- Header
        local header_line = table.copy(line)
        header_line.style = res.style_name
        header_line.comment = true
        header_line.effect = "Counter Header"
        header_line.text = string.format(T("ct_header"), res.v_start, res.v_end)
        subs.insert(idx + offset, header_line)
        table.insert(new_indices, idx + offset)
        offset = offset + 1
        
        -- Cálculo de Frames 
        local total_diff = math.abs(res.v_end - res.v_start)
        local max_lines = math.floor(dur / 4)
        if max_lines < 1 then max_lines = 1 end
        
        local desired_lines = total_diff + 1
        local actual_lines = math.min(desired_lines, max_lines)
        local steps = actual_lines - 1
        
        for i = 0, steps do
            local p = (steps > 0) and (i / steps) or 0
            
            -- Interpola o Número Principal
            local cur_val = res.v_start + (res.v_end - res.v_start) * p
            cur_val = math.floor(cur_val + 0.5) 
            
            -- Interpola Tags Visuais Avançadas (Somente se forem diferentes!)
            local dyn_tags = ""
            if res.fs_s ~= res.fs_e then dyn_tags = dyn_tags .. string.format("\\fs%.1f", res.fs_s + (res.fs_e - res.fs_s) * p) end
            if res.c1_s ~= res.c1_e then dyn_tags = dyn_tags .. "\\c" .. interp_color(res.c1_s, res.c1_e, p) end
            if res.c3_s ~= res.c3_e then dyn_tags = dyn_tags .. "\\3c" .. interp_color(res.c3_s, res.c3_e, p) end
            if res.c4_s ~= res.c4_e then dyn_tags = dyn_tags .. "\\4c" .. interp_color(res.c4_s, res.c4_e, p) end
            
            -- Opacidade em Transição
            if a_s_int ~= a_e_int then 
                local current_alpha_int = math.floor(a_s_int + (a_e_int - a_s_int) * p + 0.5)
                dyn_tags = dyn_tags .. string.format("\\alpha&H%02X&", current_alpha_int) 
            end

            local slice_st = st + math.floor(dur * (i / actual_lines))
            local slice_et = st + math.floor(dur * ((i + 1) / actual_lines))
            if i == steps then slice_et = st + dur end
            
            if slice_et > slice_st then
                local final_tags = initial_tags
                if dyn_tags ~= "" then
                    if final_tags:match("}$") then final_tags = final_tags:gsub("}$", dyn_tags .. "}")
                    else final_tags = "{" .. dyn_tags .. "}" .. final_tags end
                end
                
                local nl = table.copy(line)
                nl.style = res.style_name
                nl.start_time = slice_st
                nl.end_time = slice_et
                nl.text = final_tags .. cur_val
                nl.effect = "Counter"
                nl.comment = false
                subs.insert(idx + offset, nl)
                table.insert(new_indices, idx + offset)
                offset = offset + 1

                -- Criação do Mirror
                if res.mirror then
                    local nl_m = table.copy(nl)
                    local mirror_x = res_x - res.px
                    nl_m.text = nl_m.text:gsub("\\pos%([%d%.%-]+,([%d%.%-]+)%)", string.format("\\pos(%.1f,%%1)", mirror_x))
                    subs.insert(idx + offset, nl_m)
                    table.insert(new_indices, idx + offset)
                    offset = offset + 1
                end
            end
        end
    end
    return new_indices
end
