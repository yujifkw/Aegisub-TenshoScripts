-- TenshoScripts.lua (Free Version)

script_name = "-TenshoScripts (Free)"
script_description = "A suite of automation tools for subtitles."
script_author = "Tenshy (@otenshy)"
script_version = "2.0.0"
script_free = true
script_namespace = "tenshy.TenshoScripts" 
script_language = "en"

re = nil
local setup_warnings = {}

local re_ok
re_ok, re = pcall(require, "aegisub.re")
if not re_ok then
    table.insert(setup_warnings, "ERRO: Falha ao carregar 'aegisub.re'.")
end

-- =========================================================================
-- CONFIGURAÇÕES GLOBAIS E CAMINHOS
-- =========================================================================
tensho_cfg = {
    lang = "en",
    alpha_100 = false,
    auto_update = true,
    last_tool = "Fadeworks"
}

local user_path = aegisub.decode_path("?user")
local local_dir = user_path .. "\\TenshoScripts\\"
local cfg_path = user_path .. "\\tensho_global.conf"
local local_versions_file = local_dir .. "tensho_versions.conf"
local github_raw_base = "https://raw.githubusercontent.com/yujifkw/Aegisub-TenshoScripts/modificacoes/"

local function load_global_config()
    local file = io.open(cfg_path, "r")
    if file then
        local content = file:read("*all")
        io.close(file)
        for line in content:gmatch("[^\r\n]+") do
            local key, val = line:match("^([^:]+):(.*)$")
            if key and val then
                if val == "true" then tensho_cfg[key] = true
                elseif val == "false" then tensho_cfg[key] = false
                else tensho_cfg[key] = val end
            end
        end
        script_language = tensho_cfg.lang
    end
end
load_global_config()

local function save_global_config()
    local file = io.open(cfg_path, "w")
    if file then
        for k, v in pairs(tensho_cfg) do
            file:write(k .. ":" .. tostring(v) .. "\n")
        end
        file:close()
    end
end

-- =========================================================================
-- GERENCIADOR DE MÓDULOS E SESSÃO
-- =========================================================================
local modules_to_sync = {
    "core/i18n.lua", "core/globals.lua",
    "functions/tensho_fadeworks.lua", "functions/tensho_gradient.lua",
    "functions/tensho_fixlines.lua", "functions/tensho_splitlines.lua",
    "functions/tensho_ytktfade.lua", "functions/tensho_flashes.lua",
    "functions/tensho_transform.lua", "functions/tensho_textfx.lua",
    "functions/tensho_counter.lua", "functions/tensho_shake.lua",
    "functions/tensho_colortrack.lua"
}

local session_initialized = false

local function ensure_dir_exists(path)
    os.execute('if not exist "' .. path .. '" mkdir "' .. path .. '"')
end

local function get_local_versions()
    local v = {}
    local f = io.open(local_versions_file, "r")
    if f then
        for line in f:lines() do
            local mod, ver = line:match("^(.-)=(.+)$")
            if mod and ver then v[mod] = ver end
        end
        f:close()
    end
    return v
end

local function save_local_versions(v)
    local f = io.open(local_versions_file, "w")
    if f then
        for mod, ver in pairs(v) do f:write(mod .. "=" .. ver .. "\n") end
        f:close()
    end
end

local function carregar_modulos_locais()
    local compiler = loadstring or load
    for _, mod in ipairs(modules_to_sync) do
        local mod_path = local_dir .. mod:gsub("/", "\\")
        local f = io.open(mod_path, "r")
        if f then
            local content = f:read("*all")
            f:close()
            local chunk = compiler(content, mod)
            if chunk then pcall(chunk) end
        end
    end
end

local function perform_downloads(mod_list, remote_versions)
    ensure_dir_exists(local_dir .. "core")
    ensure_dir_exists(local_dir .. "functions")
    local local_versions = get_local_versions()
    for _, mod in ipairs(mod_list) do
        local target = local_dir .. mod:gsub("/", "\\")
        local url = github_raw_base .. mod
        os.execute(string.format('curl -s -f -o "%s" "%s"', target, url))
        local_versions[mod] = (remote_versions and remote_versions[mod]) or "1.0.0"
    end
    save_local_versions(local_versions)
end

