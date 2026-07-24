-- version: 1.0.0
-- Autor: Tenshy
-- Descrição: Ferramenta focada em animações e efeitos de fade inspirados no estilo tradicional de karaokês do YouTube.

function tensho_ytkt_fade_gui(subs, sel, ADD, ADP, ak)
    local ytkt_gui = {
        {class="label", label=T("yk_title"), x=0, y=0, width=2},
        {class="label", x=0, y=1, width=1, label="" },
        {class="checkbox", name="add_2c", label=T("yk_add"), value=false, x=0, y=2},
        {class="color", name="color_2c", value="&HFFFFFF&", x=1, y=2},
        {class="label", x=0, y=3, width=1, label="" }
    }

    local btn, res_y = ADD(ytkt_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_ytkt_fade_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end

    for z, idx in ipairs(sel) do
        aegisub.progress.set(100 * z / #sel)
        local line = subs[idx]
        local text = line.text

        text = text:gsub("\\ytktFade", ""):gsub("\\2a&H%x+&", "")
        
        if res_y.add_2c then
            text = text:gsub("\\2c&H%x+&", "")
        end

        local ytkt_tags = "\\ytktFade\\2a&HFF&"
        if res_y.add_2c then
            local c2 = res_y.color_2c:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&")
            ytkt_tags = ytkt_tags .. "\\2c" .. c2
        end

        if text:match("^{") then
            text = text:gsub("^{", "{" .. ytkt_tags)
        else
            text = "{" .. ytkt_tags .. "}" .. text
        end

        line.text = tagmerge(text):gsub("{}","")
        subs[idx] = line
    end

    return sel
end
