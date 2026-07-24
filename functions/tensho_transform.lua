-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Cria transformações complexas (\t) automatizadas de posição, escala, rotação e cor sem que você precise digitar os códigos manualmente.

function tensho_transform_gui(subs, sel, ADD, ADP, ak)
    local first_line = subs[sel[1]]
    local default_dur = first_line.end_time - first_line.start_time

    stylechk(subs, first_line.style)
    local def_fs_from = first_line.text:match("\\fs([%d%.]+)") or styleval("\\fs")
    local def_alpha_from = first_line.text:match("\\alpha(&H%x+&)") or styleval("\\alpha")
    
    local val_alpha_from = def_alpha_from
    local val_alpha_to = "&HFF&"
    local class_alpha = "alpha"

    if tensho_cfg.alpha_100 then
        class_alpha = "intedit"
        val_alpha_from = alpha_to_pct(def_alpha_from)
        val_alpha_to = 0
    end

    local trans_gui = {
        {class="label", label=T("tr_title"), x=0, y=0, width=6},
        {class="checkbox", name="rem_transform", label=T("rem_last"), value=true, x=0, y=1, width=2},
        
        {class="label", label=T("tr_st"), x=0, y=2},
        {class="intedit", name="t_start", value=0, x=1, y=2},
        {class="label", label=T("tr_et"), x=0, y=3},
        {class="intedit", name="t_end", value=default_dur, x=1, y=3},
        
        {x=0,y=5,width=6,class="label",label=T("tr_targ")},
        
        {class="checkbox", name="use_c1", label=T("tr_prim"), x=0, y=6},
        {class="color", name="c1", value="#FFFFFF", x=1, y=6},
        {class="checkbox", name="use_c2", label=T("tr_sec"), x=0, y=7},
        {class="color", name="c2", value="#FFFFFF", x=1, y=7},
        {class="checkbox", name="use_c3", label=T("tr_bord"), x=0, y=8},
        {class="color", name="c3", value="#000000", x=1, y=8},
        {class="checkbox", name="use_c4", label=T("tr_shad"), x=0, y=9},
        {class="color", name="c4", value="#000000", x=1, y=9},

        {x=0,y=11,width=6,class="label",label=T("tr_sizealf")},

        {class="checkbox", name="use_fs", label=T("tr_size"), x=0, y=12},
        {class="floatedit", name="fs_from", value=tonumber(def_fs_from), x=1, y=12},
        {class="label", label=T("tr_to"), x=2, y=12},
        {class="floatedit", name="fs_to", value=80, x=3, y=12},

        {class="checkbox", name="use_alpha", label=T("tr_alf"), x=0, y=13},
        {class=class_alpha, name="alpha_from", value=val_alpha_from, min=0, max=100, x=1, y=13},
        {class="label", label=T("tr_to"), x=2, y=13},
        {class=class_alpha, name="alpha_to", value=val_alpha_to, min=0, max=100, x=3, y=13},

        {x=0,y=14,width=6,class="label",label=""} 
    }

    if transform_remembered and transform_last_res and transform_last_res.rem_transform then 
        for _, control in ipairs(trans_gui) do
            if control.name and transform_last_res[control.name] ~= nil then 
                 control.value = transform_last_res[control.name] 
            end
        end
    end

    local btn, res_t = ADD(trans_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_transform_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    if res_t.rem_transform then transform_last_res = res_t; transform_remembered = true end

    for z, idx in ipairs(sel) do
        local line = subs[idx]
        local start_tags = ""
        local trans_tags = "" 

        if res_t.use_c1 then trans_tags = trans_tags .. "\\1c" .. res_t.c1:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") end
        if res_t.use_c2 then trans_tags = trans_tags .. "\\2c" .. res_t.c2:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") end
        if res_t.use_c3 then trans_tags = trans_tags .. "\\3c" .. res_t.c3:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") end
        if res_t.use_c4 then trans_tags = trans_tags .. "\\4c" .. res_t.c4:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") end
        
        if res_t.use_fs then 
            start_tags = start_tags .. string.format("\\fs%.1f", res_t.fs_from)
            trans_tags = trans_tags .. string.format("\\fs%.1f", res_t.fs_to)
        end
        
        if res_t.use_alpha then 
            -- Usa a função apenas se o modo 100% estiver ativo. Se não, usa o que o Aegisub gerou.
            local final_alpha_from = tensho_cfg.alpha_100 and pct_to_alpha(res_t.alpha_from) or res_t.alpha_from
            local final_alpha_to = tensho_cfg.alpha_100 and pct_to_alpha(res_t.alpha_to) or res_t.alpha_to

            start_tags = start_tags .. "\\alpha" .. final_alpha_from
            trans_tags = trans_tags .. "\\alpha" .. final_alpha_to
        end

        if trans_tags ~= "" then
            local transform_final = string.format("%s\\t(%d,%d,%s)", start_tags, res_t.t_start, res_t.t_end, trans_tags)
            
            if line.text:match("{\\") then
                -- Removendo o ^, aplicamos o Transform em TODOS os blocos da linha
                line.text = line.text:gsub("({[^}]-)}", "%1" .. transform_final .. "}")
            else
                line.text = "{" .. transform_final .. "}" .. line.text
            end
            line.text = tagmerge(line.text)
        end
        
        subs[idx] = line
    end
    return sel
end
