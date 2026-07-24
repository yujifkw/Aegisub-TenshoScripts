-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Adiciona efeitos de trepidação, vibração ou tremor de câmera (camera shake) nas coordenadas da legenda para cenas de ação.

function tensho_shake_gui(subs, sel, ADD, ADP, ak)
    local sk_gui = {
        {class="label", label=T("sk_title"), x=0, y=0, width=4},
        
        {class="checkbox", name="rem_sk", label=T("rem_last"), value=true, x=0, y=1, width=4},
        
        {class="label", label=T("sk_varx"), x=0, y=3},
        {class="intedit", name="amp_x", value=10, x=1, y=3},
        {class="label", label=T("sk_vary"), x=2, y=3},
        {class="intedit", name="amp_y", value=10, x=3, y=3},
        
        {class="label", label=T("sk_dur"), x=0, y=4},
        {class="intedit", name="duration", value=280, x=1, y=4},
        {class="label", label=T("sk_type"), x=2, y=4},
        {class="dropdown", name="type", items={T("sk_start"), T("sk_end"), T("sk_both"), T("sk_always")}, value=T("sk_start"), x=3, y=4},
        
        {class="label", label=T("sk_int"), x=0, y=5},
        {class="intedit", name="interval", value=40, min=10, x=1, y=5},
        {class="checkbox", name="force_orig", label=T("sk_edge"), value=true, x=2, y=5, width=2},

        {x=0,y=6,width=6,class="label",label=""}
    }
    
    if shake_remembered and shake_last_res and shake_last_res.rem_sk then 
        for _, control in ipairs(sk_gui) do
            if control.name and shake_last_res[control.name] ~= nil then control.value = shake_last_res[control.name] end
        end
    end

    local btn, res = ADD(sk_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_shake_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    if res.rem_sk then shake_last_res = res; shake_remembered = true end

    -- FUNÇÃO DE CORREÇÃO DE TEMPO PARA \t E \fad
    local function adjust_transforms(text, current_rel_ms, total_dur)
        return text:gsub("\\t%(([^%)]+)%)", function(inner)
            local t1, t2, accel, tags = inner:match("^([%d%.%-]+),%s*([%d%.%-]+),%s*([%d%.%-]+),%s*(.+)$")
            if not t1 then
                t1, t2, tags = inner:match("^([%d%.%-]+),%s*([%d%.%-]+),%s*(.+)$")
                accel = "1"
            end
            if not t1 then
                accel, tags = inner:match("^([%d%.%-]+),%s*(.+)$")
                if accel and tags then t1, t2 = 0, total_dur end
            end
            if not t1 then
                tags = inner
                t1, t2, accel = 0, total_dur, 1
            end
            
            if t1 and t2 and tags then
                local new_t1 = tonumber(t1) - current_rel_ms
                local new_t2 = tonumber(t2) - current_rel_ms
                return string.format("\\t(%d,%d,%s,%s)", math.floor(new_t1), math.floor(new_t2), accel, tags)
            end
            return "\\t(" .. inner .. ")" 
        end)
    end

    local new_indices = {}
    for z = #sel, 1, -1 do
        local idx = sel[z]
        local line = subs[idx]
        
        if not line.text:match("\\pos") and not line.text:match("\\move") then
            line.text = getpos(subs, line)
        end
        
        local st, et = line.start_time, line.end_time
        local dur = et - st
        
        local mx1, my1, mx2, my2 = line.text:match("\\move%(([%d%.%-]+),%s*([%d%.%-]+),%s*([%d%.%-]+),%s*([%d%.%-]+).*%)")
        local px, py = line.text:match("\\pos%(([%d%.%-]+),%s*([%d%.%-]+)%)")
        
        if px and not mx1 then
            mx1, my1 = tonumber(px), tonumber(py)
            mx2, my2 = mx1, my1
        elseif mx1 then
            mx1, my1, mx2, my2 = tonumber(mx1), tonumber(my1), tonumber(mx2), tonumber(my2)
        end
        
        if mx1 then
            local base_text = line.text

            -- 1. CONVERSÃO INTELIGENTE DO \fad PARA \t
            local fad_in, fad_out = base_text:match("\\fad%(([%d%.]+),%s*([%d%.]+)%)")
            if fad_in then
                fad_in, fad_out = tonumber(fad_in), tonumber(fad_out)
                base_text = base_text:gsub("\\fad%([^%)]-%)", "")
                
                local existing_alpha = base_text:match("\\alpha(&H%x+&)") or "&H00&"
                
                local fade_tags = ""
                if fad_in > 0 then
                    fade_tags = fade_tags .. string.format("\\alpha&HFF&\\t(0,%d,\\alpha%s)", fad_in, existing_alpha)
                end
                if fad_out > 0 then
                    fade_tags = fade_tags .. string.format("\\t(%d,%d,\\alpha&HFF&)", dur - fad_out, dur)
                end
                
                if base_text:match("^{") then base_text = base_text:gsub("^{", "{" .. fade_tags)
                else base_text = "{" .. fade_tags .. "}" .. base_text end
            end

            -- 2. LIMPEZA
            local clean_text = base_text:gsub("\\pos%([^%)]-%)", ""):gsub("\\move%([^%)]-%)", "")
            clean_text = tagmerge(clean_text)
            
            local offset = 1
            local t = st
            
            -- 3. LAÇO OTIMIZADO
            while t < et do
                local current_rel_ms = t - st
                local is_shaking = false
                
                if res.type == T("sk_always") then
                    is_shaking = true
                elseif res.type == T("sk_start") then
                    is_shaking = (current_rel_ms < res.duration)
                elseif res.type == T("sk_end") then
                    is_shaking = (current_rel_ms >= dur - res.duration)
                elseif res.type == T("sk_both") then
                    is_shaking = (current_rel_ms < res.duration) or (current_rel_ms >= dur - res.duration)
                end
                
                local slice_end
                
                if is_shaking then
                    slice_end = math.min(t + res.interval, et)
                    if (res.type == T("sk_start") or res.type == T("sk_both")) and current_rel_ms < res.duration then
                        slice_end = math.min(slice_end, st + res.duration)
                    end
                else
                    if res.type == T("sk_start") then
                        slice_end = et
                    elseif res.type == T("sk_end") then
                        slice_end = math.max(t + 1, st + dur - res.duration)
                    elseif res.type == T("sk_both") then
                        if current_rel_ms >= res.duration and current_rel_ms < dur - res.duration then
                            slice_end = math.max(t + 1, st + dur - res.duration)
                        else
                            slice_end = et
                        end
                    else
                        slice_end = et
                    end
                end
                
                local dx, dy = 0, 0
                if is_shaking then
                    local is_edge = (res.force_orig and (t == st or slice_end == et))
                    if not is_edge then
                        if res.amp_x > 0 then dx = math.random(-res.amp_x, res.amp_x) end
                        if res.amp_y > 0 then dy = math.random(-res.amp_y, res.amp_y) end
                    end
                end
                
                local t_factor_start = current_rel_ms / dur
                local cur_x = mx1 + (mx2 - mx1) * t_factor_start + dx
                local cur_y = my1 + (my2 - my1) * t_factor_start + dy
                
                -- MAGIA DO MOVIMENTO: Define se vai usar \pos (tremores e fixos) ou \move (para continuar deslizando)
                local tag_to_inject = ""
                if is_shaking or (mx1 == mx2 and my1 == my2) then
                    tag_to_inject = string.format("\\pos(%.1f,%.1f)", cur_x, cur_y)
                else
                    local t_factor_end = (slice_end - st) / dur
                    local end_x = mx1 + (mx2 - mx1) * t_factor_end
                    local end_y = my1 + (my2 - my1) * t_factor_end
                    tag_to_inject = string.format("\\move(%.1f,%.1f,%.1f,%.1f)", cur_x, cur_y, end_x, end_y)
                end
                
                local nl = table.copy(line)
                nl.start_time = t
                nl.end_time = slice_end
                nl.effect = is_shaking and "Shake" or "Shake (Static)"
                nl.comment = false
                
                local adjusted_text = adjust_transforms(clean_text, current_rel_ms, dur)
                
                if adjusted_text:match("^{") then
                    nl.text = adjusted_text:gsub("^{", "{" .. tag_to_inject)
                else
                    nl.text = "{" .. tag_to_inject .. "}" .. adjusted_text
                end
                
                subs.insert(idx + offset, nl)
                table.insert(new_indices, idx + offset)
                offset = offset + 1
                
                t = slice_end
            end
            
            line.comment = true
            subs[idx] = line
        else
            aegisub.log("Linha " .. idx .. " ignorada: Sem coordenadas.\n")
        end
    end
    return new_indices
end
