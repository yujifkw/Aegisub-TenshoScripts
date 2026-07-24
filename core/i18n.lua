-- version: 1.0.0

i18n = {
    pt = {
        -- Comuns
        btn_apply = "Aplicar", btn_cancel = "Cancelar", btn_back = "Voltar", btn_help = "Ajuda",
        rem_last = "Lembrar Último", btn_exec = "Executar", btn_dl = "Baixar Update",
        
        -- Nomes das Ferramentas
        tool_fade = "Fadeworks", tool_grad = "Gradiente", tool_flash = "Piscadas", tool_trans = "Transformar",
        tool_textfx = "Texto & Fontes FX", tool_split = "Dividir Linhas", tool_ytkt = "YtktFade", tool_fix = "Fixar Linhas",
        tool_glitch = "Glitch", tool_revk = "Karaoke Reverso", tool_curves = "Curvas (BETA)", tool_rain = "Onda Arco-Íris",
        tool_counter = "Contador", tool_shake = "Shake", tool_karafx = "Karaoke FX", tool_ctrack = "Tracker de Cor",
        tool_trad = "Tradutor",
        
        -- Master GUI
        master_title = "TenshoScripts v", master_update = "⚠️ Novo Update Disponível: v",
        denied_title = "TENSHOSCRIPTS: ACESSO NEGADO ou SEM INTERNET", denied_msg1 = "Ferramenta Exclusiva. ID não validado.", 
        denied_msg2 = "Copie o ID e envie para @otenshy no Discord.", btn_copy = "Copiar ID",
        
        -- Fadeworks
        fw_title = "TenshoScripts: FadeWorks", fw_fin = "Fade in:", fw_fout = "Fade out:",
        fw_from = "De:", fw_to = "Para:", fw_byltr = "Por letra:", fw_msltr = "ms/ltr",
        fw_alf = "Alpha/Cor", fw_btn_byltr = "Por &Letra", fw_hint = "Direção do fade por letra",
        fw_dir_ltr = "LTR", fw_dir_rtl = "RTL", fw_dir_m2o = "Meio->Fora", fw_dir_o2m = "Fora->Meio",
        fw_warn = "Fade in (tempo total ou por letra) deve ser pelo menos 1ms para \\ko.",

        -- Gradient
        g_title = "TenshoScripts: Gradiente", g_hsl = "Interpolar HSL", g_apply = "Aplicar em:",
        g_c1 = "\\c (Primária)", g_c3 = "\\3c (Borda)", g_c4 = "\\4c (Sombra)",
        g_p1 = "Cor Chave 1 (Início)", g_p2 = "Cor Chave 2 (Fim)",
        g_i1 = "Cor Intermediaria 1", g_i2 = "Cor Intermediaria 2", g_i3 = "Cor Intermediaria 3",
        btn_styles = "Estilos", g_warn = "Selecione ao menos UMA linha para aplicar o gradiente.",
        g_pri = "Primária:", g_bor = "Borda:", g_shad = "Sombra:",

        -- Gradient Styles
        gs_title = "TenshoScripts: Gradiente entre Estilos", gs_s1 = "Estilo Inicial (A):", gs_s2 = "Estilo Final (B):", 
        gs_s3 = "Usar Interm.(C):", gs_props = "Propriedades para Transição:", gs_colors = "Cores (1c, 2c, 3c, 4c)", gs_sizes = "Tamanhos (fs)",
        
        -- FixLines
        fx_title = "TenshoScripts: Fixar Linhas", fx_force = "Forçar alinhamento (\\an5)", 
        fx_newx = "Novo X (Âncora):", fx_newy = "Novo Y (Âncora):", fx_ref = "Referência atual: ", btn_pos = "Posicionar",
        
        -- Split Lines
        sp_title = "TenshoScripts: Dividir Linhas", sp_mode = "Dividir por:", sp_char = "Caractere", sp_word = "Palavra", btn_split = "Dividir",
        
        -- YtktFade
        yk_title = "TenshoScripts: YtktFade", yk_add = "Ativar \\2c:",
        
        -- Flashes
        fl_title = "TenshoScripts: Piscadas", fl_col = "Cor do Flash:", fl_int = "Intervalo (ms):", 
        fl_smooth = "Suavizar (Fade)", fl_apply  = "Aplicar em:",
        fl_c1 = "\\c (Primária)", fl_c2 = "\\2c (Secundária)", fl_c3 = "\\3c (Borda)", fl_c4 = "\\4c (Sombra)",
        
        -- Transform
        tr_title = "TenshoScripts: Transformar (\\t)", tr_st = "Início (ms):", tr_et = "Fim (ms):", 
        tr_targ = "Alvos de Cor", tr_prim = "Primária (\\1c):", tr_sec = "Secundária (\\2c):", tr_bord = "Borda (\\3c):", tr_shad = "Sombra (\\4c):",
        tr_sizealf = "Tamanho e Alpha", tr_size = "Tamanho (\\fs):", tr_alf = "Alpha (\\alpha):", tr_to = "para",
        
        -- Text & Font FX
        tf_title = "TenshoScripts: Texto && Fontes FX", tf_mode = "Selecionar Efeito:",
        tf_m_rf = "Variar Fontes", tf_m_inv = "Inverter Letras", tf_m_type = "Máquina de escrever", tf_m_unscr = "Embaralhar", tf_m_sym = "Símbolos (@#$)",
        tf_p_sym = ">> Símbolos (@#$):", tf_step = "Fatiamento (ms):", tf_speed = "Vel. (ms/char):",
        tf_p_inv = ">> Inverter Letras:", tf_inv_dir = "Direção Inversão:",
        tf_opt_x = "Horizontal (X)", tf_opt_y = "Vertical (Y)", tf_opt_xy = "Ambos (X+Y)",
        tf_p_rf = ">> Variar Fontes:", tf_rf_char = "Variar por Caractere", tf_var = "Variar Tamanho:", 
        tf_p_tu = ">> Máquina de escrever && Embaralhar:", tf_dyn = "Centralizar",

        -- Contador
        ct_title = "TenshoScripts: Contador Numérico",
        ct_start = "Início:", ct_end = "Fim:",
        ct_from = "De:", ct_to = "Para:",
        ct_style = "Estilo:",
        ct_dur = "Duração (ms):", ct_dur_hint = "0 = duração da linha",
        ct_px = "Pos X:", ct_py = "Pos Y:",
        ct_an5 = "Adicionar \\an5",
        ct_header = "Contagem de %d a %d",
        ct_adv_btn = "Avançado",
        ct_adv_title = "TenshoScripts: Transformações Avançadas",
        ct_fs = "Tamanho (\\fs):",
        ct_c1 = "Primária (\\c):", ct_c3 = "Borda (\\3c):", ct_c4 = "Sombra (\\4c):",
        ct_alpha = "Alpha:",
        ct_mirror = "Espelhar X",
        
        -- Shake
        sk_title = "TenshoScripts: Shake",
        sk_varx = "Offset X (px):", sk_vary = "Offset Y (px):",
        sk_dur = "Duração (ms):", sk_type = "Tipo:",
        sk_start = "Start", sk_end = "End", sk_both = "Both", sk_always = "Always",
        sk_int = "Intervalo (ms):", sk_edge = "Início/Fim originais",

        -- Color Tracker
        trk_title = "TenshoScripts x Zahuczkys: Color Tracker (Pixel)",
        trk_px = "Posição X:", trk_py = "Posição Y:",
        trk_apply = "Aplicar em:",
        trk_c1 = "\\c (Fill)", trk_c2 = "\\2c", trk_c3 = "\\3c (Border)", trk_c4 = "\\4c (Shadow)",
        trk_prog = "Lendo cores do frame %d/%d",
        trk_err_vid = "Erro: Nenhum vídeo carregado no Aegisub. O Color Tracker precisa do vídeo aberto.",
        trk_err_ff = "Erro ao ler os pixels do FFMPEG. Verifique se o ffmpeg está nas Variáveis de Ambiente do Windows.",
        
        -- Glitch
        gl_title = "TenshoScripts: Glitch", gl_offx = "Desvio X (px):", gl_offy = "Desvio Y (px):",
        gl_dur = "Duração (ms):", gl_varfs = "Variação \\fs:", gl_type = "Tipo:", 
        gl_opt_alw = "Sempre", gl_opt_st = "Começo", gl_opt_end = "Final", gl_opt_bo = "Ambos",
        gl_rndp = "Posição Aleatória (Caos)", gl_bold = "Negrito", gl_ital = "Itálico", gl_rndf = "Variar Fontes", gl_chaos = "Símbolos (@#$)",
        gl_auto = "Colores Automáticas (Estilo)", gl_left = "Esquerda (C2):", gl_right = "Direita (C3):", gl_cent = "Centro (C1):", gl_c4 = "Ativar C4:",
        btn_kara = "Karaoke", btn_revk = "KReverso", gl_del = "Centralizar Karaoke",
        gl_preset = "Preset:",
        gl_custom = "Custom", gl_opaque = "Opaco", gl_horiz = "Horizontal", gl_vert = "Vertical", gl_chaoss = "Caos",
        gl_timer1 = "Timer 1", gl_timer2 = "Timer 2",

        -- Rainbow Wave
        rw_title = "TenshoScripts: Onda Arco-Íris", rw_dir = "Direção:",
        rw_dir_ltr = "LTR", rw_dir_rtl = "RTL", rw_dir_m2o = "Meio->Fora", rw_dir_o2m = "Fora->Meio",
        rw_step = "Fatiamento (ms):", rw_speed = "Velocidade (ms/char):",
        rw_width = "Largura Onda (ms):", rw_delay = "Atraso Início (ms):", rw_targets = "Alvos de Cor:",
        rw_use_style = "Usar Cor do Estilo",
        rw_over_grad = "Aplicar sobre gradiente (Preservar)",

        -- Curves
        cv_title = "TenshoScripts: Curvas (BETA)", cv_mode = "Modo:",
        cv_lin = "Linear", cv_ein = "Ease In", cv_eout = "Ease Out", cv_eio = "Ease In-Out",
        cv_cubic = "Usar Cubic", cv_step = "Fatiamento (ms):",
        cv_adv = "Avançado", cv_adv_title = "TenshoScripts: Curvas - Modo Bézier",
        cv_p1 = "Ponto 1 (x,y):", cv_p2 = "Ponto 2 (x,y):", cv_presets = "Presets:", cv_man = "Manual",
        
        -- Reverse Karaoke
        rk_log_line = "Linha #", rk_err_nok = " não possui tags de karaoke. Pulando.\n",
        
        -- KaraFX (Anim)
        kf_title = "TenshoScripts: Karaoke FX",
        kf_fade = "1. Fade de Cor",
        kf_cstart = "Cor (Surgimento):",
        kf_move = "2. Movimento (Move)",
        kf_dir = "Direção:",
        kf_up = "Cima", kf_down = "Baixo", kf_left = "Esquerda", kf_right = "Direita",
        kf_dist = "Distância (px):",
        kf_dur = "Duração (ms):",
        kf_hint_dur = "Deixe 0 para usar o tempo do \\k",
        kf_btn_rev = "ReverseK",
        kf_grad = "Preservar Gradiente",

        -- Configurações (Settings)
        cfg_title = "CONFIGURAÇÕES DO TENSHOSCRIPTS",
        cfg_lang = "Idioma / Language:",
        cfg_alpha = "Modo Transparência (Alpha):",
        cfg_alpha_100 = "0% a 100%",
        cfg_alpha_hex = "Hexadecimal",
        cfg_update = "Buscar atualizações automaticamente ao abrir",
        btn_save = "Salvar",
        btn_settings = "Config.",
        lang_pt = "Português (PT-BR)",
        lang_en = "English (EN)",

        -- Tradutor
        tr_title = "TenshoScripts: Tradução Inteligente",
        tr_lang = "Idioma de Destino:",
        tr_en = "Inglês",
        tr_pt = "Português (BR)",
        tr_es = "Espanhol",
        tr_ja = "Japonês",
        tr_fr = "Francês",
        tr_de = "Alemão",
        tr_it = "Italiano",
        tr_ru = "Russo",
        tr_ko = "Coreano",
        tr_err_cloud = "Erro de segurança: O motor de tradução não foi carregado."
    },
    en = {
        -- Comuns
        btn_apply = "Apply", btn_cancel = "Cancel", btn_back = "Back", btn_help = "Help",
        rem_last = "Remember Last", btn_exec = "Execute", btn_dl = "Download Update",
        
        -- Nomes das Ferramentas
        tool_fade = "Fadeworks", tool_grad = "Gradient", tool_flash = "Flashes", tool_trans = "Transform",
        tool_textfx = "Text & Font FX", tool_split = "Split Lines", tool_ytkt = "YtktFade", tool_fix = "Fix Lines",
        tool_glitch = "Glitch", tool_revk = "Reverse Karaoke", tool_curves = "Curves (BETA)", tool_rain = "Rainbow Wave",
        tool_counter = "Counter", tool_shake = "Shake", tool_karafx = "Karaoke FX", tool_ctrack = "Color Tracker",
        tool_trad = "Translator",
        
        -- Master GUI
        master_title = "TenshoScripts v", master_update = "⚠️ New Update Available: v",
        denied_title = "TENSHOSCRIPTS: ACCESS DENIED or WITHOUT INTERNET", denied_msg1 = "Exclusive Tool. ID not validated.", 
        denied_msg2 = "Copy your ID and send it to @otenshy on Discord.", btn_copy = "Copy ID",
        
        -- Fadeworks
        fw_title = "TenshoScripts: FadeWorks", fw_fin = "Fade in:", fw_fout = "Fade out:",
        fw_from = "From:", fw_to = "To:", fw_byltr = "By letter:", fw_msltr = "ms/ltr",
        fw_alf = "Alpha/Colour", fw_btn_byltr = "By &Letter", fw_hint = "Fade direction by letter",
        fw_dir_ltr = "LTR", fw_dir_rtl = "RTL", fw_dir_m2o = "Mid->Out", fw_dir_o2m = "Out->Mid",
        fw_warn = "Fade in (total time or per letter) must be at least 1ms for \\ko.",

        -- Gradient
        g_title = "TenshoScripts: Gradient", g_hsl = "Interpolate HSL", g_apply = "Apply to:",
        g_c1 = "\\c (Primary)", g_c3 = "\\3c (Border)", g_c4 = "\\4c (Shadow)",
        g_p1 = "Key Color 1 (Start)", g_p2 = "Key Color 2 (End)",
        g_i1 = "Mid Color 1", g_i2 = "Mid Color 2", g_i3 = "Mid Color 3",
        btn_styles = "Styles", g_warn = "Select at least ONE row to apply the gradient.",
        g_pri = "Primary:", g_bor = "Outline:", g_shad = "Shadow:",

        -- Gradient Styles
        gs_title = "TenshoScripts: Gradient between Styles", gs_s1 = "Initial Style (A):", gs_s2 = "Final Style (B):", 
        gs_s3 = "Use Mid (C):", gs_props = "Properties to Transition:", gs_colors = "Colors (1c, 2c, 3c, 4c)", gs_sizes = "Sizes (fs, bord, shad)",
        
        -- FixLines
        fx_title = "TenshoScripts: FixLines", fx_force = "Force align (\\an5)", 
        fx_newx = "New X (Anchor):", fx_newy = "New Y (Anchor):", fx_ref = "Current reference:", btn_pos = "Position",
        
        -- Split Lines
        sp_title = "TenshoScripts: Split Lines", sp_mode = "Split by:", sp_char = "Character", sp_word = "Word", btn_split = "Split",
        
        -- YtktFade
        yk_title = "TenshoScripts: YtktFade", yk_add = "Enable \\2c:",
        
        -- Flashes
        fl_title = "TenshoScripts: Flashes", fl_col = "Flash Color:", fl_int = "Interval (ms):", 
        fl_smooth = "Smooth (Fade)", fl_apply  = "Apply to:",
        fl_c1 = "\\c (Primary)", fl_c2 = "\\2c (Secondary)", fl_c3 = "\\3c (Outline)", fl_c4 = "\\4c (Shadow)",
        
        -- Transform
        tr_title = "TenshoScripts: Transform (\\t)", tr_st = "Start (ms):", tr_et = "End (ms):", 
        tr_targ = "Color Targets", tr_prim = "Primary (\\1c):", tr_sec = "Secondary (\\2c):", tr_bord = "Border (\\3c):", tr_shad = "Shadow (\\4c):",
        tr_sizealf = "Size and Alpha", tr_size = "Size (\\fs):", tr_alf = "Alpha (\\alpha):", tr_to = "to",
        
        -- Text & Font FX
        tf_title = "TenshoScripts: Text && Fonts FX", tf_mode = "Select Effect:",
        tf_m_rf = "Random Fonts", tf_m_inv = "Invert Letters", tf_m_type = "Typewriter", tf_m_unscr = "Unscramble", tf_m_sym = "Symbols (@#$)",
        tf_p_sym = ">> Symbols (@#$):", tf_step = "Slice Step (ms):", tf_speed = "Speed (ms/char):",
        tf_p_inv = ">> Invert Letters:", tf_inv_dir = "Invert Direction:",
        tf_opt_x = "Horizontal (X)", tf_opt_y = "Vertical (Y)", tf_opt_xy = "Both (X+Y)",
        tf_p_rf = ">> Random Fonts:", tf_rf_char = "Vary by Character", tf_var = "Size Variation:", 
        tf_p_tu = ">> Typewriter && Unscramble:", tf_dyn = "Center",

        -- Counter
        ct_title = "TenshoScripts: Number Counter",
        ct_start = "Start:", ct_end = "End:",
        ct_from = "From:", ct_to = "To:",
        ct_style = "Style:",
        ct_dur = "Duration (ms):", ct_dur_hint = "0 = line duration",
        ct_px = "Pos X:", ct_py = "Pos Y:",
        ct_an5 = "Auto-add \\an5",
        ct_header = "Counting from %d to %d",
        ct_adv_btn = "Advanced",
        ct_adv_title = "TenshoScripts: Advanced Transformations",
        ct_fs = "Size (\\fs):",
        ct_c1 = "Primary (\\c):", ct_c3 = "Border (\\3c):", ct_c4 = "Shadow (\\4c):",
        ct_alpha = "Alpha:",
        ct_mirror = "Mirror X",
        
        -- Shake
        sk_title = "TenshoScripts: Shake",
        sk_varx = "Offset X (px):", sk_vary = "Offset Y (px):",
        sk_dur = "Duration (ms):", sk_type = "Type:",
        sk_start = "Start", sk_end = "End", sk_both = "Both", sk_always = "Always",
        sk_int = "Interval (ms):", sk_edge = "Orig. Start/End",

        -- Color Tracker
        trk_title = "TenshoScripts x Zahuczkys: Color Tracker (Pixel)",
        trk_px = "Position X:", trk_py = "Position Y:",
        trk_apply = "Apply to:",
        trk_c1 = "\\c (Fill)", trk_c2 = "\\2c", trk_c3 = "\\3c (Border)", trk_c4 = "\\4c (Shadow)",
        trk_prog = "Reading colors from frame %d/%d",
        trk_err_vid = "Error: No video loaded in Aegisub. Color Tracker requires an active video.",
        trk_err_ff = "Error reading pixels from FFMPEG. Check if ffmpeg is in your Windows Environment Variables.",

        -- Glitch
        gl_title = "TenshoScripts: Glitch", gl_offx = "Offset X (px):", gl_offy = "Offset Y (px):",
        gl_dur = "Duration (ms):", gl_varfs = "Variation \\fs:", gl_type = "Type:", 
        gl_opt_alw = "Always", gl_opt_st = "Start", gl_opt_end = "End", gl_opt_bo = "Both",
        gl_rndp = "Random Pos (Chaos)", gl_bold = "Bold", gl_ital = "Italic", gl_rndf = "Vary Fonts", gl_chaos = "Symbols (@#$)",
        gl_auto = "Auto Colors (Style)", gl_left = "Left (C2):", gl_right = "Right (C3):", gl_cent = "Center (C1):", gl_c4 = "Enable C4:",
        btn_kara = "Karaoke", btn_revk = "ReverseK", gl_del = "Center Karaoke",
        gl_preset = "Preset:",
        gl_custom = "Custom", gl_opaque = "Opaque", gl_horiz = "Horizontal", gl_vert = "Vertical", gl_chaoss = "Chaos",
        gl_timer1 = "Timer 1", gl_timer2 = "Timer 2",

        -- Rainbow Wave
        rw_title = "TenshoScripts: Rainbow Wave", rw_dir = "Direction:",
        rw_dir_ltr = "LTR", rw_dir_rtl = "RTL", rw_dir_m2o = "Mid->Out", rw_dir_o2m = "Out->Mid",
        rw_step = "Slice Step (ms):", rw_speed = "Speed (ms/char):",
        rw_width = "Wave Width (ms):", rw_delay = "Start Delay (ms):", rw_targets = "Color Targets:",
        rw_use_style = "Use Style Color",
        rw_over_grad = "Apply over gradient (Preserve)",

        -- Curves
        cv_title = "TenshoScripts: Curves (BETA)", cv_mode = "Mode:",
        cv_lin = "Linear", cv_ein = "Ease In", cv_eout = "Ease Out", cv_eio = "Ease In-Out",
        cv_cubic = "Use Cubic", cv_step = "Slice Step (ms):",
        cv_adv = "Advanced", cv_adv_title = "TenshoScripts: Curves - Bézier Mode",
        cv_p1 = "Point 1 (x,y):", cv_p2 = "Point 2 (x,y):", cv_presets = "Presets:", cv_man = "Manual",
        
        -- Reverse Karaoke
        rk_log_line = "Line #", rk_err_nok = " has no karaoke tags. Skipping.\n",
        
        -- KaraFX (Anim)
        kf_title = "TenshoScripts: Karaoke FX",
        kf_fade = "1. Color Fade",
        kf_cstart = "Color (Spawn):",
        kf_move = "2. Movement (Move)",
        kf_dir = "Direction:",
        kf_up = "Up", kf_down = "Down", kf_left = "Left", kf_right = "Right",
        kf_dist = "Distance (px):",
        kf_dur = "Duration (ms):",
        kf_hint_dur = "Leave 0 to use \\k time",
        kf_btn_rev = "ReverseK",
        kf_grad = "Preserve Gradient",

        -- Configurações (Settings)
        cfg_title = "TENSHOSCRIPTS SETTINGS",
        cfg_lang = "Language / Idioma:",
        cfg_alpha = "Transparency Mode (Alpha):",
        cfg_alpha_100 = "0% to 100%",
        cfg_alpha_hex = "Hexadecimal",
        cfg_update = "Check for updates automatically on startup",
        btn_save = "Save",
        btn_settings = "Settings",
        lang_pt = "Português (PT-BR)",
        lang_en = "English (EN)",

        -- Tradutor
        tr_title = "TenshoScripts: Smart Translation",
        tr_lang = "Target Language:",
        tr_en = "English",
        tr_pt = "Portuguese (BR)",
        tr_es = "Spanish",
        tr_ja = "Japanese",
        tr_fr = "French",
        tr_de = "German",
        tr_it = "Italian",
        tr_ru = "Russian",
        tr_ko = "Korean",
        tr_err_cloud = "Security error: The translation engine was not loaded."
    }
}

function T(key)
    if i18n[script_language] and i18n[script_language][key] then
        return i18n[script_language][key]
    end
    return key
end
