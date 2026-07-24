-- version: 1.0.0

STAG = "^{\\[^}]-}" -- Tag de início de linha
ATAG="{[*>]?\\[^}]-}" -- Qualquer tag

-- Variáveis globais FadeWorks
fadin, fadout, rep, faded, res = nil, nil, nil, nil, nil
line0 = nil
TAGS = nil
sr = nil
styleref = nil
vt, vframe = nil, nil
P = nil
resx, resy = nil, nil
fr2ms, ms2fr = nil, nil
mirrors = nil
last_tool_selected = T("tool_fade")

-- Remember Last [Free]
gradient_last_res = nil
gradient_remembered = false
transform_last_res = nil
transform_remembered = false
randomfont_last_res = nil
randomfont_remembered = false
flashes_last_res = nil
flashes_remembered = false
counter_last_res = nil
counter_remembered = false
shake_last_res = nil
shake_remembered = false
track_last_res = nil
track_remembered = false

-- Remember Last [Paid]
glitch_last_res = nil
glitch_remembered = false
rainbow_last_res = nil
rainbow_remembered = false
curves_last_res = nil
curves_remembered = false
karafx_last_res = nil
karafx_remembered = false

tensho_glitch_logic = nil
tensho_curves_logic = nil
tensho_rainbow_logic = nil
tensho_reversek_logic = nil
tensho_tradutor_logic = nil
tensho_tradutor_nuvem = nil

help_url = "https://github.com/yujifkw/TenshoScripts/blob/main/HELP.md"

function abrir_help()
    os.execute('start "" "' .. help_url .. '"')
end

-- ==================================================================================================================================
-- Seção de Funções ua.FadeWorks.lua
-- ==================================================================================================================================

function esc(str) 
    if type(str) ~= "string" then return "" end
    str=str:gsub("[%%%(%)%[%]%.%-%+%*%?%^%$]","%%%1") return str 
end

function round(n,dec) 
    if type(n) ~= "number" then return n end
    dec=dec or 0 
    local mult = 10^dec
    return math.floor(n*mult+0.5)/mult 
end

function wrap(str) return "{"..str.."}" end 

function par(tab) return '('..table.concat(tab,',')..')' end 

function detra(t) 
    if type(t) ~= "string" then return "" end
    return t:gsub("\\t%b()","") 
end 

function nobra(t) 
    if type(t) ~= "string" then return "" end
    return t:gsub("%b{}","") 
end 

function nobrea(t) 
    if type(t) ~= "string" then return "" end
    return t:gsub("%b{}",""):gsub("\\[Nh]","") 
end 

function nobrea1(t) 
    if type(t) ~= "string" then return "" end
    return t:gsub("%b{}",""):gsub(" *\\[Nh] *"," ") 
end 

function tagmerge(t) 
    if type(t) ~= "string" then return "" end
    local r = 0
    repeat 
        t,r=t:gsub("({\\[^}]-)}{(\\[^}]-})","%1%2") 
    until r==0 
    t = t:gsub("{}","")
    return t 
end 

function logg(m) m=tf(m) or "nil" aegisub.log("\n "..m) end 

function loggtab(m) 
    if type(m) == "table" then
        aegisub.log("\n {"..table.concat(m,';').."}") 
    else
        logg(m)
    end
end 

function t_error(message, cancel) 
    aegisub.dialog.display({{class="label",label=message}},{"OK"},{close='OK'}) 
    if cancel then 
        aegisub.cancel()
    end 
end

function addtag1(tg,txt) 
    if not txt:match("^{\\") then txt="{"..tg.."}"..txt
	elseif txt:match("^{[^}]-\\t") then txt=txt:gsub("^({[^}]-)\\t","%1"..tg.."\\t")
	else txt=txt:gsub("^({\\[^}]-)}","%1"..tg.."}") end
	return txt
end