-- =====================================================================
-- FUNÇÕES DE CONFIGURAÇÃO (GUI)
-- =====================================================================
function tensho_settings_gui(ADD)
    local lang_value = (tensho_cfg.lang == "pt") and T("lang_pt") or T("lang_en")
    local alpha_val = tensho_cfg.alpha_100 and T("cfg_alpha_100") or T("cfg_alpha_hex")
    
    local cfg_gui = {
        {class="label", label=T("cfg_title"), x=0, y=0, width=2},
        {class="label", label=T("cfg_lang"), x=0, y=2},
        {class="dropdown", name="cfg_lang", items={T("lang_pt"), T("lang_en")}, value=lang_value, x=1, y=2},
        {class="label", label=T("cfg_alpha"), x=0, y=3},
        {class="dropdown", name="cfg_alpha", items={T("cfg_alpha_100"), T("cfg_alpha_hex")}, value=alpha_val, x=1, y=3},
        {class="checkbox", name="cfg_update", label=T("cfg_update"), value=tensho_cfg.auto_update, x=0, y=4, width=2},
    }

    local btn, res = ADD(cfg_gui, {T("btn_save"), T("btn_cancel")})
    if btn == T("btn_save") then
        tensho_cfg.alpha_100 = (res.cfg_alpha == T("cfg_alpha_100"))
        tensho_cfg.auto_update = res.cfg_update
        tensho_cfg.lang = (res.cfg_lang == T("lang_pt")) and "pt" or "en"
        script_language = tensho_cfg.lang
        save_global_config()
    end
end

-- =========================================================================
-- FALLBACK DE TRADUÇÃO
-- =========================================================================
if not _G.T then
    _G.T = function(key)
        local lang = script_language or "en"
        local dict = {
            en = { 
                master_title = "TenshoScripts v", btn_exec = "Execute", btn_settings = "Settings", btn_cancel = "Cancel", 
                lang_pt = "Português", lang_en = "English", cfg_title = "TenshoScripts Configuration", cfg_lang = "Language:", 
                cfg_alpha = "Alpha Mode:", cfg_alpha_100 = "0 to 100%", cfg_alpha_hex = "Hexadecimal", cfg_update = "Check updates on startup", 
                btn_save = "Save", tool_fade = "Fadeworks", tool_grad = "Gradient", tool_flash = "Flashes", tool_trans = "Transform", 
                tool_textfx = "TextFX", tool_counter = "Counter", tool_shake = "Shake", tool_ctrack = "Color Tracker", 
                tool_ytkt = "YouTube Karaoke Fade", tool_split = "Split Lines", tool_fix = "Fix Lines",
                -- Novos textos de Download/Update
                msg_missing = "%d dependencies are missing for TenshoScripts to work.\nDo you want to download them now?",
                btn_download = "Download",
                msg_updates = "There are %d modules with updates available.\nDo you want to download the new features?",
                btn_down_upd = "Download Updates",
                btn_ignore = "Ignore"
            },
            pt = { 
                master_title = "TenshoScripts v", btn_exec = "Executar", btn_settings = "Configurações", btn_cancel = "Cancelar", 
                lang_pt = "Português", lang_en = "English", cfg_title = "Configurações do TenshoScripts", cfg_lang = "Idioma:", 
                cfg_alpha = "Modo Alpha:", cfg_alpha_100 = "0 a 100%", cfg_alpha_hex = "Hexadecimal", cfg_update = "Buscar atualizações ao iniciar", 
                btn_save = "Salvar", tool_fade = "Fadeworks", tool_grad = "Gradiente", tool_flash = "Flashes", tool_trans = "Transformar", 
                tool_textfx = "TextFX", tool_counter = "Contador", tool_shake = "Shake", tool_ctrack = "Color Tracker", 
                tool_ytkt = "YouTube Karaoke Fade", tool_split = "Dividir Linhas", tool_fix = "Consertar Linhas",
                -- Novos textos de Download/Update
                msg_missing = "Faltam %d dependências para o TenshoScripts funcionar.\nDeseja fazer o download agora?",
                btn_download = "Baixar",
                msg_updates = "Existem %d módulos com atualizações disponíveis.\nDeseja baixar as novas funções?",
                btn_down_upd = "Baixar Updates",
                btn_ignore = "Ignorar"
            }
        }
        if dict[lang] and dict[lang][key] then return dict[lang][key] end
        return key
    end
end

