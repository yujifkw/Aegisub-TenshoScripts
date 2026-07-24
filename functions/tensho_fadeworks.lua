-- version: 3.0.0
-- Autor: Tenshy & unanimated
-- Descrição: Automatiza a criação de efeitos de entrada e saída (fades) em legendas de forma fluida, calculando transições suaves de opacidade por caractere ou linha.

-- ==================================================================================================================================
-- Funções Específicas do FadeWorks
-- ==================================================================================================================================

function tagcheck() --
    TAGS=nil
	local ttags = res.tags or "" 
	if ttags:len()>3 and ttags:match"^\\" then TAGS=1 end
	if (tonumber(res.tgin) or 0)==0 and (tonumber(res.tgout) or 0)==0 then TAGS=nil end 
	local checktags="|bord|shad|fs|fscx|fscy|fsp|blur|be|frz|frx|fry|fax|fay|xshad|yshad|xbord|ybord|" 
	if TAGS then
		local clean_tags = ""
        local invalid_tags = {}
		for tg in ttags:gmatch("(\\[^\\]+)") do 
			local tg1,tgval=tg:match("\\(%a+)(.*)")
			local rem=nil
            tg1 = tg1 or "" 
            tgval = tgval or "" 
            
			if not checktags:match("|"..tg1.."|") then 
                table.insert(invalid_tags, "Tag inválida: "..tg) 
                rem=1 
            end
			if not rem and not tgval:match("^%-?%d+%.?%d*$") then 
                table.insert(invalid_tags, "Valor ausente/inválido: "..tg) 
                rem=1
            end
            if not rem then clean_tags = clean_tags .. tg end 
		end
        if #invalid_tags > 0 then t_error(table.concat(invalid_tags, "\n")) end 
        res.tags = clean_tags 
		if not res.tags:match"^\\" then TAGS=nil end 
	end
end

function def(local_fadin, local_fadout, duration)
    if not duration or duration <= 0 then return 0, 0 end 
    if local_fadin<=1 and local_fadin>0 then local_fadin=round(duration*local_fadin) end
    if local_fadout<=1 and local_fadout>0 then local_fadout=round(duration*local_fadout) end
    if local_fadin<0 then local_fadin=duration+local_fadin end
    if local_fadout<0 then local_fadout=duration+local_fadout end
    if local_fadin<0 then local_fadin=0 end
    if local_fadout<0 then local_fadout=0 end
    return local_fadin, local_fadout
end

