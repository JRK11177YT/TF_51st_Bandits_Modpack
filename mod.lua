-- ============================================================
--  TASK FORCE 51st BANDITS - Modpack
--  mod.lua  |  Configuración central del modpack
-- ============================================================

TF51_Bandits = TF51_Bandits or {}

TF51_Bandits.config = {
    -- ── Información del escuadrón ──────────────────────────
    name         = "Task Force 51st BANDITS",
    tag          = "TF51",
    version      = "1.0.0",

    -- ── Aviones del escuadrón ──────────────────────────────
    -- Estos son los identificadores internos de DCS.
    -- Se usan para montar las liveries correctamente.
    aircraft = {
        { id = "FA-18C_hornet",  display = "F/A-18C Hornet" },
        { id = "F-16C_50",       display = "F-16C Viper"    },
    },

    -- ── Configuración del menú principal ──────────────────
    -- Cuando tengas los archivos listos, pon true.
    menu = {
        custom_background = false,   -- Resources/Textures/menu_background.jpg
        custom_music      = false,   -- Sounds/Music/MainMenu/tf51_theme.ogg
    },

    -- ── Otros mods del escuadrón ──────────────────────────
    -- Lista los mods externos que usa el escuadrón.
    -- Esto es solo documentación; no los instala automáticamente.
    third_party_mods = {
        -- { name = "Nombre del Mod", url = "https://...", version = "x.x" },
    },
}

return TF51_Bandits
