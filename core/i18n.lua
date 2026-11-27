-- version: 1.1.6

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
        trk_smooth = "Transição suave entre frames",
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
        rw_sec_wave = "— Onda Arco-Íris —", rw_sec_abs = "— Abstrato (gradientes da paleta) —", rw_btn_abs = "Abstrato", rw_ab_col = "Cor", rw_ab_dir = "Direção:",
        rw_ab_n = "Ondas:", rw_ab_size = "Tamanho (letras):", rw_ab_speed = "Velocidade (%):",

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
        kf_drift = "3. Movimento Contínuo", kf_d_period = "Período (ms):", kf_d_x = "Amplitude X (px):",
        kf_d_y = "Amplitude Y (px):", kf_d_step = "Fatiamento (ms):", kf_d_jit = "Travado (saltos aleatórios)", kf_d_min = "Salto mínimo (px):",

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
        trd_title = "TenshoScripts: Tradução Inteligente",
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
        tr_err_cloud = "Erro de segurança: O motor de tradução não foi carregado.",
        tr_style = "Contexto/estilo (opcional):", tr_gem_key = "Chave Gemini própria (opcional):",
        tr_prog = "Traduzindo %d/%d...", tr_none = "Aviso: nenhuma linha com texto visível foi selecionada.",
        tr_err_net = "Erro: sem resposta do servidor de tradução. Verifique sua internet.",
        tr_err_timeout = "O servidor de tradução demorou demais para responder (a IA está sobrecarregada). Tente de novo em alguns minutos ou use sua própria chave Gemini gratuita.",
        tr_err_auth = "Erro: licença não autorizada para o tradutor (chave inválida, revogada ou outra máquina).",
        tr_err_quota = "Você atingiu a cota diária de tradução. Tente amanhã ou cole sua própria chave Gemini gratuita (aistudio.google.com/apikey) no campo da janela.",
        tr_err_busy = "O tradutor compartilhado está ocupado ou esgotou o limite de hoje. Tente em alguns minutos ou use sua própria chave Gemini gratuita.",
        tr_err_bad_output = "A IA devolveu um resultado inválido. Tente novamente.",
        tr_err_bad_ai_key = "A chave Gemini informada foi recusada. Confira o campo ou apague-o para usar a cota compartilhada.",
        tr_err_no_ai = "O tradutor compartilhado ainda não foi configurado no servidor.",
        tr_err_ai = "A IA recusou o pedido (detalhe abaixo). Se persistir, envie esta mensagem para @otenshy.",
        tr_err_id = "Erro: não foi possível identificar esta máquina/licença. Abra o tradutor pelo TenshoScripts."
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
        trk_smooth = "Smooth transition between frames",
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
        rw_sec_wave = "— Rainbow Wave —", rw_sec_abs = "— Abstract (palette gradients) —", rw_btn_abs = "Abstract", rw_ab_col = "Color", rw_ab_dir = "Direction:",
        rw_ab_n = "Waves:", rw_ab_size = "Size (letters):", rw_ab_speed = "Speed (%):",

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
        kf_drift = "3. Continuous Motion", kf_d_period = "Period (ms):", kf_d_x = "Amplitude X (px):",
        kf_d_y = "Amplitude Y (px):", kf_d_step = "Slice Step (ms):", kf_d_jit = "Choppy (random jumps)", kf_d_min = "Min. jump (px):",

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
        trd_title = "TenshoScripts: Smart Translation",
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
        tr_err_cloud = "Security error: The translation engine was not loaded.",
        tr_style = "Context/style (optional):", tr_gem_key = "Your own Gemini key (optional):",
        tr_prog = "Translating %d/%d...", tr_none = "Warning: no line with visible text was selected.",
        tr_err_net = "Error: no response from the translation server. Check your internet.",
        tr_err_timeout = "The translation server took too long to answer (the AI is overloaded). Try again in a few minutes or use your own free Gemini key.",
        tr_err_auth = "Error: license not authorized for the translator (invalid key, revoked, or another machine).",
        tr_err_quota = "You reached the daily translation quota. Try tomorrow or paste your own free Gemini key (aistudio.google.com/apikey) in the dialog field.",
        tr_err_busy = "The shared translator is busy or hit today's limit. Try again in a few minutes or use your own free Gemini key.",
        tr_err_bad_output = "The AI returned an invalid result. Try again.",
        tr_err_bad_ai_key = "The Gemini key you entered was rejected. Check the field or clear it to use the shared quota.",
        tr_err_no_ai = "The shared translator is not configured on the server yet.",
        tr_err_ai = "The AI rejected the request (details below). If it persists, send this message to @otenshy.",
        tr_err_id = "Error: could not identify this machine/license. Open the translator through TenshoScripts."
    }
}

