-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Utilitário para correção e limpeza automática de erros comuns em linhas de legendas (como quebras de linha incorretas, espaços duplos e pontuação duplicada).

function tensho_fixlines_gui(subs, sel, ADD, ADP, ak)
    if not resx or not resy or resx == 0 or resy == 0 then
        for i = 1, #subs do
            if subs[i].class == "info" then
                if subs[i].key == "PlayResX" then resx = tonumber(subs[i].value) end
                if subs[i].key == "PlayResY" then ry = tonumber(subs[i].value) end
            end
        end
    end
    resx = resx or 1920; resy = resy or 1080

    local ref_line = nil
    for _, idx in ipairs(sel) do
        if subs[idx].effect == "Original" then
            ref_line = table.copy(subs[idx])
            break
        end
    end
    if not ref_line then ref_line = table.copy(subs[sel[1]]) end
    
    if not ref_line.text:match("\\pos") then ref_line.text = getpos(subs, ref_line) end
    local ref_x, ref_y = ref_line.text:match("\\pos%(([%d%.%-]+),([%d%.%-]+)%)")
    ref_x, ref_y = tonumber(ref_x) or (resx/2), tonumber(ref_y) or (resy-50)

    local fix_gui = {
        {class="label", label=T("fx_title"), x=0, y=0, width=2},
        {class="checkbox", name="force_an5", label=T("fx_force"), value=false, x=0, y=2, width=2},
        {class="label", label=T("fx_newx"), x=0, y=3},
        {class="floatedit", name="target_x", value=ref_x, x=1, y=3},
        {class="label", label=T("fx_newy"), x=0, y=4},
        {class="floatedit", name="target_y", value=ref_y, x=1, y=4},
        {class="label", label=T("fx_ref") .. " ("..ref_x..", "..ref_y..")", x=0, y=5, width=6},
        {class="label", x=0, y=6, width=1, label="" }
    }

    local btn_f, res_f = ADD(fix_gui, {T("btn_pos"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_pos"), cancel=T("btn_cancel")})
    if btn_f == T("btn_back") then return "BACK" end
    if btn_f == T("btn_help") then abrir_help(); return tensho_fixlines_gui(subs, sel, ADD, ADP, ak) end
    if btn_f ~= T("btn_pos") then return sel end

    local dx = res_f.target_x - ref_x
    local dy = res_f.target_y - ref_y

    for _, idx in ipairs(sel) do
        local line = subs[idx]
        local text = line.text
        
        if not text:match("\\pos") then text = getpos(subs, line) end
        local curr_x, curr_y = text:match("\\pos%(([%d%.%-]+),([%d%.%-]+)%)")
        curr_x, curr_y = tonumber(curr_x), tonumber(curr_y)
        
        local new_x = curr_x + dx
        local new_y = curr_y + dy
        
        if res_f.force_an5 then text = text:gsub("\\an%d", "") end
        text = text:gsub("\\pos%b()", "")
        
        local an_tag = res_f.force_an5 and "\\an5" or ""
        local fix_tag = string.format("%s\\pos(%.1f,%.1f)", an_tag, new_x, new_y)
        
        if text:match("^{\\") then
            text = text:gsub("^({\\[^}]-)}", "%1" .. fix_tag .. "}")
        else
            text = "{" .. fix_tag .. "}" .. text
        end

        line.text = tagmerge(text)
        subs[idx] = line
    end
    return sel
end