function addtag3(tg,txt)
	if type(tg) ~= "string" or type(txt) ~= "string" then return txt or "" end
    local no_tf=txt:gsub("\\t%b()","")
	local tgt=tg:match("(\\%d?%a+)[%d%-&]") 
    local val="[%d%-&]"
	if not tgt then 
        tgt=tg:match("(\\%d?%a+)%b()") 
        val="%b()" 
    end
	if not tgt then 
        tgt=tg:match("(\\fn)")
        val="[^\\}]*"
        if not tgt then tgt=tg:match("(\\%d?%a+)") val="[^\\}]*" end
    end 
	if not tgt then 
        logg("AVISO addtag3: Não foi possível determinar o tipo de tag para '"..tg.."'")
        return txt
    end 
    
    local pattern_base = esc(tgt) .. val .. "[^\\}]*"
    local pattern_start = "^({[^}]-)"

	if tgt:match("clip") then 
        local r
        txt,r=txt:gsub("^({[^}]-)\\i?clip%b()","%1"..tg)
		if r==0 then txt=txt:gsub("^({\\[^}]-)}","%1"..tg.."}") end
	elseif no_tf:match(pattern_start..pattern_base) then 
        txt=txt:gsub(pattern_start..pattern_base,"%1"..tg)
	elseif not txt:match("^{\\") then 
        txt="{"..tg.."}"..txt
	elseif txt:match("^{[^}]-\\t") then 
        txt=txt:gsub("^({[^}]-)\\t","%1"..tg.."\\t")
	else 
        txt=txt:gsub("^({\\[^}]-)}","%1"..tg.."}") 
    end
    return txt
end

function styleval(tag)
    if not styleref then return "0" end
	local s_val = "0"
    if tag=="\\bord" then s_val=styleref.outline
	elseif tag=="\\shad" then s_val=styleref.shadow
	elseif tag=="\\fscx" then s_val=styleref.scale_x
	elseif tag=="\\fscy" then s_val=styleref.scale_y
	elseif tag=="\\fs" then s_val=styleref.fontsize
	elseif tag=="\\fsp" then s_val=styleref.spacing
	elseif tag=="\\frz" then s_val=styleref.angle
    elseif tag=="\\alpha" then s_val="&H00&"
	elseif tag=="\\1a" then s_val="&H".. (styleref.color1:match("H(%x%x)") or "00") .."&"
	elseif tag=="\\2a" then s_val="&H".. (styleref.color2:match("H(%x%x)") or "00") .."&"
	elseif tag=="\\3a" then s_val="&H".. (styleref.color3:match("H(%x%x)") or "00") .."&"
	elseif tag=="\\4a" then s_val="&H".. (styleref.color4:match("H(%x%x)") or "00") .."&"
	elseif tag=="\\c" then s_val=styleref.color1:gsub("H%x%x","H") or "&H000000&"
	elseif tag=="\\2c" then s_val=styleref.color2:gsub("H%x%x","H") or "&H000000&"
	elseif tag=="\\3c" then s_val=styleref.color3:gsub("H%x%x","H") or "&H000000&"
	elseif tag=="\\4c" then s_val=styleref.color4:gsub("H%x%x","H") or "&H000000&"
	end
	return tostring(s_val)
end

