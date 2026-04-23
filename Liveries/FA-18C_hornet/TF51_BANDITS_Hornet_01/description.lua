-- ============================================================
--  TASK FORCE 51st BANDITS
--  F/A-18C Hornet  |  Livery #01
--  description.lua
-- ============================================================
--
--  INSTRUCCIONES PARA AÑADIR TEXTURAS:
--  ─────────────────────────────────────────────────────────
--  1. Exporta las texturas del F/A-18C desde la herramienta
--     de pintura (DCS Paintkit / PSD).
--  2. Guarda los archivos .dds en esta misma carpeta.
--  3. Descomenta las líneas correspondientes abajo y pon
--     el nombre exacto del archivo (sin extensión).
--
--  Capas principales del F/A-18C:
--    "F-18_exterior"  →  Fuselaje exterior
--    "F-18_cockpit"   →  Cabina
--    "F-18_helmet"    →  Casco del piloto
--    "F-18_cloth"     →  Indumentaria del piloto
-- ============================================================

livery = {
    -- Formato: { "NombreCapa", índiceMaterial, "archivo_textura", usar_roughmet }

    -- ── Fuselaje principal ─────────────────────────────────
    -- Descomenta cuando tengas el .dds listo:
    -- {"F-18_exterior",  0, "TF51_hornet_01_fuselage",   true},

    -- ── Detalles / markings ────────────────────────────────
    -- {"F-18_exterior",  1, "TF51_hornet_01_markings",   true},

    -- Placeholder vacío para que DCS cargue la livery sin errores
}

-- Nombre que aparece en el selector de liveries dentro del juego
name = "TF51 BANDITS | Hornet #01"
preview = "icon.png"

-- Códigos de país que podrán usar esta livery
-- Lista completa: https://wiki.hoggitworld.com/view/DCS_func_coalition
countries = { "USA", "SPAIN" }
