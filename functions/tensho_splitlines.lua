-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Divide linhas longas de legenda em partes menores de forma inteligente, mantendo o limite ideal de caracteres por segundo (CPS) e legibilidade.

function tensho_splitlines_gui(subs, sel, ADD, ADP, ak)
    local split_gui = {
        {class="label", label=T("sp_title"), x=0, y=0, width=2},
        {class="label", label=T("sp_mode"), x=0, y=1},
        {class="dropdown", name="mode", items={T("sp_char"), T("sp_word")}, value=T("sp_char"), x=1, y=1, width=6},
    }

    local btn, res_s = ADD(split_gui, {T("btn_split"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_split"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_splitlines_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_split") then return sel end

    local new_subs_indices = {}
    
    for i = #sel, 1, -1 do
        local idx = sel[i]
        local line = subs[idx]
        local style = stylechk(subs, line.style)
        if not style then goto next_split end

        -- 1. TOKENIZAÇÃO (Mantém tags e caracteres)
        local STAG = "^{\\[^}]-}"
        local initial_tags = line.text:match(STAG) or ""
        local text_to_process = line.text:gsub(STAG, ""):gsub("\\N", " ")
        
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
                    table.insert(tokens, {char = char_match[1].str, tags = current_tags})
                    current_tags = ""
                    temp_text = temp_text:sub(char_match[1].last + 1)
                else temp_text = "" end
            end
        end

        -- 2. CALCULO DE POSIÇÃO
        local orig_x, orig_y = line.text:match("\\pos%(([%d%.%-]+),([%d%.%-]+)%)")
        if not orig_x then orig_x, orig_y = style.margin_l, style.margin_v end -- Fallback
        orig_x, orig_y = tonumber(orig_x), tonumber(orig_y)
        local align = tonumber(line.text:match("\\an(%d)") or line.text:match("\\an(%d)") or style.align)
        
        -- Calculamos a largura total para alinhar o início
        local text_clean = text_to_process:gsub("{[^}]*}", "")
        local total_w = aegisub.text_extents(style, text_clean)
        local start_x = (align % 3 == 1) and orig_x or (align % 3 == 2) and (orig_x - total_w / 2) or (orig_x - total_w)

        -- 3. SPLIT POR CARACTERE OU PALAVRA
        local elements = {}
        if res_s.mode == T("sp_char") then
            for _, t in ipairs(tokens) do table.insert(elements, {t}) end
        else
            local buffer = {}
            for _, t in ipairs(tokens) do
                table.insert(buffer, t)
                if t.char:match("%s") then
                    table.insert(elements, buffer); buffer = {}
                end
            end
            if #buffer > 0 then table.insert(elements, buffer) end
        end

        -- 4. CRIAÇÃO DAS NOVAS LINHAS
        local current_x_offset = 0
        local inserted_count = 0

        -- Limpa o POS original das tags iniciais para não conflitar
        local clean_initial = initial_tags:gsub("\\pos%([^%)]-%)", "")

        for _, group in ipairs(elements) do
            local group_text = ""
            -- RECONSTRUÇÃO CORRETA: Mantemos as tags coladas em cada caractere
            local group_content = ""
            for _, t in ipairs(group) do 
                group_content = group_content .. t.tags .. t.char 
                group_text = group_text .. t.char
            end
            
            local group_w = aegisub.text_extents(style, group_text)
            if group_w == 0 then group_w = (style.fontsize * 0.6) * #group_text end 
            
            local posX
            if align % 3 == 1 then posX = start_x + current_x_offset
            elseif align % 3 == 2 then posX = start_x + current_x_offset + (group_w / 2)
            else posX = start_x + current_x_offset + group_w end
            
            local new_line = table.copy(line)
            
            -- O segredo: unimos as tags iniciais + a posição + o conteúdo que já tem as tags de gradiente intercaladas
            new_line.text = string.format("%s{\\pos(%.1f,%.1f)}%s", clean_initial, posX, orig_y, group_content)
            new_line.effect = "Split"
            
            subs.insert(idx + inserted_count + 1, new_line)
            table.insert(new_subs_indices, idx + inserted_count + 1)
            inserted_count = inserted_count + 1
            
            current_x_offset = current_x_offset + group_w
        end

        line.comment = true
        subs[idx] = line
        ::next_split::
    end
    return new_subs_indices
end