function fade(subs,sel)
    --aegisub.log("Executando fade...")
    local byletter_mode = (P == T("fw_btn_byltr")) and not res.ko and not res.word 
    local byletter_dir = res.byletter_dir or T("fw_dir_ltr") 

    for z,i in ipairs(sel) do
        aegisub.progress.set(100*z/#sel)
        aegisub.progress.task("Aplicando Fade: Linha " .. z .. "/" .. #sel)
        local line=subs[i]
        local text=line.text
        
        if byletter_mode then
            text = text:gsub("\\[Kk][fo]?[%d%.]+", "")
            text = tagmerge(text):gsub("{}","")
        end

        local orig_text_for_retextmod = text 
        local st, et, dur = times(line) 
        local fadin_local, fadout_local = def(fadin, fadout, dur) 

        text=text:gsub("\\fad%b()","") 

        if not byletter_mode then 
            text="{\\fad("..fadin_local..","..fadout_local..")}"..text
            text=text:gsub("%)}{\\",")\\") :gsub("{}","") 
        
        else 
            -- FADE BY LETTER (COM PRESERVAÇÃO DE GRADIENTE)
            
            -- 1. Validações Iniciais
            local lf = tonumber(res.letterfade) or 120 
            if (fadin_local > 0 and fadin_local <= lf) or (fadout_local > 0 and fadout_local <= lf) then 
                if script_language == "pt" then t_error("O fade para cada letra ("..lf.."ms) deve ser menor que o fade total. Linha #".. (i-line0), true)
                else t_error("The fade for each letter ("..lf.."ms) must be less than total fade. Line #".. (i-line0), true) end
                goto next_line
            end
                
            local mode = 0
            if fadin_local > 0 and fadout_local == 0 then mode = 1 
            elseif fadin_local == 0 and fadout_local > 0 then mode = 2 
            elseif fadin_local > 0 and fadout_local > 0 then mode = 3 end
            if mode == 0 then goto next_line end

            -- 2. Tokenização Segura (Preserva as tags de cada letra)
            local STAG = "^{\\[^}]-}"
            local initial_tags = text:match(STAG) or ""
            local al = initial_tags:match("\\alpha&H(%x%x)&") or "00" -- Alpha base da linha
            
            -- Limpamos o fade nativo antigo das tags iniciais
            local clean_initial = initial_tags:gsub("\\fad%([^%)]-%)", "")
            if clean_initial == "" then clean_initial = "{}" end

            local text_to_process = text:gsub(STAG, "")
            local tokens = {}
            local temp_text = text_to_process
            local current_tags = ""
            local valid_length = 0 

            while temp_text ~= "" do
                local tag_match = temp_text:match("^(%b{})")
                if tag_match then
                    current_tags = current_tags .. tag_match
                    temp_text = temp_text:sub(#tag_match + 1)
                else
                    -- Proteção especial para \N não ser cortado ao meio
                    local n_match = temp_text:match("^\\N")
                    if n_match then
                        table.insert(tokens, {char = "\\N", tags = current_tags})
                        current_tags = ""
                        temp_text = temp_text:sub(3)
                    else
                        local char_match = re.find(temp_text, ".")
                        if char_match and #char_match > 0 then
                            local char_str = char_match[1].str
                            table.insert(tokens, {char = char_str, tags = current_tags})
                            current_tags = ""
                            temp_text = temp_text:sub(char_match[1].last + 1)
                            
                            -- Contamos apenas caracteres visíveis (ignorando espaços/quebras) para calcular o atraso
                            if char_str:match("%S") then valid_length = valid_length + 1 end
                        else
                            temp_text = ""
                        end
                    end
                end
            end

            if valid_length <= 1 then goto next_line end

            -- 3. Cálculos de Tempo por Letra
            local outfade = dur - fadout_local 
            local mid_idx = math.floor(valid_length / 2)
            local max_pos = (byletter_dir == T("fw_dir_ltr") or byletter_dir == T("fw_dir_rtl")) and (valid_length - 1) or math.max(mid_idx, valid_length - mid_idx - 1)
            if max_pos < 1 then max_pos = 1 end 

            local ftime1 = (fadin_local > lf) and ((fadin_local - lf) / max_pos) or 0 
            local ftime2 = (fadout_local > lf) and ((fadout_local - lf) / max_pos) or 0

            -- 4. Reconstrução com Transformação Interpolada
            local final_text = clean_initial
            local valid_char_index = 0

            for _, token in ipairs(tokens) do
                local ch = token.char
                
                -- Se é espaço ou quebra de linha, só injeta o caractere com suas tags originais
                if not ch:match("%S") or ch == "\\N" then
                    final_text = final_text .. token.tags .. ch
                else
                    valid_char_index = valid_char_index + 1
                    local current_is_left = (valid_char_index <= mid_idx)
                    
                    -- Direcionamento
                    local pos_ltr, pos_rtl
                    if byletter_dir == T("fw_dir_ltr") then pos_ltr = valid_char_index - 1
                    elseif byletter_dir == T("fw_dir_rtl") then pos_rtl = valid_length - valid_char_index
                    elseif byletter_dir == T("fw_dir_m2o") then
                        if current_is_left then pos_rtl = mid_idx - valid_char_index else pos_ltr = valid_char_index - mid_idx - 1 end
                    elseif byletter_dir == T("fw_dir_o2m") then
                        if current_is_left then pos_ltr = valid_char_index - 1 else pos_rtl = valid_length - valid_char_index end
                    end

                    -- Cálculos dos Milissegundos
                    local fin1, fout1
                    if pos_ltr ~= nil then
                        fin1 = math.floor(ftime1 * pos_ltr)
                        fout1 = math.floor(ftime2 * pos_ltr + outfade)
                    elseif pos_rtl ~= nil then
                        fin1 = math.floor(ftime1 * pos_rtl)
                        fout1 = math.floor(ftime2 * pos_rtl + outfade)
                    else
                        fin1 = math.floor(ftime1 * (valid_char_index-1))
                        fout1 = math.floor(ftime2 * (valid_char_index-1) + outfade)
                    end
                    local fin2, fout2 = fin1 + lf, fout1 + lf
                    
                    -- Verifica se a letra tem um Alpha próprio, senão usa o da linha
                    local curr_al = token.tags:match("\\alpha&H(%x%x)&") or al
                    local alpha_tag = ""
                    
                    if mode == 1 then alpha_tag = "\\alpha&HFF&\\t("..fin1..","..fin2..",1,\\alpha&H"..curr_al.."&)" 
                    elseif mode == 2 then alpha_tag = "\\alpha&H"..curr_al.."&\\t("..fout1..","..fout2..",1,\\alpha&HFF&)" 
                    elseif mode == 3 then alpha_tag = "\\alpha&HFF&\\t("..fin1..","..fin2..",1,\\alpha&H"..curr_al.."&)\\t("..fout1..","..fout2..",1,\\alpha&HFF&)" 
                    end

                    -- Injeção segura no Token
                    if token.tags ~= "" then
                        token.tags = token.tags:gsub("}$", alpha_tag .. "}")
                    else
                        token.tags = "{" .. alpha_tag .. "}"
                    end
                    
                    final_text = final_text .. token.tags .. ch
                end
            end

            text = final_text
        end

        text=text:gsub("\\fad%(0,0%)","") :gsub("{}","")
        if line.text~=text and not brackets then
            line.text=text
            subs[i]=line
        end
        if brackets then logg("Linha #"..(i-line0)..": Brackets inválidos detectados. Pulando.") end 
        
        ::next_line:: 
    end
end

function fadalpha(subs, sel)
    --aegisub.log("Executando fade alpha/color...")
    if res.clr or res.crl then res.alf = true end
    if res.vin or res.vout then vfcheck() if not vt then return sel end end
    mirrors = "|frz|fry|fax|xshad|"

    local subs_ok = false
    if subs then
        local success, _ = pcall(function() return subs[1] end)
        if success then subs_ok = true end
    end

    if not subs_ok then
        logg("ERRO fadalpha: Objeto 'subs' inválido ou inacessível no início da função.")
        t_error("Erro interno: Objeto de legendas inválido em fadalpha.", true)
        return sel
    end
    --logg("fadalpha: Iniciando. Objeto subs parece válido (tipo: " .. type(subs) .. ").")

    for z, i in ipairs(sel) do
        aegisub.progress.set(100 * z / #sel)
        aegisub.progress.task("Aplicando Alpha/Cor: Linha " .. z .. "/" .. #sel)
        
        if not i or not subs[i] then
             logg("ERRO fadalpha: Índice de linha inválido 'i'=" .. tostring(i) .. " ou subs[i] não existe. Pulando iteração.")
             goto continue_fadalpha
        end
        
        local line = subs[i]
        
        if not line or type(line) ~= "table" then
            logg("ERRO fadalpha: Objeto 'line' inválido para índice " .. i .. ". Pulando.")
            goto continue_fadalpha 
        end

        local text = line.text or "" 
        local ortext = text
        
        local stylechk_success, style_ref_or_error = pcall(stylechk, subs, line.style) 
        if not stylechk_success then
            logg("ERRO fadalpha: pcall(stylechk) falhou! Erro: " .. tostring(style_ref_or_error))
            t_error("Erro ao verificar estilo para linha #".. (i-(line0 or 0)) ..". Verifique o log.", false)
            sr = nil 
        else
            sr = style_ref_or_error 
        end
        
        if not sr then
             logg("AVISO fadalpha: stylechk retornou nil para linha " .. i .. ". Pulando processamento alpha/cor.")
             goto continue_fadalpha 
        end

        styleref = sr 
        local st, et, dur = times(line)
        local fadin_local, fadout_local = def(fadin, fadout, dur)
        if res.vin then fadin_local = vt - st end
        if res.vout then fadout_local = et - vt end

        if not text:match("^{\\[^}]-}") then text="{\\arfa}"..text end 

	    local col1=res.c1:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") 
	    local col2=res.c2:gsub("#(%x%x)(%x%x)(%x%x)","&H%3%2%1&") 
	    local SC1=sr.color1:gsub("H%x%x","H") 
	    local SC3=sr.color3:gsub("H%x%x","H") 
	    local SC4=sr.color4:gsub("H%x%x","H") 

	    text=text:gsub("\\1c","\\c") 
	    local notra=text:gsub("\\t%b()","") 
	    local primary=notra:match("^{[^}]-\\c(&H%x+&)") or SC1 
	    local outline=notra:match("^{[^}]-\\3c(&H%x+&)") or SC3 
	    local shadcol=notra:match("^{[^}]-\\4c(&H%x+&)") or SC4 
	    local primary2=text:match("^{[^}]*\\c(&H%x+&)[^}]-}") or SC1 
	    local outline2=text:match("^{[^}]*\\3c(&H%x+&)[^}]-}") or SC3 
	    local shadcol2=text:match("^{[^}]*\\4c(&H%x+&)[^}]-}") or SC4 
	    local border=tonumber(text:match("^{[^}]-\\bord([%d%.]+)")) or sr.outline 
	    local shadow=tonumber(text:match("^{[^}]-\\shad([%d%.]+)")) or sr.shadow 

	    local kolora1="\\c"..col1	local kolora3="\\3c"..col1	local kolora4="\\4c"..col1	local kolora,see1,see3,see4="","","","" 
	    local kolorb1="\\c"..col2	local kolorb3="\\3c"..col2	local kolorb4="\\4c"..col2	local kolorb="" 
	    if col1~=primary then kolora=kolora..kolora1 see1="\\c"..primary end 
	    if col1~=outline then kolora=kolora..kolora3 see3="\\3c"..outline end 
	    if col1~=shadcol then kolora=kolora..kolora4 see4="\\4c"..shadcol end 
	    if col2~=primary2 then kolorb=kolorb..kolorb1 end 
	    if col2~=outline2 then kolorb=kolorb..kolorb3 end 
	    if col2~=shadcol2 then kolorb=kolorb..kolorb4 end 
	    local a00="\\alpha&H00&"	local aff="\\alpha&HFF&"	

        local transforms_to_add = ""

	    if res.alf then 
            text = tagmerge(text)
            
            local first_block_done = false

            text = text:gsub("({[^}]-})", function(m)
                -- Verifica se o bloco contém tags de cor/alpha ou se é o primeiro bloco da linha
                local has_color = m:match("\\[1234]?[ca]&H%x+&") or m:match("\\alpha&H%x+&")
                if not has_color and first_block_done then return m end
                first_block_done = true

                local block_transforms = ""

                -- 1. FADE IN
                if fadin_local ~= 0 then
                    if res.crl then
                        -- FADE IN POR COR
                        -- Captura a cor EXATA deste bloco do gradiente (ou a do estilo)
                        local curr_c1 = m:match("\\c(&H%x+&)") or m:match("\\1c(&H%x+&)") or SC1
                        local curr_c3 = m:match("\\3c(&H%x+&)") or SC3
                        local curr_c4 = m:match("\\4c(&H%x+&)") or SC4

                        local from_c = ""
                        local to_c = ""

                        if col1 ~= curr_c1 then from_c = from_c .. "\\c" .. col1; to_c = to_c .. "\\c" .. curr_c1 end
                        if col1 ~= curr_c3 and border > 0 then from_c = from_c .. "\\3c" .. col1; to_c = to_c .. "\\3c" .. curr_c3 end
                        if col1 ~= curr_c4 and shadow > 0 then from_c = from_c .. "\\4c" .. col1; to_c = to_c .. "\\4c" .. curr_c4 end

                        if from_c ~= "" then
                            block_transforms = block_transforms .. from_c .. "\\t(0," .. fadin_local .. "," .. res.inn .. "," .. to_c .. ")"
                        end
                    else
                        -- FADE IN POR ALPHA
                        local curr_a = m:match("\\alpha(&H%x+&)") or "&H00&"
                        local curr_1a = m:match("\\1a(&H%x+&)")
                        local curr_3a = m:match("\\3a(&H%x+&)")
                        local curr_4a = m:match("\\4a(&H%x+&)")
                        
                        local to_alf = ""
                        local from_alf = ""
                        
                        if curr_1a or curr_3a or curr_4a then
                            to_alf = (curr_1a and "\\1a"..curr_1a or "") .. (curr_3a and "\\3a"..curr_3a or "") .. (curr_4a and "\\4a"..curr_4a or "")
                            from_alf = to_alf:gsub("&H%x%x&", "&HFF&")
                        else
                            to_alf = "\\alpha" .. curr_a
                            from_alf = "\\alpha&HFF&"
                        end
                        block_transforms = block_transforms .. from_alf .. "\\t(0," .. fadin_local .. "," .. res.inn .. "," .. to_alf .. ")"
                    end
                end

                -- 2. FADE OUT
                if fadout_local ~= 0 then
                    if res.clr then
                        -- FADE OUT POR COR
                        -- Para o Fade Out, o Aegisub interpola automaticamente a partir da cor atual da letra. 
                        -- Só precisamos informar a cor destino (col2).
                        local to_c = ""
                        if kolorb1 ~= "" then to_c = to_c .. kolorb1 end
                        if kolorb3 ~= "" and border > 0 then to_c = to_c .. kolorb3 end
                        if kolorb4 ~= "" and shadow > 0 then to_c = to_c .. kolorb4 end
                        
                        if to_c ~= "" then
                            block_transforms = block_transforms .. "\\t(" .. (dur-fadout_local) .. "," .. dur .. "," .. res.utt .. "," .. to_c .. ")"
                        end
                    else
                        -- FADE OUT POR ALPHA
                        local to_alf = "\\alpha&HFF&"
                        if m:match("\\1a") or m:match("\\3a") or m:match("\\4a") then
                            to_alf = "\\1a&HFF&\\3a&HFF&\\4a&HFF&"
                        end
                        block_transforms = block_transforms .. "\\t(" .. (dur-fadout_local) .. "," .. dur .. "," .. res.utt .. "," .. to_alf .. ")"
                    end
                end

                -- Injeta a transformação correta especificamente neste bloco
                if block_transforms ~= "" then
                    return m:gsub("}$", block_transforms .. "}")
                end
                return m
            end)

            -- Limpeza de formatações não utilizadas
            if border == 0 then text = text:gsub("\\3c&H%x+&",""):gsub("\\3a&H%x+&","") end
            if shadow == 0 then text = text:gsub("\\4c&H%x+&",""):gsub("\\4a&H%x+&","") end
            
            text = text:gsub("\\fad%([^%)]+%)","")
            if res.keepthefade then 
                local f1, f2 = 0, 0
                if fadin_local > 0 and res.crl then f1 = fadin_local end 
                if fadout_local > 0 and res.clr then f2 = fadout_local end 
                if f1+f2 > 0 then text = addtag1("\\fad("..f1..","..f2..")", text) end 
            end
	    end
	
	    if TAGS then
		    local tgin_local, tgout_local = def(res.tgin or 0, res.tgout or 0, dur) 
		    local origtags="" 
		    local tftagsIN="" 
		    local tftagsOUT="" 
		    
            local current_tags = text:match(STAG) or "{}"

		    for tg in (res.tags or ""):gmatch("(\\[^\\]+)") do 
			    local tag,tgval=tg:match("\\(%a+)(.*)")
			    tag = tag or ""
                tgval = tgval or ""
                
                local midval = getvalue(tag) 
			    
                tftagsIN=tftagsIN.."\\"..tag..tgval 
                
                local tgval_out = tgval
                if res.mir and mirrors:match("|"..tag.."|") then tgval_out=tostring(0-(tonumber(tgval) or 0)) end 
			    tftagsOUT=tftagsOUT.."\\"..tag..tgval_out 
			    
                origtags=origtags.."\\"..tag..midval 
			    
                current_tags=current_tags:gsub("(\\{)".."("..esc(tag).."[^}\\t]*)", "%1")
                current_tags=current_tags:gsub("\\\\"..esc(tag).."[^}\\t]*","")
		    end
            
            local transfinal = ""
		    if tgin_local~=0 then transfinal = transfinal .. tftagsIN.."\\t(0,"..tgin_local..","..res.tai..","..origtags..")" else transfinal = transfinal .. origtags end 
            if tgout_local~=0 then transfinal = transfinal .. "\\t("..(dur-tgout_local)..","..dur..","..res.tao..","..tftagsOUT..")" end 
            
		    current_tags=current_tags:gsub("}$",transfinal.."}") 
            current_tags=tagmerge(current_tags) 
            current_tags=duplikill(current_tags) 
            
            if ortext:match(STAG) then
                local found_original_block = false
                text = text:gsub(STAG, function(match) 
                                        if not found_original_block then 
                                            found_original_block = true 
                                            return current_tags 
                                        else 
                                            return match
                                        end 
                                     end)
                if not found_original_block then text = current_tags .. text:gsub(STAG,"") end
            else
                text = current_tags .. text
            end
	    end

	    text=text:gsub("\\arfa","") 
        text=tagmerge(text)
        text=text:gsub("{}","")

	    if line.text~=text then
            line.text=text
	        subs[i]=line
        end

        ::continue_fadalpha:: 
    end
    return sel 
end

function getvalue(tag)
    local V = nil
    local current_tags = text:match(STAG) or ""
	V=current_tags:match("\\"..esc(tag).."(%-?%d+%.?%d*)")
	if not V then
        V = styleval("\\"..tag) 
	end
	return V or "0"
end

function koko_da(subs,sel) 
    --aegisub.log("Executando fade by letter (\\ko)...")
    local fadin_local = tonumber(fadin) or 0
    if fadin_local<1 then t_error(T("fw_warn"),true) end 

    for x,i in ipairs(sel) do
        aegisub.progress.set(100*x/#sel)
        aegisub.progress.task("Aplicando \\ko: Linha " .. x .. "/" .. #sel)
        local line=subs[i]
        local text=line.text
        text=text:gsub("\\k[of]?%d+","")
        text=tagmerge(text):gsub("{}","")

	    local tags=text:match(STAG) or ""
	    local orig=text:gsub(STAG,"")
	    local text_no_tags=orig:gsub("{[^}]*}","")
        local text_clean=text_no_tags:gsub("%s*$",""):gsub("\\N","*")
        if text_clean == "" then goto continue_koko end

        local ko_val = 0
	    if not res.word then 
            if not re or not re.find then logg("ERRO koko_da: Módulo 're' não disponível!"); goto continue_koko end
		    local matches=re.find(text_clean,".")
            if not matches then goto continue_koko end
            local len = #matches
            if len <= 0 then goto continue_koko end
		    if fadin_local>=40 then ko_val=round(fadin_local/(len))/10 else ko_val=fadin_local end 
            if ko_val <= 0 then ko_val = 0.1 end
            text_clean=re.sub(text_clean,"(.)","{\\\\ko"..ko_val.."}\\1") 
	    else
            if not re or not re.find then logg("ERRO koko_da: Módulo 're' não disponível!"); goto continue_koko end
            local matches=re.find(text_clean,"%S+")
            if not matches then goto continue_koko end
            local len = #matches
            if len <= 0 then goto continue_koko end
		    if fadin_local>=40 then ko_val=round(fadin_local/(len)/10) else ko_val=fadin_local end 
            if ko_val <= 0 then ko_val = 1 end
            text_clean=re.sub(text_clean,"(%S+)","{\\\\ko"..ko_val.."}\\1") 
	    end

	    text=tags..text_clean
	    if not text:match("\\2a&HFF&") then text=text:gsub("^({.-)}","%1\\2a&HFF&}") end 
	    text=text:gsub("{(\\[^}]-)}{(\\[^}]-)}","{%1%2}") :gsub("%*","\\N") 
	    
        if orig:match("{\\") then text=retextmod(orig, text) end 
	    
        if line.text ~= text then
            line.text=text
            subs[i]=line
        end
        ::continue_koko::
    end
end

function fadeacross(subs,sel)
    --aegisub.log("Executando fade across lines...")
	local local_fadin = fadin
    local local_fadout = fadout
    if local_fadin<0 then local_fadin=0 end 
	if local_fadout<0 then local_fadout=0 end 
	local full=0	local war=0 
	local S=subs[sel[1]].start_time 
	local E=subs[sel[#sel]].end_time 
	
	for z,i in ipairs(sel) do
		local line=subs[i]
		local st, et, dur = times(line) 
		full=full+dur
		if st<S then S=st war=1 end 
		if et>E then E=et war=1 end 
	end
	
	if (res.time and local_fadin+local_fadout>E-S) or (not res.time and local_fadin+local_fadout>full) then 
		t_error("Error. Fades são maiores que a duração total das linhas selecionadas.",true)
	end
	if war==1 then t_error("Aviso: Linhas selecionadas não parecem estar ordenadas por tempo.") end
	
	local full_total = full 
    local full_global = E-S 
    if res.time then full = full_global else full = full_total end 
	
    local durs=0 
    
    for z,i in ipairs(sel) do
        aegisub.progress.set(100*z/#sel)
        aegisub.progress.task("Aplicando Fade Across: Linha " .. z .. "/" .. #sel)
	    local line=subs[i]
	    local text=line.text
	    local start,endt,dur=times(line) 
        local start_relative = start - S 
        local end_relative = endt - S 

	    sr=stylechk(subs,line.style) 
        styleref = sr
	    local shad="00" 
        local shad_style = sr.color4:match("H(%x%x)") 
        if shad_style then shad = shad_style end
	    if text:match("\\4a&H(%x%x)&") then shad=text:match("\\4a&H(%x%x)&") end 
	    local shade=0 
        if shad~="00" then shade=1-(tonumber(shad,16)/255) end 
	    
        killpha(line)
        text = line.text

        local current_start_time = res.time and start_relative or durs 
        local current_end_time = res.time and end_relative or (durs + dur) 
        local current_remaining_start = res.time and (full_global - end_relative) or (full_total - (durs + dur)) 
        local current_remaining_end = res.time and (full_global - start_relative) or (full_total - durs) 

	    if current_start_time < local_fadin then 
		    local in_start = current_start_time 
            local in_end = math.min(current_end_time, local_fadin) 
            local in_dur_line = in_end - in_start 
            
            local alpha_start = round(in_start / local_fadin * 255)
            local alpha_end = round(in_end / local_fadin * 255)
            
            local alpha_start_hex = tohex(255 - alpha_start)
            local alpha_end_hex = tohex(255 - alpha_end)
            
            local s_alpha_start_hex = alpha_start_hex
            local s_alpha_end_hex = alpha_end_hex
            if shade > 0 then 
                 s_alpha_start_hex=tohex(255-round((255-tonumber(alpha_start_hex,16))*shade))
		         s_alpha_end_hex=tohex(255-round((255-tonumber(alpha_end_hex,16))*shade))
            end

            local tag_start, tag_end
            if shade > 0 then 
                tag_start="\\1a&H"..alpha_start_hex.."&\\3a&H"..alpha_start_hex.."&\\4a&H"..s_alpha_start_hex.."&"
		        tag_end="\\1a&H"..alpha_end_hex.."&\\3a&H"..alpha_end_hex.."&\\4a&H"..s_alpha_end_hex.."&"
            else 
                tag_start="\\alpha&H"..alpha_start_hex.."&" 
                tag_end="\\alpha&H"..alpha_end_hex.."&"
            end

            local t_start = 0 
            local t_end = round(in_dur_line) 
            
            if current_end_time <= local_fadin then
                text = addtag1(tag_start .. "\\t("..t_start..","..t_end..",1,"..tag_end..")", text)
            else 
                t_end = round(local_fadin - current_start_time) 
                text = addtag1(tag_start .. "\\t("..t_start..","..t_end..",1,"..tag_end..")", text)
            end
	    end
        
	    if current_remaining_end < local_fadout then 
            local out_start_remaining = math.max(current_remaining_start, 0) 
            local out_end_remaining = current_remaining_end 
            local out_dur_line = out_end_remaining - out_start_remaining 

            local alpha_start = round(out_end_remaining / local_fadout * 255) 
            local alpha_end = round(out_start_remaining / local_fadout * 255) 
            
            local alpha_start_hex = tohex(255 - alpha_start)
            local alpha_end_hex = tohex(255 - alpha_end)
            
            local s_alpha_start_hex = alpha_start_hex
            local s_alpha_end_hex = alpha_end_hex
            if shade > 0 then 
                 s_alpha_start_hex=tohex(255-round((255-tonumber(alpha_start_hex,16))*shade))
		         s_alpha_end_hex=tohex(255-round((255-tonumber(alpha_end_hex,16))*shade))
            end

            local tag_start, tag_end
            if shade > 0 then 
                tag_start="\\1a&H"..alpha_start_hex.."&\\3a&H"..alpha_start_hex.."&\\4a&H"..s_alpha_start_hex.."&"
		        tag_end="\\1a&H"..alpha_end_hex.."&\\3a&H"..alpha_end_hex.."&\\4a&H"..s_alpha_end_hex.."&"
            else 
                tag_start="\\alpha&H"..alpha_start_hex.."&" 
                tag_end="\\alpha&H"..alpha_end_hex.."&"
            end

            local t_start = 0 
            local t_end = dur 

            if current_remaining_start <= 0 then 
                 text = addtag1(tag_start .. "\\t("..t_start..","..t_end..",1,"..tag_end..")", text)
            else 
                t_start = round(dur - out_dur_line) 
                text = addtag1(tag_start .. "\\t("..t_start..","..t_end..",1,"..tag_end..")", text)
            end
	    end

	    text=text:gsub("\\fake","") :gsub("{}","") 
   	    line.text=tagmerge(text) 
	    subs[i]=line
        
        if not res.time then durs = durs + dur end 
	end
end

function killpha(line)
    local text = line.text
    local shad = "00"
    if sr then
        local shad_style = sr.color4:match("H(%x%x)") 
        if shad_style then shad = shad_style end
    end
	if text:match("\\4a&H(%x%x)&") then shad=text:match("\\4a&H(%x%x)&") end 
    
	if shad~="00" then text=text:gsub("\\[1234]a&H%x%x&","") end 
	text=text:gsub("\\fad%([^%)]+%)",""):gsub("\\alpha&H%x%x&",""):gsub("\\t%([^%)]-\\alpha[^%)]+%)","") 
    text=tagmerge(text):gsub("{}","") 
	if not text:match("^{\\") then text="{\\fake}"..text end 
    line.text = text
end

function vfade(subs,sel)
    --aegisub.log("Executando fade to/from frame...")
    vfcheck() 
    if not vt then return sel end 

    for z,i in ipairs(sel) do
        aegisub.progress.set(100*z/#sel)
        aegisub.progress.task("Aplicando VFade: Linha " .. z .. "/" .. #sel)
	    local line=subs[i]
	    local text=line.text
	    local st,et, dur = times(line) 
	    vt=math.floor((fr2ms(vframe+1)+fr2ms(vframe))/2) 
	    local vfin = 0
        local vfut = 0
        if res.vin and vt > st then vfin=vt-st end 
	    if res.vout and et > vt then vfut=et-vt end 
	    
        text = text:gsub("\\fad%([^%)]+%)", "") 
	    if vfin > 0 or vfut > 0 then 
            text=addtag1("\\fad("..vfin..","..vfut..")", text) 
        end
        text=tagmerge(text):gsub("{}","") 

   	    if line.text ~= text then
            line.text=text
	        subs[i]=line
        end
    end
    return sel
end

function vfcheck()
    vt = nil 
    if aegisub.project_properties==nil then t_error("Current frame unknown.\nProbably your Aegisub is too old.\nMinimum required: r8374.",true) end 
	vframe=aegisub.project_properties().video_position 
	if not fr2ms then fr2ms = aegisub.ms_from_frame end
    if vframe==nil or not fr2ms or fr2ms(1)==nil then t_error("Current frame unknown. Probably no video loaded or timing info missing.",true) end 
    vt=math.floor((fr2ms(vframe+1)+fr2ms(vframe))/2) 
end

function clipfade(subs,sel)
    --aegisub.log("Executando fade by clip...")
	for z,i in ipairs(sel) do
        aegisub.progress.set(100*z/#sel)
        aegisub.progress.task("Aplicando ClipFade: Linha " .. z .. "/" .. #sel)
		local line=subs[i]
		local text=line.text
		local st, et, dur=times(line) 
        local fadin_local, fadout_local = def(fadin, fadout, dur) 

		local tags=text:match(STAG) or ""
		local vis=nobra(text) 
        if vis == "" then goto continue_clipfade end 

        local poses = 0 
		for _ in text:gmatch("\\N") do poses = poses + 1 end
        poses = poses + 1 

		sr=stylechk(subs,line.style) 
        styleref = sr
		local notra=detra(tags) 

        local text_with_pos = text
		if not text:match'\\pos%b()' and not text:match'\\move%b()' then 
            text_with_pos=getpos(subs, line) 
        end
		local posX,posY = text_with_pos:match("\\pos%(([%d%.%-]+),([%d%.%-]+)%)") 
        local m1,m2 
        if not posX then m1,m2=text_with_pos:match("\\move%(([%d%.%-]+),([%d%.%-]+),") end 
		if m1 and not posY then posX=m1 posY=m2 end 
        
        if not posX or not posY then 
            logg("AVISO ClipFade: Não foi possível determinar a posição da linha #"..(line.i-line0))
            goto continue_clipfade 
        end
        posX, posY = tonumber(posX), tonumber(posY) 

		local scx=tonumber(notra:match("\\fscx([%d%.]+)")) or sr.scale_x 
		local scy=tonumber(notra:match("\\fscy([%d%.]+)")) or sr.scale_y 
		local fsp=tonumber(notra:match("\\fsp([%d%.]+)")) or sr.spacing 
		local fsize=tonumber(notra:match("\\fs([%d%.]+)")) or sr.fontsize 
		local phont=notra:match("\\fn([^\\}]+)") or sr.fontname 
		local bord=tonumber(notra:match("\\bord([%d%.]+)")) or sr.outline 
		local shad=tonumber(notra:match("\\shad([%d%.]+)")) or sr.shadow 
		local xshad=tonumber(notra:match("\\xshad([%d%.%-]+)")) or shad 
		local yshad=tonumber(notra:match("\\yshad([%d%.%-]+)")) or shad 
		local bold=notra:match("\\b([01])") 

        local temp_style = table.copy(sr)
		if scx then temp_style.scale_x=scx end 
		if scy then temp_style.scale_y=scy end 
		if fsp then temp_style.spacing=fsp end 
		if fsize then temp_style.fontsize=fsize end 
		if phont then temp_style.fontname=phont end 
		if bold=='1' then temp_style.bold=true end 
		if bold=='0' then temp_style.bold=false end 

		local w,h,d,el = aegisub.text_extents(temp_style,vis) 
        if not w then 
             logg("AVISO ClipFade: aegisub.text_extents falhou para linha #"..(line.i-line0))
             goto continue_clipfade 
        end
        w = w * (scx/100) 
        h = h * (scy/100) 
        
		if poses>1 then
			local vis2=vis:gsub(" *\\N *","\n") 
			w=0 
			for vt in vis2:gmatch('[^\n]+') do
				local w1 = aegisub.text_extents(temp_style,vt)
                if w1 then 
                    w1 = w1 * (scx/100)
                    if w1>w then w=w1 end 
                end
			end
		end

		local align=tonumber(text:match("\\an(%d)")) or sr.align 
        align = tonumber(align) or 2 

		local x_left=posX
		if align==2 or align==5 or align==8 then x_left=posX-w/2 end 
		if align==3 or align==6 or align==9 then x_left=posX-w end 
		local y_top=posY
		if align==4 or align==5 or align==6 then y_top=posY-h/2 end 
		if align==1 or align==2 or align==3 then y_top=posY-h end 
        
        x_left = round(x_left)
        y_top = round(y_top)
		local x_right=round(x_left+w) 
		local y_bottom=round(y_top+h) 
		
        local extra_bord = math.max(bord or 0, 0) 
        local extra_xshad = math.max(xshad or 0, 0) 
        local extra_yshad = math.max(yshad or 0, 0) 
		local ex=0 
		if res.ex then ex=3 end 

		local clip_x1=x_left-extra_bord-ex
		local clip_y1=y_top-extra_bord-ex
		local clip_x2=x_right+extra_bord+extra_xshad+ex
		local clip_y2=y_bottom+extra_bord+extra_yshad+ex

		local klip='\\clip'..par({clip_x1,clip_y1,clip_x2,clip_y2})
		local klip_s='\\clip'..par({clip_x1,clip_y1,clip_x1,clip_y2}) 
		local klip_e='\\clip'..par({clip_x2,clip_y1,clip_x2,clip_y2}) 
		
        local text_final = text:gsub('\\i?clip%b()','') 
        local klip_f = ""

		if fadin_local==0 and fadout_local==0 then 
            klip_f=klip 
        else
            if fadin_local > 0 then klip_f=klip_s..'\\t(0,'..fadin_local..','..res.inn..','..klip..')' else klip_f=klip end 
		    if fadout_local > 0 then klip_f=klip_f..'\\t('..(dur-fadout_local)..','..dur..','..res.utt..','..klip_e..')' end 
        end

		text_final=addtag1(klip_f,text_final) 
        text_final=tagmerge(text_final) 

		if line.text ~= text_final then
            line.text=text_final
		    subs[i]=line
        end
        ::continue_clipfade::
	end
    return sel
end

function saveconfig_fadeworks(ADP, ADD)
    local fadconf="Fade config\n\n"
    if not res then logg("AVISO saveconfig_fadeworks: 'res' global não definido."); return end
    
    for name, value in pairs(res) do
        local v_type = type(value)
        if v_type == "string" or v_type == "number" or v_type == "boolean" then
            if name ~= "save" and name ~= "del" and name ~= "hlp" and name ~= "rep" then 
                 fadconf=fadconf..name..":"..tf(value).."\n"
            end
        end
    end

    local fadconfig_path=(ADP and ADP("?user") or aegisub.decode_path("?user")).."\\tensho_fadeworks.conf" 
    local file, err = io.open(fadconfig_path,"w")
    if not file then 
        logg("ERRO saveconfig_fadeworks: Não foi possível abrir "..fadconfig_path.." para escrita: "..tostring(err))
        return 
    end
    file:write(fadconf)
    file:close()
    local current_ADD = ADD or aegisub.dialog.display
    current_ADD({{class="label",label="Configuração do FadeWorks salva em:\n"..fadconfig_path}},{"OK"},{close='OK'})
end

function loadconfig_fadeworks(controls_table, ADP)
    local fadconfig_path=(ADP and ADP("?user") or aegisub.decode_path("?user")).."\\tensho_fadeworks.conf" 
    local file, err = io.open(fadconfig_path, "r")
    local loaded_values = {}
    if file then
	    local konf=file:read("*all")
	    io.close(file)
        for line in konf:gmatch("[^\r\n]+") do
            local name, value = line:match("^([^:]+):(.*)$")
            if name and value then
                loaded_values[name] = detf(value) 
            end
        end
        for _, control in ipairs(controls_table) do
            if control.name and loaded_values[control.name] ~= nil then
                 control.value = loaded_values[control.name]
            end
        end
        --logg("Configuração do FadeWorks carregada.") 
    else
        --logg("AVISO loadconfig_fadeworks: Arquivo "..fadconfig_path.." não encontrado. Usando defaults.") 
    end
    return controls_table 
end

-- ==================================================================================================================================
-- Código REFATORADO do ua.FadeWorks.lua
-- ==================================================================================================================================

-- FADEWORKS
function tensho_fadeworks_gui(subs, sel, ADD, ADP, ak)
    line0 = -1
    for i=1,#subs do
        if subs[i].class=="dialogue" then line0=i-1 break end
    end
    if line0 == -1 then line0 = 0 end
    
    local GUI={
        {x=0,y=2,class="label",label=T("fw_fin")}, 
        {x=1,y=2,width=1,class="floatedit",name="fadein",value=0}, 
        {x=0,y=3,class="label",label=T("fw_fout")}, 
        {x=1,y=3,width=1,class="floatedit",name="fadeout",value=0}, 
        
        {x=2,y=2,class="checkbox",name="crl",label=T("fw_from")}, 
        {x=3,y=2,class="color",name="c1", value="&HFFFFFF&"}, 

        {x=2,y=3,class="checkbox",name="clr",label=T("fw_to")}, 
        {x=3,y=3,class="color",name="c2", value="&H000000&"}, 

        {x=0,y=4,class="label",label=T("fw_byltr")}, 
        {x=1,y=4,width=1, class="dropdown",name="letterfade",items={"40","80","120","160","200","250","300","350","400","450","500","750","1000","1250","1500"},value="200"}, 
        {x=2,y=4,width=1,class="label",label=T("fw_msltr")}, 
        {x=3,y=4,width=2,class="dropdown", name="byletter_dir", items={T("fw_dir_ltr"), T("fw_dir_rtl"), T("fw_dir_m2o"), T("fw_dir_o2m")}, value=T("fw_dir_ltr"), hint=T("fw_hint")}, 
        
        {x=0,y=5,width=3,class="label",label=""},

        {x=0,y=0,width=2,class="label",label=T("fw_title")},
        {x=2,y=0,width=2,class="checkbox",name="alf",label=T("fw_alf")},
        {x=4,y=0,width=2,class="checkbox",name="rem",label=T("rem_last"), value=true},  

        {x=0,y=1,width=3,class="label",label=""}
    }
    
    GUI = loadconfig_fadeworks(GUI, ADP) 

    if faded and res and res.rem then 
        --logg("Restaurando configurações da última execução do FadeWorks nesta sessão.")
        for _, control in ipairs(GUI) do
            if control.name and res[control.name] ~= nil then 
                 control.value = res[control.name] 
            end
        end
        for _, control in ipairs(GUI) do if control.name == "rem" then control.value = res.rem end end
    end
    
    P, res = ADD(GUI, {T("btn_apply"), T("fw_btn_byltr"), T("btn_back"), T("btn_help"), T("btn_cancel")}, {ok=T("btn_apply"), cancel=T("btn_cancel")})
    if P == T("btn_back") then 
        return "BACK" 
    end

    if P == T("btn_help") then
        abrir_help()
        return tensho_fadeworks_gui(subs, sel, ADD, ADP, ak)
    end

    if not P or P == T("btn_cancel") then 
        if ak then ak() else aegisub.cancel() end 
        return sel 
    end

    res.inn = res.inn or 1
    res.utt = res.utt or 1
    res.tai = res.tai or 1
    res.tao = res.tao or 1
    res.tgin = res.tgin or 0
    res.tgout = res.tgout or 0

    fr2ms=aegisub.ms_from_frame
	ms2fr=aegisub.frame_from_ms
	
	tagcheck() 
	
    fadin=tonumber(res.fadein) or 0
	fadout=tonumber(res.fadeout) or 0
	faded=true
	
	if TAGS and fadin>0 or TAGS and fadout>0 then res.alf=true end
	
    if P==T("btn_apply") then
		if res.alf or TAGS or res.clr or res.crl then 
            --logg("tensho_fadeworks_gui: ANTES de chamar fadalpha.")
            --logg("tensho_fadeworks_gui: Tipo de 'subs': " .. type(subs))
            --if type(subs) == "table" then logg("tensho_fadeworks_gui: Tamanho de 'subs': " .. #subs) end
            fadalpha(subs,sel) 
		elseif res.mult then 
            fadeacross(subs,sel) 
		elseif res.vin or res.vout then 
            vfade(subs,sel) 
		else 
            fade(subs,sel) 
        end
	end
	if P==T("fw_btn_byltr") then 
        if res.ko or res.word then 
            t_error("\\ko fade não implementado (requer karaskel.lua).", false, ADD, ADP, ak)
        else 
            fade(subs,sel) 
        end 
    end
	
    return sel
end
