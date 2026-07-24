-- version: 1.0.0
-- Autor: Tenshy & Zahuczky
-- Descrição: Auxilia no rastreamento e gerenciamento de paletas de cores e mapeamento visual de legendas dentro do ambiente de trabalho.

-- Baseado na lógica matemática do "Aegisub-Color-Tracking" original de Zahuczky (https://github.com/Zahuczky/Zahuczkys-Aegisub-Scripts)
function tensho_colortrack_gui(subs, sel, ADD, ADP, ak)
    local first_line = subs[sel[1]]
    -- Tenta pegar a posição da primeira linha como padrão
    local ox, oy = first_line.text:match("\\pos%(([%d%.%-]+),%s*([%d%.%-]+)%)")
    if not ox then ox, oy = 0, 0 end

    local track_gui = {
        {class="label", label=T("trk_title"), x=0, y=0, width=4},
        
        {class="checkbox", name="rem_trk", label=T("rem_last"), value=true, x=0, y=1, width=4},
        
        {class="label", label=T("trk_px"), x=0, y=3},
        {class="intedit", name="pixX", value=math.floor(tonumber(ox)), x=1, y=3},
        {class="label", label=T("trk_py"), x=0, y=4},
        {class="intedit", name="pixY", value=math.floor(tonumber(oy)), x=1, y=4},
        
        {class="label", label=T("trk_apply"), x=0, y=5},
        {class="checkbox", name="c1", label=T("trk_c1"), value=true, x=1, y=5},
        {class="checkbox", name="c2", label=T("trk_c2"), value=false, x=2, y=5},
        {class="checkbox", name="c3", label=T("trk_c3"), value=false, x=1, y=6},
        {class="checkbox", name="c4", label=T("trk_c4"), value=false, x=2, y=6},

        {x=0,y=7,width=6,class="label",label=""}
    }
    
    if track_remembered and track_last_res and track_last_res.rem_trk then 
        for _, control in ipairs(track_gui) do
            if control.name and track_last_res[control.name] ~= nil then control.value = track_last_res[control.name] end
        end
    end

    local btn, res = ADD(track_gui, {T("btn_apply"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if btn == T("btn_back") then return "BACK" end
    if btn == T("btn_help") then abrir_help(); return tensho_colortrack_gui(subs, sel, ADD, ADP, ak) end
    if btn ~= T("btn_apply") then if ak then ak() else aegisub.cancel() end return sel end
    
    if res.rem_trk then track_last_res = res; track_remembered = true end
    
    local function getFrames(line)
        local startFrame = aegisub.frame_from_ms(line.start_time)
        local endFrame = aegisub.frame_from_ms(line.end_time)
        return startFrame, endFrame, endFrame - startFrame
    end

    local function formatTimesFfmpeg(startMS, endMS)
        local function fmt(ms)
            local s = math.floor(ms / 1000)
            local m = math.floor(s / 60)
            local h = math.floor(m / 60)
            s = s % 60
            m = m % 60
            local rem = ms - (1000 * (s + 60 * (m + 60 * h)))
            if ms <= 0 then return "0:00:00" end
            return string.format("%d:%02d:%02d.%03d", h, m, s, rem)
        end
        return fmt(startMS), fmt(endMS)
    end

    local function getColors(startFrame, endFrame, numOfFrames, pX, pY)
        local colors = {}
        if aegisub.get_frame then
            for i=1, numOfFrames do
                local frame = aegisub.get_frame((startFrame + i-1), false)
                colors[i] = frame:getPixelFormatted(pX, pY)
                aegisub.progress.set((i/numOfFrames)*100)
                aegisub.progress.task(string.format(T("trk_prog"), i, numOfFrames))
            end
            return colors
        else
            local ffmpegStart, ffmpegEnd = formatTimesFfmpeg(aegisub.ms_from_frame(startFrame), aegisub.ms_from_frame(endFrame))
            local pixpath = aegisub.decode_path("?temp/tensho_color.pixels")
            local video_path = aegisub.project_properties().video_file
            
            if video_path == "" then
                aegisub.log(T("trk_err_vid"))
                aegisub.cancel()
            end
            
            local filter = 'crop=2:2:' .. pX .. ":" .. pY
            local cmd = string.format('ffmpeg -i "%s" -ss %s -to %s -filter:v "%s" -f rawvideo -pix_fmt rgb24 "%s" -y', video_path, ffmpegStart, ffmpegEnd, filter, pixpath)
            
            os.execute(cmd)
            
            local pixfile = io.open(pixpath, "rb")
            if not pixfile then
                aegisub.log(T("trk_err_ff"))
                aegisub.cancel()
            end
            local pixels = pixfile:read("*a")
            pixfile:close()
            
            for i = 0, numOfFrames - 1 do
                local offset = i * 12
                local r = pixels:byte(1 + offset) or 0
                local g = pixels:byte(2 + offset) or 0
                local b = pixels:byte(3 + offset) or 0
                table.insert(colors, string.format("&H%02X%02X%02X&", b, g, r))
            end
            os.remove(pixpath)
            return colors
        end
    end

    for z = 1, #sel do
        local idx = sel[z]
        local line = subs[idx]
        
        local startFrame, endFrame, numOfFrames = getFrames(line)
        local colors = getColors(startFrame, endFrame, numOfFrames, res.pixX, res.pixY)
        
        local t_start_time = aegisub.ms_from_frame(startFrame)
        local function makeTransformTimes(i)
            local ft = aegisub.ms_from_frame(startFrame + i) - t_start_time
            return ft .. "," .. ft .. ","
        end

        local transform = ""
        if colors[1] then
            if res.c1 then transform = transform .. "\\c" .. colors[1] end
            if res.c2 then transform = transform .. "\\2c" .. colors[1] end
            if res.c3 then transform = transform .. "\\3c" .. colors[1] end
            if res.c4 then transform = transform .. "\\4c" .. colors[1] end
        end
        
        for i=2, numOfFrames do
            local color = colors[i]
            if color then
                transform = transform .. "\\t(" .. makeTransformTimes(i-1)
                if res.c1 then transform = transform .. "\\c" .. color end
                if res.c2 then transform = transform .. "\\2c" .. color end
                if res.c3 then transform = transform .. "\\3c" .. color end
                if res.c4 then transform = transform .. "\\4c" .. color end
                transform = transform .. ")"
            end
        end
        
        local clean_text = line.text
        if res.c1 then clean_text = clean_text:gsub("\\[1]?c&H[%x]+&?", "") end
        if res.c2 then clean_text = clean_text:gsub("\\2c&H[%x]+&?", "") end
        if res.c3 then clean_text = clean_text:gsub("\\3c&H[%x]+&?", "") end
        if res.c4 then clean_text = clean_text:gsub("\\4c&H[%x]+&?", "") end
        
        if clean_text:match("^{") then
            line.text = clean_text:gsub("^{", "{" .. transform)
        else
            line.text = "{" .. transform .. "}" .. clean_text
        end
        
        subs[idx] = line
    end
    
    return sel
end
