-- ============================================================
--  TASK FORCE 51st BANDITS - Modpack
--  entry.lua  |  Punto de entrada del mod para DCS World
-- ============================================================
--  Versión  : 1.0.0
--  Autor    : Task Force 51st BANDITS
--  DCS Ver. : DCS World (Stable)
-- ============================================================

local mod_path = current_mod_path   -- Variable automática que DCS inyecta al cargar el mod
local mod_id   = "TF51_Bandits_Modpack"

-- ─────────────────────────────────────────────────────────────
--  Declaración del plugin / módulo
-- ─────────────────────────────────────────────────────────────
declare_plugin(mod_id, {
    installed     = true,
    dirPath       = mod_path,
    name          = "Task Force 51st BANDITS - Modpack",
    version       = "1.0.0",
    state         = "installed",
    info          = "Modpack oficial de la Task Force 51st BANDITS.\nIncluye skins, configuraciones y mods del escuadrón.",

    -- Icono principal en el Module Manager (256×256 px, PNG con transparencia)
    image         = mod_path .. "Resources/logo.png",

    -- Banner/tarjeta en el Module Manager (468×234 px)
    preview       = mod_path .. "Resources/module_banner.png",

    -- Iconos de la barra inferior del menú principal (86×86 px)
    -- normal / hover / selected
    icon          = mod_path .. "Resources/icon_menu.png",
    icon_hover    = mod_path .. "Resources/icon_menu_hover.png",
    icon_selected = mod_path .. "Resources/icon_menu_sel.png",

    update_id     = mod_id,
    plugin_folder = mod_path,
})

-- ─────────────────────────────────────────────────────────────
--  Montar rutas virtuales (VFS)
--  DCS usa un sistema de archivos virtual; montamos nuestras
--  carpetas para que el juego las encuentre automáticamente.
-- ─────────────────────────────────────────────────────────────

-- Liveries (skins) de los aviones del escuadrón
mount_vfs_liveries_path(mod_path .. "Liveries")

-- Sonidos / música del menú principal
mount_vfs_sound_path(mod_path .. "Sounds")

-- Texturas adicionales (fondo del menú, loading screen)
mount_vfs_texture_path(mod_path .. "Resources/Textures")

-- ─────────────────────────────────────────────────────────────
--  Log de inicio
-- ─────────────────────────────────────────────────────────────
log.write("TF51_BANDITS", log.INFO, "=== Task Force 51st BANDITS Modpack v1.0.0 cargado ===")
log.write("TF51_BANDITS", log.INFO, "Ruta del mod: " .. mod_path)