function duplikill(tagz)
	if type(tagz) ~= "string" then return "" end
    local tags1={"blur","be","bord","shad","xbord","xshad","ybord","yshad","fs","fsp","fscx","fscy","frz","frx","fry","fax","fay"}
	local tags2={"c","2c","3c","4c","1a","2a","3a","4a","alpha"}
    local c
	tagz=tagz:gsub("\\t%b()",function(t) return t:gsub("\\","|") end)
	for i=1,#tags1 do
	    local tag=tags1[i]
	    repeat tagz,c=tagz:gsub("|"..esc(tag).."[%d%.%-]+([^}]-)(\\"..esc(tag).."[%d%.%-]+)","%1%2") until c==0
	    repeat tagz,c=tagz:gsub("(\\"..esc(tag).."[%d%.%-]+)([^}]-)(\\"..esc(tag).."[%d%.%-]+)","%3%2") until c==0
	end
	tagz=tagz:gsub("\\1c&","\\c&")
	for i=1,#tags2 do
	    local tag=tags2[i]
	    repeat tagz,c=tagz:gsub("|"..esc(tag).."&H%x+&([^}]-)(\\"..esc(tag).."&H%x+&)","%1%2") until c==0
	    repeat tagz,c=tagz:gsub("(\\"..esc(tag).."&H%x+&)([^}]-)(\\"..esc(tag).."&H%x+&)","%3%2") until c==0
	end
	repeat tagz,c=tagz:gsub("(\\fn[^\\}]+)([^}]-)(\\fn[^\\}]+)","%3%2") until c==0
	repeat tagz,c=tagz:gsub("(\\[ibusq])%d(.-)(%1%d)","%3%2") until c==0
	repeat tagz,c=tagz:gsub("(\\an)%d(.-)(%1%d)","%3%2") until c==0
	repeat tagz,c=tagz:gsub("(|i?clip%([^%)]-%))(.-)(\\i?clip%([^%)]-%))","%3%2") until c==0
	
    local clips = {}
    for clip_tag in tagz:gmatch("(\\i?clip%b())") do table.insert(clips, clip_tag) end
    if #clips > 1 then
        tagz = tagz:gsub("(\\i?clip%b())", "")
        tagz = tagz:gsub("}$", clips[#clips] .. "}")
    end

	tagz=tagz:gsub("|","\\"):gsub("\\t%([^\\%)]-%)","")
	return tagz
end

function times(line)
	local st=line.start_time
	local et=line.end_time
	local dur=et-st
	return st,et,dur
end

function tohex(num)
    num = tonumber(num)
    if not num then return "00" end
    num = math.max(0, math.min(255, round(num)))
	local n1=math.floor(num/16)
	local n2=math.floor(num%16)
	return tohex1(n1)..tohex1(n2)
end

function tohex1(num)
    if type(num) ~= "number" then return "0" end
	local HEX={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
	num = math.floor(num)
    if num < 0 then num = 0 end
    if num > 15 then num = 15 end
    return HEX[num+1]
end

function numgrad(V1,V2,total,l,acc)
    V1, V2, total, l = tonumber(V1), tonumber(V2), tonumber(total), tonumber(l)
    if not V1 or not V2 or not total or not l then return V1 or 0 end
	acc=tonumber(acc) or 1
    if total <= 1 then return V1 end
	local acc_fac=(l-1)^acc/(total-1)^acc
    acc_fac = math.max(0, math.min(1, acc_fac))
	local VC=acc_fac*(V2-V1)+V1
    return round(VC,2)
end

function acgrad(C1,C2,total,l,acc)
    if type(C1) ~= "string" or type(C2) ~= "string" then return "&H000000&" end
	acc=tonumber(acc) or 1
    total, l = tonumber(total), tonumber(l)
    if not total or not l or total <= 1 then return C1 end
    
	local acc_fac=(l-1)^acc/(total-1)^acc
    acc_fac = math.max(0, math.min(1, acc_fac))

	local B1,G1,R1 = C1:match("H(%x%x)(%x%x)(%x%x)")
	local B2,G2,R2 = C2:match("H(%x%x)(%x%x)(%x%x)")

	if not R1 then R1 = C1:match("H(%x%x)") G1 = R1 B1 = R1 end
    if not R2 then R2 = C2:match("H(%x%x)") G2 = R2 B2 = R2 end
    if not R1 or not R2 then return C1 end 

	local nR1, nG1, nB1 = tonumber(R1,16), tonumber(G1,16), tonumber(B1,16)
    local nR2, nG2, nB2 = tonumber(R2,16), tonumber(G2,16), tonumber(B2,16)

    local R=acc_fac*(nR2-nR1)+nR1
	local G=acc_fac*(nG2-nG1)+nG1
	local B=acc_fac*(nB2-nB1)+nB1
    
	return "&H"..tohex(B)..tohex(G)..tohex(R).."&"
end

function getpos(subs,line_obj)
    local text = line_obj.text
    local st=nil 
    local defst=nil
    
    for g=1,#subs do
        if subs[g].class=="style" then
		    local s=subs[g]
		    if s.name==line_obj.style then st=s break end
		    if s.name=="Default" then defst=s end
        end
	    if subs[g].class=="dialogue" then
            if not st then
                if defst then 
                    st=defst 
                else 
                    t_error("Style '"..line_obj.style.."' not found.\nStyle 'Default' not found. ",1) 
                end
            end
            break
	    end
    end
    
    if not st then t_error("Nenhum estilo aplicável encontrado para a linha.", 1) end

    if not resx or not resy then
        for g=1,#subs do
            if subs[g].class=="info" then
		        local k=subs[g].key
		        local v=subs[g].value
		        if k=="PlayResX" then resx=tonumber(v) end
		        if k=="PlayResY" then resy=tonumber(v) end
            end
            if resx and resy then break end
        end
    end

    if not resx then resx=0 aegisub.log("AVISO getpos: PlayResX não encontrado.") end
	if not resy then resy=0 aegisub.log("AVISO getpos: PlayResY não encontrado.") end

    local horz, vert
    local acleft=st.margin_l	if line_obj.margin_l>0 then acleft=line_obj.margin_l end
	local acright=st.margin_r	if line_obj.margin_r>0 then acright=line_obj.margin_r end
	local acvert=st.margin_t	if line_obj.margin_t>0 then acvert=line_obj.margin_t end
	local acalign=st.align	if text:match("\\an(%d)") then acalign=tonumber(text:match("\\an(%d)")) end

    acalign = tonumber(acalign) or 2

	local aligntop={7,8,9} 
    local alignbot={1,2,3} 
    local aligncent={4,5,6}
	local alignleft={1,4,7} 
    local alignright={3,6,9} 
    local alignmid={2,5,8}

    local function contains(tbl, val)
        for _, v in ipairs(tbl) do if v == val then return true end end
        return false
    end

	if contains(alignleft, acalign) then horz=acleft
	elseif contains(alignright, acalign) then horz=resx-acright
	elseif contains(alignmid, acalign) then horz=resx/2 
    else horz = resx/2
    end

	if contains(aligntop, acalign) then vert=acvert
	elseif contains(alignbot, acalign) then vert=resy-acvert
	elseif contains(aligncent, acalign) then vert=resy/2 
    else vert = resy - acvert 
    end

    horz = round(horz)
    vert = round(vert)

    local new_text = text
    if horz>0 and vert>0 then 
	    if not text:match("^{\\") then new_text="{\\rel}"..text end
	    new_text=new_text:gsub("^({\\[^}]*)}","%1\\pos("..horz..","..vert..")}"):gsub("\\rel","")
        new_text = tagmerge(new_text)
    end
    return new_text
end

function fill_in(tags,tag)
    if type(tags) ~= "string" or type(tag) ~= "string" then return tags or "" end
    local val = styleval(tag)
    local current_val = tags:match(esc(tag) .. "([^\\}]+)")
    if not current_val then
	    tags=tags:gsub("^{","{"..tag..val)
    end
	return tags
end

function shiftsel2(sel,i,mode)
    if type(sel) ~= "table" then sel = {} end
    i = tonumber(i)
    if not i then return sel end

    if #sel > 0 and i < sel[#sel] then
	    for s=1,#sel do 
            if sel[s] and sel[s]>i then sel[s]=sel[s]+1 end 
        end
	end
	if mode==1 then table.insert(sel,i+1) end
	table.sort(sel)
    return sel
end


function stylechk(subs, sn)
    local found_sr = nil
    local default_sr = nil
    --aegisub.log("--- stylechk procurando por: '" .. (sn or "NIL") .. "' ---\n") 

    local subs_ok_stylechk = false
    if subs then
        local success, _ = pcall(function() return subs[1] end) 
        if success then subs_ok_stylechk = true end
    end

    if subs_ok_stylechk then 
        --aegisub.log("Total de linhas no objeto subs: " .. (#subs or "?") .. "\n")
        local style_section_found = false
        local dialogue_section_found = false

        
        for idx = 1, #subs do 
            local current_line = subs[idx]
            local current_class = current_line and current_line.class or "Tipo Desconhecido/Nil"

            if current_class == "style" then
                local st = current_line
                if st.name == "Default" then default_sr = st end
                if sn and st.name == sn then 
                    found_sr = st 
                    break 
                end
            elseif current_class == "dialogue" then
                 break 
            end
        end

        if not found_sr then 
            if default_sr then
                aegisub.log("--- AVISO: Estilo '".. (sn or "NIL") .."' não encontrado. Usando estilo 'Default' como fallback. ---\n")
                found_sr = default_sr 
            else
                aegisub.log("--- ERRO: Estilo '".. (sn or "NIL") .."' não encontrado E estilo 'Default' também não encontrado! --- \n")
            end
        end

    
    elseif not subs then
         aegisub.log("ERRO stylechk: Objeto 'subs' é nil.\n")
    else
         aegisub.log("ERRO stylechk: Objeto 'subs' recebido não é acessível (tipo: "..type(subs)..").\n")
    end
    
    sr = found_sr 
    styleref = found_sr 

    return found_sr
end


function tf(val)
	if val==true then return "true"
	elseif val==false then return "false"
	else return tostring(val) end
end

function detf(txt)
	if txt=="true" then return true
	elseif txt=="false" then return false
	else return txt end
end

function retextmod(orig,text)
	local v1,v2,c,t2
	v1=nobrea(orig)
	c=0
	repeat
		t2=textmod(orig,text)
		v2=nobrea(t2)
		c=c+1
        if c > 666 then
            logg("AVISO retextmod: Loop potencial detectado na linha com texto original: ".. orig)
            logg("Texto atual: " .. text)
            return text
        end
	until v1==v2 or c==666
	if v1~=v2 then logg("AVISO retextmod: Não foi possível reconciliar o texto após "..c.." tentativas.") logg("Original visível: "..v1) logg("Final visível: "..v2) end
	return t2
end

function textmod(orig,text)
    if text=="" then return orig end
    if type(orig) ~= "string" or type(text) ~= "string" then return orig end
    
    local tk={}
    local tg={}
	
    text=text:gsub("{\\\\k0}","")
	text=tagmerge(text)
	local vis=nobra(text)
    if not re or not re.find then logg("ERRO textmod: Módulo 're' não carregado."); return orig end
	local ltrmatches=re.find(vis,".")
	if not ltrmatches then 
        logg("AVISO textmod: Nenhum caractere visível encontrado em: "..text..'\nVisível: '..vis)
        return orig
	end
	for l=1,#ltrmatches do
	    table.insert(tk,ltrmatches[l].str)
	end
    
	local stags=text:match(STAG) or ""
	text=text:gsub(STAG,"")
    
    local orig_proc = orig:gsub("{(.-)}",function(c) 
        local escaped_c = c:gsub("|||","<pipe>")
        return wrap("\\\\"..escaped_c.."|||") 
    end)

	local count=0
	for seq in orig_proc:gmatch("([^{]-)({%*%?\\\\.-|||})") do
        local chars = seq:match("([^{]-){") or seq:match("^[^{]+") or ""
        local tag_content = seq:match("{%*%?(\\\\.-|||)}")
        if tag_content then
            local as = seq:match("{(%*?)\\\\") or ""
            tag_content = tag_content:gsub("\\\\",""):gsub("|||",""):gsub("<pipe>","|||")
	        local pos = re.find(chars,".")
	        local ps = (pos==nil) and (0+count) or (#pos+count)
	        table.insert(tg,{p=ps,t="{" .. tag_content .. "}",a=as})
	        count=ps
        end
	end

    local text_proc = text
    count=0
    for seq in text_proc:gmatch("([^{]*)({%*%?\\[^}]-})") do 
	    local chars = seq:match("([^{]-){") or seq:match("^[^{]+") or ""
        local tak = seq:match("({%*?\\[^}]-})")
        if tak then
            local as = seq:match("{(%*?)\\[") or ""
	        local pos=re.find(chars,".")
	        local ps=(pos==nil) and (0+count) or (#pos+count)
	        table.insert(tg,{p=ps,t=tak,a=as})
	        count=ps
        end
	end

    table.sort(tg, function(a,b) return a.p < b.p end)

    local newline=""
    local tag_idx = 1
    for i=1,#tk do
        while tag_idx <= #tg and tg[tag_idx].p < i do
             newline=newline..tg[tag_idx].t
             tag_idx = tag_idx + 1
        end
	    newline=newline..tk[i]
        while tag_idx <= #tg and tg[tag_idx].p == i do
             newline=newline..tg[tag_idx].t
             tag_idx = tag_idx + 1
        end
    end
    while tag_idx <= #tg do
        newline = newline .. tg[tag_idx].t
        tag_idx = tag_idx + 1
    end

    local newtext=stags..newline
    newtext=tagmerge(newtext)
    
    local final_vis = nobra(newtext)
    if vis ~= final_vis then
        logg("AVISO textmod: Texto visível divergente após reconstrução!")
        logg("Esperado: " .. vis)
        logg("Resultado: " .. final_vis)
    end

    return newtext
end

-- ==================================================================================================================================
-- Funções Auxiliares Comuns
-- ==================================================================================================================================

function table.copy(orig)
    if type(orig) ~= 'table' then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        copy[k] = v
    end
    setmetatable(copy, getmetatable(orig)) 
    return copy
end

-- Converte BGR (Aegisub) para HSL
function bgr_to_hsl(bgr_string)
    local b, g, r = bgr_string:match("H(%x%x)(%x%x)(%x%x)")
    r, g, b = tonumber(r, 16)/255, tonumber(g, 16)/255, tonumber(b, 16)/255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, l = 0, 0, (max + min) / 2
    if max ~= min then
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        if max == r then h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then h = (b - r) / d + 2
        elseif max == b then h = (r - g) / d + 4 end
        h = h / 6
    end
    return h, s, l
end

-- Converte HSL de volta para BGR
function hsl_to_bgr(h, s, l)
    local function hue2rgb(p, q, t)
        if t < 0 then t = t + 1 end
        if t > 1 then t = t - 1 end
        if t < 1/6 then return p + (q - p) * 6 * t end
        if t < 1/2 then return q end
        if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
        return p
    end
    local r, g, b
    if s == 0 then r, g, b = l, l, l
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end
    return string.format("&H%02X%02X%02X&", math.floor(b*255), math.floor(g*255), math.floor(r*255))
end

-- Converte Hex Alpha (&HXX&) para Porcentagem (0-100)
-- 00 (Visível) = 100% | FF (Invisível) = 0%
function alpha_to_pct(hex_val)
    local num = tonumber(hex_val:match("H(%x%x)") or "00", 16) or 0
    return math.floor(((255 - num) / 255) * 100 + 0.5)
end

-- Converte Porcentagem (0-100) para Hex Alpha (&HXX&)
-- 100% (Visível) = 00 | 0% (Invisível) = FF
function pct_to_alpha(pct_val)
    -- Se já for hexadecimal, devolve como está
    if type(pct_val) == "string" and pct_val:match("&H") then return pct_val end
    local num_pct = tonumber(pct_val) or 0
    local num = math.max(0, math.min(255, math.floor(((100 - num_pct) / 100) * 255 + 0.5)))
    return string.format("&H%02X&", num)
end

-- Calcula o alpha baseado no tempo decorrido da linha original
function get_smart_alpha(line_start, line_end, global_st, global_et, fade_in, fade_out)
    -- Força tudo a ser número, se for nil vira 0
    line_start = line_start or 0
    line_end = line_end or 0
    global_st = global_st or 0
    global_et = global_et or 0
    fade_in = tonumber(fade_in) or 0
    fade_out = tonumber(fade_out) or 0
    
    local alpha_tags = ""
    
    if fade_in > 0 and line_start < (global_st + fade_in) then
        local progress = math.max(0, math.min(1, (line_start - global_st) / fade_in))
        local alpha_val = math.floor(255 * (1 - progress))
        alpha_tags = alpha_tags .. string.format("\\alpha&H%02X&", alpha_val)
    end
    
    if fade_out > 0 and line_end > (global_et - fade_out) then
        local progress = math.max(0, math.min(1, (line_end - (global_et - fade_out)) / fade_out))
        local alpha_val = math.floor(255 * progress)
        alpha_tags = alpha_tags .. string.format("\\alpha&H%02X&", alpha_val)
    end
    
    return alpha_tags
end