-- ==================================================================================================================================
-- MACRO PRINCIPAL E LÓGICA DE INSTALAÇÃO GUI
-- ==================================================================================================================================
local function setup_session(ADD)
    -- 1. Verifica Modulos Faltando Fisicamente
    local missing = {}
    for _, mod in ipairs(modules_to_sync) do
        local f = io.open(local_dir .. mod:gsub("/", "\\"), "r")
        if not f then table.insert(missing, mod) else f:close() end
    end

    if #missing > 0 then
        local msg = string.format(T("msg_missing"), #missing)
        local btn = ADD({{class="label", label=msg}}, {T("btn_download"), T("btn_cancel")})
        if btn == T("btn_download") then perform_downloads(missing, nil) else return false end
    end

    -- 2. Verifica Atualizacoes Se Permitido
    if tensho_cfg.auto_update then
        local h = io.popen(string.format('curl -s -f "%stensho_versions.txt"', github_raw_base))
        local vers_data = h and h:read("*a") or ""
        if h then h:close() end

        if vers_data ~= "" then
            local remote_versions = {}
            for line in vers_data:gmatch("[^\r\n]+") do
                local mod, ver = line:match("^(.-)=(.+)$")
                if mod and ver then remote_versions[mod] = ver end
            end
            
            local local_versions = get_local_versions()
            local pending = {}
            for _, mod in ipairs(modules_to_sync) do
                if remote_versions[mod] and remote_versions[mod] ~= local_versions[mod] then table.insert(pending, mod) end
            end

            if #pending > 0 then
                local msg = string.format(T("msg_updates"), #pending)
                local btn = ADD({{class="label", label=msg}}, {T("btn_down_upd"), T("btn_ignore")})
                if btn == T("btn_down_upd") then perform_downloads(pending, remote_versions) end
            end
        end
    end

    carregar_modulos_locais()
    session_initialized = true
    return true
end

function mostrar_gui_mestre(subs, sel, act)
    local ADD = aegisub.dialog.display
    local ADP = aegisub.decode_path
    local ak = aegisub.cancel

    if not session_initialized then
        if not setup_session(ADD) then return sel end
    end

    local menu_ativo = true
    
    while menu_ativo do
        local botoes = {T("btn_exec"), T("btn_settings"), T("btn_cancel")}
        local ferramentas = {T("tool_fade"), T("tool_grad"), T("tool_flash"), T("tool_trans"), T("tool_textfx"), T("tool_counter"), T("tool_shake"), T("tool_ctrack"), T("tool_ytkt"), T("tool_split"), T("tool_fix")}

        local tool_valida = false
        for _, f in ipairs(ferramentas) do
            if f == tensho_cfg.last_tool then tool_valida = true; break end
        end
        if not tool_valida then tensho_cfg.last_tool = ferramentas[1] end


        local main_gui_config = {
            {class="label", x=0, y=0, width=2, label=T("master_title")..script_version.." (Free)"},
            {class="dropdown", name="tool_select", items=ferramentas, value=tensho_cfg.last_tool, x=0, y=1, width=2},
        }

        local btn, res_main = ADD(main_gui_config, botoes, {ok=T("btn_exec"), cancel=T("btn_cancel")})

        if btn == T("btn_settings") then
            tensho_settings_gui(ADD)
        elseif btn == T("btn_exec") then
            tensho_cfg.last_tool = res_main.tool_select
            local tool = res_main.tool_select
            local res_ferramenta = nil

            -- Chamadas das ferramentas
            if tool == T("tool_fade") and tensho_fadeworks_gui then res_ferramenta = tensho_fadeworks_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_grad") and tensho_gradient_gui then res_ferramenta = tensho_gradient_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_flash") and tensho_flashes_gui then res_ferramenta = tensho_flashes_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_trans") and tensho_transform_gui then res_ferramenta = tensho_transform_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_textfx") and tensho_textfx_gui then res_ferramenta = tensho_textfx_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_counter") and tensho_counter_gui then res_ferramenta = tensho_counter_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_shake") and tensho_shake_gui then res_ferramenta = tensho_shake_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_split") and tensho_splitlines_gui then res_ferramenta = tensho_splitlines_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_ytkt") and tensho_ytkt_fade_gui then res_ferramenta = tensho_ytkt_fade_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_fix") and tensho_fixlines_gui then res_ferramenta = tensho_fixlines_gui(subs, sel, ADD, ADP, ak)
            elseif tool == T("tool_ctrack") and tensho_colortrack_gui then res_ferramenta = tensho_colortrack_gui(subs, sel, ADD, ADP, ak)
            else
                ADD({{class="label", label="Erro: A ferramenta selecionada não foi carregada corretamente."}}, {"OK"})
            end

            if res_ferramenta ~= "BACK" then menu_ativo = false end
        else
            menu_ativo = false
        end
    end
end

aegisub.register_macro(script_name, script_description, mostrar_gui_mestre)