-- =====================================================================
-- DICAS AO PASSAR O MOUSE (hints)
-- Chave: h_<prefixo da ferramenta>_<name do controle>. Usadas por tensho_add_hints (globals.lua).
-- =====================================================================
local tensho_hints = {
    pt = {
        h_rem_last = "Guarda estas opções e reabre a janela com elas na próxima vez.",

        -- Menu principal e Configurações
        h_master_tool_select = "Escolha a ferramenta e clique em Executar (ou aperte Enter).",
        h_cfg_cfg_lang = "Idioma das janelas do TenshoScripts.",
        h_cfg_cfg_alpha = "Como os campos de transparência aparecem: 0 a 100% ou hexadecimal (00 a FF).",
        h_cfg_cfg_update = "Ao abrir o TenshoScripts, verifica se há versões novas das ferramentas.",

        -- FadeWorks
        h_fw_fadein = "Duração do fade de entrada, em ms (0 = sem fade de entrada).",
        h_fw_fadeout = "Duração do fade de saída, em ms (0 = sem fade de saída).",
        h_fw_crl = "O fade de entrada começa na cor ao lado, em vez de começar transparente.",
        h_fw_c1 = "Cor inicial do fade de entrada.",
        h_fw_clr = "O fade de saída termina na cor ao lado, em vez de terminar transparente.",
        h_fw_c2 = "Cor final do fade de saída.",
        h_fw_letterfade = "Atraso entre uma letra e a próxima no fade por letra (botão Por Letra), em ms.",
        h_fw_alf = "Usa \\alpha e \\t em vez de \\fad. Necessário para fade de cor; liga sozinho ao marcar De/Para.",

        -- Gradiente
        h_g_use_hsl = "Mistura as cores pelo matiz (HSL) em vez de RGB: transições mais vivas, sem tons acinzentados no meio.",
        h_g_target_c1 = "Aplica o gradiente na cor primária (\\c).",
        h_g_target_c3 = "Aplica o gradiente na borda (\\3c).",
        h_g_target_c4 = "Aplica o gradiente na sombra (\\4c).",
        h_g_p1_c1 = "Cor primária no início (esquerda) do gradiente.",
        h_g_p1_c3 = "Cor da borda no início (esquerda) do gradiente.",
        h_g_p1_c4 = "Cor da sombra no início (esquerda) do gradiente.",
        h_g_p2_c1 = "Cor primária no fim (direita) do gradiente.",
        h_g_p2_c3 = "Cor da borda no fim (direita) do gradiente.",
        h_g_p2_c4 = "Cor da sombra no fim (direita) do gradiente.",
        h_g_use_p3 = "Adiciona a cor intermediária 1 ao gradiente.",
        h_g_p3_c1 = "Cor primária da cor intermediária 1.",
        h_g_p3_c3 = "Cor da borda da cor intermediária 1.",
        h_g_p3_c4 = "Cor da sombra da cor intermediária 1.",
        h_g_use_p4 = "Adiciona a cor intermediária 2 ao gradiente.",
        h_g_p4_c1 = "Cor primária da cor intermediária 2.",
        h_g_p4_c3 = "Cor da borda da cor intermediária 2.",
        h_g_p4_c4 = "Cor da sombra da cor intermediária 2.",
        h_g_use_p5 = "Adiciona a cor intermediária 3 ao gradiente.",
        h_g_p5_c1 = "Cor primária da cor intermediária 3.",
        h_g_p5_c3 = "Cor da borda da cor intermediária 3.",
        h_g_p5_c4 = "Cor da sombra da cor intermediária 3.",

        -- Gradiente entre Estilos
        h_gs_s1 = "Estilo do começo do gradiente.",
        h_gs_s2 = "Estilo do fim do gradiente.",
        h_gs_use_s3 = "Passa também por um terceiro estilo no meio do gradiente.",
        h_gs_s3 = "Estilo do meio do gradiente.",
        h_gs_t_colors = "Faz a transição das cores (\\1c a \\4c) entre os estilos.",
        h_gs_t_sizes = "Faz a transição do tamanho da fonte (\\fs) entre os estilos.",

        -- Fixar Linhas
        h_fx_force_an5 = "Troca o alinhamento da linha para \\an5 (centro) antes de posicionar.",
        h_fx_target_x = "Posição horizontal (X) onde a linha será fixada.",
        h_fx_target_y = "Posição vertical (Y) onde a linha será fixada.",

        -- Dividir Linhas
        h_sp_mode = "Cria uma linha para cada caractere ou para cada palavra, mantendo a posição original.",

        -- YtktFade
        h_yk_add_2c = "Também define a cor secundária (\\2c), a cor do texto antes de o karaokê preencher.",
        h_yk_color_2c = "Cor secundária (\\2c) aplicada às linhas.",

        -- Piscadas
        h_fl_flash_color = "Cor que pisca alternando com a cor original.",
        h_fl_interval = "Duração de cada piscada, em ms (mínimo 20).",
        h_fl_smoothing = "Transição suave entre as cores, em vez de troca seca.",
        h_fl_target_c1 = "Pisca a cor primária (\\c).",
        h_fl_target_c2 = "Pisca a cor secundária (\\2c).",
        h_fl_target_c3 = "Pisca a borda (\\3c).",
        h_fl_target_c4 = "Pisca a sombra (\\4c).",

        -- Transformar
        h_tr_t_start = "Quando a transformação começa, em ms a partir do início da linha.",
        h_tr_t_end = "Quando a transformação termina, em ms a partir do início da linha.",
        h_tr_use_c1 = "Anima a cor primária (\\1c) até a cor ao lado.",
        h_tr_c1 = "Cor primária final.",
        h_tr_use_c2 = "Anima a cor secundária (\\2c) até a cor ao lado.",
        h_tr_c2 = "Cor secundária final.",
        h_tr_use_c3 = "Anima a borda (\\3c) até a cor ao lado.",
        h_tr_c3 = "Cor final da borda.",
        h_tr_use_c4 = "Anima a sombra (\\4c) até a cor ao lado.",
        h_tr_c4 = "Cor final da sombra.",
        h_tr_use_fs = "Anima o tamanho da fonte (\\fs).",
        h_tr_fs_from = "Tamanho inicial da fonte.",
        h_tr_fs_to = "Tamanho final da fonte.",
        h_tr_use_alpha = "Anima a transparência (\\alpha).",
        h_tr_alpha_from = "Transparência inicial.",
        h_tr_alpha_to = "Transparência final.",

        -- Texto & Fontes FX
        h_tf_mode = "Efeito a aplicar. Só as opções da seção correspondente (>>) são usadas.",
        h_tf_step_rf = "De quantos em quantos ms a fonte muda (40 a 500).",
        h_tf_rf_char = "Sorteia uma fonte para cada letra, em vez de uma para a linha toda.",
        h_tf_size_var = "Varia o tamanho da fonte aleatoriamente em até ± este valor (0 = sem variação).",
        h_tf_step_tu = "De quantos em quantos ms o texto é atualizado (40 a 500).",
        h_tf_speed_tu = "Tempo, em ms, para cada nova letra aparecer.",
        h_tf_dyn_jump = "Mantém centralizado só o texto já escrito, em vez de reservar o espaço das letras que faltam.",
        h_tf_step_sym = "De quantos em quantos ms os símbolos mudam (40 a 500).",
        h_tf_inv_dir = "Eixo em que as letras são espelhadas.",

        -- Contador
        h_ct_v_start = "Número em que a contagem começa.",
        h_ct_v_end = "Número em que a contagem termina.",
        h_ct_px = "Posição horizontal (X) do número.",
        h_ct_py = "Posição vertical (Y) do número.",
        h_ct_use_an5 = "Adiciona \\an5 (centro) para o número não se deslocar quando muda de largura.",
        h_ct_style_name = "Estilo usado nas linhas do contador.",
        h_ct_fs_s = "Tamanho da fonte no início da contagem.",
        h_ct_fs_e = "Tamanho da fonte no fim da contagem.",
        h_ct_c1_s = "Cor primária no início da contagem.",
        h_ct_c1_e = "Cor primária no fim da contagem.",
        h_ct_c3_s = "Cor da borda no início da contagem.",
        h_ct_c3_e = "Cor da borda no fim da contagem.",
        h_ct_c4_s = "Cor da sombra no início da contagem.",
        h_ct_c4_e = "Cor da sombra no fim da contagem.",
        h_ct_a_s = "Transparência no início da contagem.",
        h_ct_a_e = "Transparência no fim da contagem.",
        h_ct_mirror = "Cria uma cópia do contador no lado oposto da tela (X espelhado).",

        -- Shake
        h_sk_amp_x = "Deslocamento horizontal máximo, em px, para cada lado.",
        h_sk_amp_y = "Deslocamento vertical máximo, em px, para cada lado.",
        h_sk_duration = "Quanto tempo o tremor dura, em ms (usado em Start, End e Both).",
        h_sk_type = "Quando tremer: Start = no início, End = no fim, Both = início e fim, Always = a linha toda.",
        h_sk_interval = "Tempo entre cada nova posição, em ms (mínimo 10). Menor = tremor mais rápido.",
        h_sk_force_orig = "Mantém a posição original no primeiro e no último instante do tremor.",

        -- Tracker de Cor
        h_trk_pixX = "Coordenada X do pixel do vídeo cuja cor será seguida.",
        h_trk_pixY = "Coordenada Y do pixel do vídeo cuja cor será seguida.",
        h_trk_c1 = "Aplica a cor do pixel na cor primária (\\c).",
        h_trk_c2 = "Aplica a cor do pixel na cor secundária (\\2c).",
        h_trk_c3 = "Aplica a cor do pixel na borda (\\3c).",
        h_trk_c4 = "Aplica a cor do pixel na sombra (\\4c).",
        h_trk_smooth = "Interpola a cor entre um frame e o outro em vez de trocá-la de uma vez. Evita o efeito travado quando o vídeo final tem mais fps que o do projeto (ex.: render para o YouTube).",

        -- Glitch
        h_gl_offset = "Deslocamento horizontal máximo das cópias coloridas, em px.",
        h_gl_y_off = "Deslocamento vertical máximo das cópias, em px (0 = só horizontal).",
        h_gl_glitch_dur = "Duração de cada surto de glitch, em ms.",
        h_gl_fs_var = "Variação aleatória do tamanho da fonte (\\fs) durante o glitch (0 = sem variação).",
        h_gl_glitch_type = "Quando o glitch acontece: sempre, só no começo, só no final ou nos dois.",
        h_gl_preset = "Combinações prontas. Custom usa os valores que você definiu.",
        h_gl_bold = "Inclui negrito no glitch.",
        h_gl_italic = "Inclui itálico no glitch.",
        h_gl_random_font = "Troca a fonte aleatoriamente durante o glitch.",
        h_gl_chaos_sym = "Troca letras por símbolos (@#$) durante o glitch.",
        h_gl_auto_style = "Usa as cores do estilo da linha em vez das cores abaixo.",
        h_gl_c2 = "Cor da cópia deslocada para a esquerda.",
        h_gl_a2 = "Transparência da cópia da esquerda.",
        h_gl_c3 = "Cor da cópia deslocada para a direita.",
        h_gl_a3 = "Transparência da cópia da direita.",
        h_gl_c1 = "Cor da cópia do centro.",
        h_gl_a1 = "Transparência da cópia do centro.",
        h_gl_use_c4 = "Adiciona uma quarta cópia colorida.",
        h_gl_c4 = "Cor da quarta cópia.",
        h_gl_a4 = "Transparência da quarta cópia.",
        h_gl_del_syls = "Nos modos Karaoke e KReverso, remove as sílabas ainda ocultas, centralizando só o texto visível.",

        -- Onda Arco-Íris
        h_rw_dir = "Direção em que a onda de cores percorre o texto.",
        h_rw_use_style = "Usa a cor do estilo escolhido ao lado como base da onda.",
        h_rw_style_sel = "Estilo de onde vem a cor base.",
        h_rw_step = "De quantos em quantos ms a cor é atualizada (40 a 100). Menor = mais suave, porém mais linhas.",
        h_rw_speed = "Atraso entre uma letra e a próxima, em ms.",
        h_rw_width = "Quanto tempo a onda leva para passar por cada letra, em ms.",
        h_rw_delay = "Espera antes de a onda começar, em ms após o início da linha.",
        h_rw_target_c1 = "Aplica a onda na cor primária (\\c).",
        h_rw_target_c3 = "Aplica a onda na borda (\\3c).",
        h_rw_target_c4 = "Aplica a onda na sombra (\\4c).",
        h_rw_over_grad = "Mantém o gradiente que já existe na linha e aplica a onda por cima.",
        h_rw_ab_n = "Ondulação extra das faixas de cor (1 = faixas retas, até 4 = mais orgânicas). As faixas continuam percorrendo o texto uma atrás da outra.",
        h_rw_ab_dir = "Direção em que as faixas de cor percorrem o texto.",
        h_rw_ab_size = "Largura de cada faixa de cor, em letras. Menor = faixas mais estreitas e mais cores ao mesmo tempo.",
        h_rw_ab_speed = "Velocidade das faixas (100 = meio ciclo da paleta por segundo).",
        h_rw_ab_c1 = "Cor 1 da paleta do modo Abstrato.", h_rw_ab_c2 = "Cor 2 da paleta do modo Abstrato.",
        h_rw_ab_c3 = "Cor 3 da paleta do modo Abstrato.", h_rw_ab_c4 = "Cor 4 da paleta do modo Abstrato.",

        -- Curvas
        h_cv_ease_mode = "Aceleração do \\move: Linear = constante, Ease In = acelera, Ease Out = desacelera, Ease In-Out = os dois.",
        h_cv_use_cubic = "Curva cúbica: aceleração mais acentuada.",
        h_cv_step = "De quantos em quantos ms a posição é recalculada (40 a 100). Menor = mais suave, porém mais linhas.",
        h_cv_bx1 = "X do ponto de controle 1 da curva de Bézier (0 a 1).",
        h_cv_by1 = "Y do ponto de controle 1. Fora de 0 a 1 cria efeito de mola.",
        h_cv_bx2 = "X do ponto de controle 2 da curva de Bézier (0 a 1).",
        h_cv_by2 = "Y do ponto de controle 2. Fora de 0 a 1 cria efeito de mola.",
        h_cv_preset = "Curvas prontas. Manual usa os pontos definidos acima.",

        -- Karaoke FX
        h_kf_fade_en = "Cada sílaba surge vindo da cor abaixo.",
        h_kf_c_start = "Cor com que a sílaba aparece antes de ir para a cor final.",
        h_kf_move_en = "Cada sílaba entra deslizando.",
        h_kf_m_dir = "De que direção a sílaba entra.",
        h_kf_m_dist = "Distância percorrida pela sílaba, em px.",
        h_kf_over_grad = "Mantém o gradiente que já existe na linha.",
        h_kf_drift_en = "Cada sílaba flutua o tempo todo em que fica na tela, de forma independente das outras.",
        h_kf_d_period = "Tempo de um ciclo completo de ida e volta, em ms. Cada sílaba varia um pouco em torno disso.",
        h_kf_d_x = "Quanto a sílaba oscila na horizontal, em px (0 = não move).",
        h_kf_d_y = "Quanto a sílaba oscila na vertical, em px (0 = não move).",
        h_kf_d_step = "De quantos em quantos ms a posição é atualizada (mín. 20). Menor = mais suave, mais linhas.",
        h_kf_d_jit = "Em vez de balançar suave, a sílaba salta para uma posição aleatória (dentro das amplitudes) a cada Fatiamento e fica parada ali, como no GIF de referência. Use um Fatiamento maior (100-200 ms).",
        h_kf_d_min = "Só no modo Travado: distância mínima entre uma posição e a seguinte. Evita saltos tão pequenos que o YouTube não chega a mostrar movimento (limitado ao que as amplitudes permitem). 0 desliga.",

        -- Tradutor
        h_trd_idioma_alvo = "Idioma para o qual as linhas selecionadas serão traduzidas.",
        h_trd_estilo = "Dica para a IA: gênero, tom ou contexto (ex.: música de anime, tom informal, gírias). A letra inteira já é enviada junta para manter o sentido.",
        h_trd_gem_key = "Opcional. Cole uma chave Gemini gratuita (aistudio.google.com/apikey) para não usar a cota compartilhada. Fica salva só neste computador.",
    },
    en = {
        h_rem_last = "Saves these options and reopens the window with them next time.",

        -- Main menu and Settings
        h_master_tool_select = "Pick a tool and click Execute (or press Enter).",
        h_cfg_cfg_lang = "Language of the TenshoScripts windows.",
        h_cfg_cfg_alpha = "How transparency fields are shown: 0 to 100% or hexadecimal (00 to FF).",
        h_cfg_cfg_update = "When TenshoScripts opens, check for new versions of the tools.",

        -- FadeWorks
        h_fw_fadein = "Fade-in duration, in ms (0 = no fade-in).",
        h_fw_fadeout = "Fade-out duration, in ms (0 = no fade-out).",
        h_fw_crl = "The fade-in starts from the color next to it instead of from transparent.",
        h_fw_c1 = "Starting color of the fade-in.",
        h_fw_clr = "The fade-out ends on the color next to it instead of on transparent.",
        h_fw_c2 = "Ending color of the fade-out.",
        h_fw_letterfade = "Delay between one letter and the next in the letter-by-letter fade (By Letter button), in ms.",
        h_fw_alf = "Uses \\alpha and \\t instead of \\fad. Needed for color fades; turns on by itself when From/To is checked.",

        -- Gradient
        h_g_use_hsl = "Blends colors by hue (HSL) instead of RGB: livelier transitions, no grayish tones in between.",
        h_g_target_c1 = "Applies the gradient to the primary color (\\c).",
        h_g_target_c3 = "Applies the gradient to the border (\\3c).",
        h_g_target_c4 = "Applies the gradient to the shadow (\\4c).",
        h_g_p1_c1 = "Primary color at the start (left) of the gradient.",
        h_g_p1_c3 = "Border color at the start (left) of the gradient.",
        h_g_p1_c4 = "Shadow color at the start (left) of the gradient.",
        h_g_p2_c1 = "Primary color at the end (right) of the gradient.",
        h_g_p2_c3 = "Border color at the end (right) of the gradient.",
        h_g_p2_c4 = "Shadow color at the end (right) of the gradient.",
        h_g_use_p3 = "Adds intermediate color 1 to the gradient.",
        h_g_p3_c1 = "Primary color of intermediate color 1.",
        h_g_p3_c3 = "Border color of intermediate color 1.",
        h_g_p3_c4 = "Shadow color of intermediate color 1.",
        h_g_use_p4 = "Adds intermediate color 2 to the gradient.",
        h_g_p4_c1 = "Primary color of intermediate color 2.",
        h_g_p4_c3 = "Border color of intermediate color 2.",
        h_g_p4_c4 = "Shadow color of intermediate color 2.",
        h_g_use_p5 = "Adds intermediate color 3 to the gradient.",
        h_g_p5_c1 = "Primary color of intermediate color 3.",
        h_g_p5_c3 = "Border color of intermediate color 3.",
        h_g_p5_c4 = "Shadow color of intermediate color 3.",

        -- Gradient between Styles
        h_gs_s1 = "Style at the start of the gradient.",
        h_gs_s2 = "Style at the end of the gradient.",
        h_gs_use_s3 = "Also goes through a third style in the middle of the gradient.",
        h_gs_s3 = "Style in the middle of the gradient.",
        h_gs_t_colors = "Transitions the colors (\\1c to \\4c) between the styles.",
        h_gs_t_sizes = "Transitions the font size (\\fs) between the styles.",

        -- Fix Lines
        h_fx_force_an5 = "Switches the line alignment to \\an5 (center) before positioning.",
        h_fx_target_x = "Horizontal position (X) the line will be fixed at.",
        h_fx_target_y = "Vertical position (Y) the line will be fixed at.",

        -- Split Lines
        h_sp_mode = "Creates one line per character or per word, keeping the original position.",

        -- YtktFade
        h_yk_add_2c = "Also sets the secondary color (\\2c), the text color before the karaoke fills it.",
        h_yk_color_2c = "Secondary color (\\2c) applied to the lines.",

        -- Flashes
        h_fl_flash_color = "Color that flashes, alternating with the original color.",
        h_fl_interval = "Length of each flash, in ms (minimum 20).",
        h_fl_smoothing = "Smooth transition between the colors instead of a hard switch.",
        h_fl_target_c1 = "Flashes the primary color (\\c).",
        h_fl_target_c2 = "Flashes the secondary color (\\2c).",
        h_fl_target_c3 = "Flashes the border (\\3c).",
        h_fl_target_c4 = "Flashes the shadow (\\4c).",

        -- Transform
        h_tr_t_start = "When the transform starts, in ms from the start of the line.",
        h_tr_t_end = "When the transform ends, in ms from the start of the line.",
        h_tr_use_c1 = "Animates the primary color (\\1c) to the color next to it.",
        h_tr_c1 = "Final primary color.",
        h_tr_use_c2 = "Animates the secondary color (\\2c) to the color next to it.",
        h_tr_c2 = "Final secondary color.",
        h_tr_use_c3 = "Animates the border (\\3c) to the color next to it.",
        h_tr_c3 = "Final border color.",
        h_tr_use_c4 = "Animates the shadow (\\4c) to the color next to it.",
        h_tr_c4 = "Final shadow color.",
        h_tr_use_fs = "Animates the font size (\\fs).",
        h_tr_fs_from = "Starting font size.",
        h_tr_fs_to = "Final font size.",
        h_tr_use_alpha = "Animates the transparency (\\alpha).",
        h_tr_alpha_from = "Starting transparency.",
        h_tr_alpha_to = "Final transparency.",

        -- Text & Font FX
        h_tf_mode = "Effect to apply. Only the options in the matching section (>>) are used.",
        h_tf_step_rf = "How often the font changes, in ms (40 to 500).",
        h_tf_rf_char = "Picks a font for each letter instead of one for the whole line.",
        h_tf_size_var = "Randomly varies the font size by up to ± this value (0 = no variation).",
        h_tf_step_tu = "How often the text is updated, in ms (40 to 500).",
        h_tf_speed_tu = "Time, in ms, for each new letter to appear.",
        h_tf_dyn_jump = "Keeps only the text written so far centered, instead of reserving space for the missing letters.",
        h_tf_step_sym = "How often the symbols change, in ms (40 to 500).",
        h_tf_inv_dir = "Axis the letters are mirrored on.",

        -- Counter
        h_ct_v_start = "Number the count starts at.",
        h_ct_v_end = "Number the count ends at.",
        h_ct_px = "Horizontal position (X) of the number.",
        h_ct_py = "Vertical position (Y) of the number.",
        h_ct_use_an5 = "Adds \\an5 (center) so the number does not shift when its width changes.",
        h_ct_style_name = "Style used for the counter lines.",
        h_ct_fs_s = "Font size at the start of the count.",
        h_ct_fs_e = "Font size at the end of the count.",
        h_ct_c1_s = "Primary color at the start of the count.",
        h_ct_c1_e = "Primary color at the end of the count.",
        h_ct_c3_s = "Border color at the start of the count.",
        h_ct_c3_e = "Border color at the end of the count.",
        h_ct_c4_s = "Shadow color at the start of the count.",
        h_ct_c4_e = "Shadow color at the end of the count.",
        h_ct_a_s = "Transparency at the start of the count.",
        h_ct_a_e = "Transparency at the end of the count.",
        h_ct_mirror = "Creates a copy of the counter on the opposite side of the screen (mirrored X).",

        -- Shake
        h_sk_amp_x = "Maximum horizontal offset, in px, to each side.",
        h_sk_amp_y = "Maximum vertical offset, in px, to each side.",
        h_sk_duration = "How long the shake lasts, in ms (used by Start, End and Both).",
        h_sk_type = "When to shake: Start = at the beginning, End = at the end, Both = beginning and end, Always = the whole line.",
        h_sk_interval = "Time between each new position, in ms (minimum 10). Lower = faster shake.",
        h_sk_force_orig = "Keeps the original position at the first and last moment of the shake.",

        -- Color Tracker
        h_trk_pixX = "X coordinate of the video pixel whose color will be followed.",
        h_trk_pixY = "Y coordinate of the video pixel whose color will be followed.",
        h_trk_c1 = "Applies the pixel color to the primary color (\\c).",
        h_trk_c2 = "Applies the pixel color to the secondary color (\\2c).",
        h_trk_c3 = "Applies the pixel color to the border (\\3c).",
        h_trk_c4 = "Applies the pixel color to the shadow (\\4c).",
        h_trk_smooth = "Blends the color between frames instead of switching it at once. Avoids the choppy look when the final video has a higher fps than the project (e.g. a render for YouTube).",

        -- Glitch
        h_gl_offset = "Maximum horizontal offset of the colored copies, in px.",
        h_gl_y_off = "Maximum vertical offset of the copies, in px (0 = horizontal only).",
        h_gl_glitch_dur = "Length of each glitch burst, in ms.",
        h_gl_fs_var = "Random font size (\\fs) variation during the glitch (0 = no variation).",
        h_gl_glitch_type = "When the glitch happens: always, only at the start, only at the end, or both.",
        h_gl_preset = "Ready-made combinations. Custom uses the values you set.",
        h_gl_bold = "Includes bold in the glitch.",
        h_gl_italic = "Includes italics in the glitch.",
        h_gl_random_font = "Randomly switches the font during the glitch.",
        h_gl_chaos_sym = "Swaps letters for symbols (@#$) during the glitch.",
        h_gl_auto_style = "Uses the line style's colors instead of the colors below.",
        h_gl_c2 = "Color of the copy shifted to the left.",
        h_gl_a2 = "Transparency of the left copy.",
        h_gl_c3 = "Color of the copy shifted to the right.",
        h_gl_a3 = "Transparency of the right copy.",
        h_gl_c1 = "Color of the center copy.",
        h_gl_a1 = "Transparency of the center copy.",
        h_gl_use_c4 = "Adds a fourth colored copy.",
        h_gl_c4 = "Color of the fourth copy.",
        h_gl_a4 = "Transparency of the fourth copy.",
        h_gl_del_syls = "In Karaoke and ReverseK modes, removes the syllables that are still hidden, centering only the visible text.",

        -- Rainbow Wave
        h_rw_dir = "Direction the color wave travels across the text.",
        h_rw_use_style = "Uses the color of the style chosen next to it as the base of the wave.",
        h_rw_style_sel = "Style the base color comes from.",
        h_rw_step = "How often the color is updated, in ms (40 to 100). Lower = smoother, but more lines.",
        h_rw_speed = "Delay between one letter and the next, in ms.",
        h_rw_width = "How long the wave takes to pass through each letter, in ms.",
        h_rw_delay = "Wait before the wave starts, in ms after the start of the line.",
        h_rw_target_c1 = "Applies the wave to the primary color (\\c).",
        h_rw_target_c3 = "Applies the wave to the border (\\3c).",
        h_rw_target_c4 = "Applies the wave to the shadow (\\4c).",
        h_rw_over_grad = "Keeps the gradient already on the line and applies the wave on top.",
        h_rw_ab_n = "Extra waviness of the color bands (1 = straight bands, up to 4 = more organic). Bands still travel along the text one after another.",
        h_rw_ab_dir = "Direction the color bands travel along the text.",
        h_rw_ab_size = "Width of each color band, in letters. Smaller = narrower bands and more colors at once.",
        h_rw_ab_speed = "Speed of the bands (100 = half a palette cycle per second).",
        h_rw_ab_c1 = "Color 1 of the Abstract palette.", h_rw_ab_c2 = "Color 2 of the Abstract palette.",
        h_rw_ab_c3 = "Color 3 of the Abstract palette.", h_rw_ab_c4 = "Color 4 of the Abstract palette.",

        -- Curves
        h_cv_ease_mode = "\\move acceleration: Linear = constant, Ease In = speeds up, Ease Out = slows down, Ease In-Out = both.",
        h_cv_use_cubic = "Cubic curve: sharper acceleration.",
        h_cv_step = "How often the position is recalculated, in ms (40 to 100). Lower = smoother, but more lines.",
        h_cv_bx1 = "X of the Bézier curve's control point 1 (0 to 1).",
        h_cv_by1 = "Y of control point 1. Outside 0 to 1 creates a spring effect.",
        h_cv_bx2 = "X of the Bézier curve's control point 2 (0 to 1).",
        h_cv_by2 = "Y of control point 2. Outside 0 to 1 creates a spring effect.",
        h_cv_preset = "Ready-made curves. Manual uses the points set above.",

        -- Karaoke FX
        h_kf_fade_en = "Each syllable appears coming from the color below.",
        h_kf_c_start = "Color the syllable appears with before turning into its final color.",
        h_kf_move_en = "Each syllable slides in.",
        h_kf_m_dir = "Direction the syllable comes in from.",
        h_kf_m_dist = "Distance the syllable travels, in px.",
        h_kf_over_grad = "Keeps the gradient already on the line.",
        h_kf_drift_en = "Each syllable floats the whole time it is on screen, independently of the others.",
        h_kf_d_period = "Time of one full back-and-forth cycle, in ms. Each syllable varies slightly around it.",
        h_kf_d_x = "How far the syllable sways horizontally, in px (0 = no movement).",
        h_kf_d_y = "How far the syllable sways vertically, in px (0 = no movement).",
        h_kf_d_step = "How often the position updates, in ms (min. 20). Lower = smoother, more lines.",
        h_kf_d_jit = "Instead of a smooth sway, the syllable jumps to a random position (within the amplitudes) every Slice Step and holds there, like the reference GIF. Use a larger Slice Step (100-200 ms).",
        h_kf_d_min = "Choppy mode only: minimum distance between one position and the next. Avoids jumps so small that YouTube shows no movement (limited by what the amplitudes allow). 0 disables it.",

        -- Translator
        h_trd_idioma_alvo = "Language the selected lines will be translated into.",
        h_trd_estilo = "Hint for the AI: genre, tone or context (e.g. anime song, informal, slang). The whole lyric is sent together to keep the meaning.",
        h_trd_gem_key = "Optional. Paste a free Gemini key (aistudio.google.com/apikey) to skip the shared quota. Saved only on this computer.",
    },
}
for lang, dicas in pairs(tensho_hints) do
    for k, v in pairs(dicas) do i18n[lang][k] = v end
end

function T(key)
    if i18n[script_language] and i18n[script_language][key] then
        return i18n[script_language][key]
    end
    return key
end
