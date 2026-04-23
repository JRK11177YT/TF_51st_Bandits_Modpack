-- ============================================================
--  TASK FORCE 51st BANDITS - Modpack
--  Scripts/Hooks/tf51_menu_hook.lua
--
--  Este script se ejecuta en el entorno de HOOKS de DCS,
--  que tiene acceso a la UI del menú principal.
--
--  Para activar el fondo y música personalizados:
--    1. Añade tus archivos a las rutas indicadas.
--    2. Cambia los flags en mod.lua a  true.
-- ============================================================

local TF51 = {}

-- ── Música del menú principal ─────────────────────────────────
--
--  DCS carga la música del menú desde:
--    DCS World\Music\MainMenu\
--  Para sobrescribirla con el mod, monta la ruta en entry.lua
--  (mount_vfs_sound_path) y coloca tu .ogg en:
--    Sounds\Music\MainMenu\
--  con el MISMO nombre de archivo que usa DCS por defecto.
--
--  Archivo original de DCS a sobrescribir:  "MainMenu.ogg"
--  → pon tu pista como:  Sounds/Music/MainMenu/MainMenu.ogg

-- ── Fondo del menú principal ─────────────────────────────────
--
--  DCS carga el background desde el VFS. Para cambiarlo:
--    1. Prepara una imagen 1920×1080 en formato .jpg o .png.
--    2. Guárdala en:  Resources/Textures/ui_main_bg.png
--    3. En entry.lua descomenta:
--         mount_vfs_texture_path(mod_path .. "Resources/Textures")
--    4. El nombre de archivo debe coincidir con la textura
--       que DCS busca para el fondo. Ver comentario abajo.
--
--  NOTA: El archivo interno de DCS es variable por versión.
--  La forma más segura es usar el callback DCS.onSimulationStart
--  o modificar el archivo de UI directamente (ver abajo).

-- ── Callback de inicio ────────────────────────────────────────

local function onMissionLoadEnd()
    -- Aquí puedes ejecutar lógica al cargar una misión
    log.write("TF51_BANDITS", log.INFO, "Misión cargada - TF51 Bandits Modpack activo")
end

local function onSimulationStart()
    log.write("TF51_BANDITS", log.INFO, "Simulación iniciada")
end

-- ── Registro de callbacks en DCS ─────────────────────────────

DCS.setUserCallbacks({
    onMissionLoadEnd    = onMissionLoadEnd,
    onSimulationStart   = onSimulationStart,
})

log.write("TF51_BANDITS", log.INFO, "Hook del menú TF51 cargado.")
