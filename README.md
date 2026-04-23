# Task Force 51st BANDITS — Modpack

> Modpack oficial de la **Task Force 51st BANDITS** para DCS World.  
> Incluye las skins del escuadrón para F/A-18C Hornet y F-16C Viper, música y fondo del menú principal, y los mods comunes del escuadrón.

---

## Contenido

| Carpeta / Archivo | Descripción |
|---|---|
| `entry.lua` | Punto de entrada del mod — DCS lo carga automáticamente |
| `mod.lua` | Configuración central (aviones, versión, flags) |
| `version.json` | Versión actual del mod (usada por el auto-updater) |
| `install.bat` | Instalador con doble-clic |
| `uninstall.bat` | Desinstalador |
| `update.bat` | Comprueba y descarga actualizaciones desde GitHub |
| `Liveries/` | Skins oficiales del escuadrón |
| `Scripts/Hooks/` | Hooks de DCS (menú principal, callbacks) |
| `Resources/` | Logo, fondo del menú |
| `Sounds/` | Música del menú principal |

---

## Requisitos

- **DCS World** (Stable) — versión 2.9 o superior
- **Módulos requeridos:** F/A-18C Hornet, F-16C Viper
- Windows 10/11
- Conexión a Internet (solo para el auto-updater)

---

## Instalación

### Opción A — Instalador automático (recomendado)

1. Descarga el `.zip` de la [última release](https://github.com/JRK11177YT/TF_51st_Bandits_Modpack/releases/latest)
2. Extrae la carpeta en tu escritorio o donde prefieras
3. Ejecuta **`install.bat`** con doble-clic
4. Abre DCS → **Opciones → Módulos** y verifica que aparece el mod
5. Al crear tu piloto selecciona las skins **TF51 BANDITS**

### Opción B — Manual

Copia la carpeta completa a:
```
%USERPROFILE%\Saved Games\DCS\Mods\tech\TF51_Bandits_Modpack\
```

---

## Actualizaciones

Ejecuta **`update.bat`** con doble-clic.  
El script comprueba la versión instalada contra la última release de GitHub y, si hay una nueva versión, la descarga e instala automáticamente.

```
update.bat  →  Comprueba GitHub
                ├─ Sin cambios  → Avisa y sale
                └─ Actualización disponible
                      → Muestra el changelog
                      → Pide confirmación
                      → Descarga e instala
```

---

## Añadir o actualizar skins

1. Diseña las texturas con el **DCS Paintkit** del avión correspondiente
2. Exporta como `.dds` y coloca los archivos en la carpeta de la livery:
   ```
   Liveries/FA-18C_hornet/TF51_BANDITS_Hornet_01/
   Liveries/F-16C_50/TF51_BANDITS_Viper_01/
   ```
3. Edita el `description.lua` de esa livery y descomenta las líneas de textura
4. Crea una nueva **Release** en GitHub con el tag `vX.Y.Z` y adjunta el `.zip` del mod

---

## Activar fondo y música del menú principal

### Música
1. Coloca tu pista en formato `.ogg` en `Sounds/Music/MainMenu/MainMenu.ogg`
2. Abre `entry.lua` y descomenta:
   ```lua
   mount_vfs_sound_path(mod_path .. "Sounds")
   ```
3. Cambia `custom_music = true` en `mod.lua`

### Fondo
1. Coloca tu imagen (1920×1080, `.jpg` o `.png`) en `Resources/Textures/menu_background.jpg`
2. Abre `entry.lua` y descomenta:
   ```lua
   mount_vfs_texture_path(mod_path .. "Resources/Textures")
   ```
3. Cambia `custom_background = true` en `mod.lua`

---

## Publicar una nueva versión (admin)

1. Actualiza el campo `version` en `version.json` (ej. `"1.1.0"`)
2. Haz commit y push al repo
3. En GitHub → **Releases → Draft a new release**
4. Tag: `v1.1.0` | Título: `v1.1.0 - Descripción breve`
5. Adjunta el `.zip` del mod como asset
6. Publica la release — los miembros del escuadrón verán la actualización al ejecutar `update.bat`

---

## Estructura del repositorio

```
TF_51st_Bandits_Modpack/
├── entry.lua
├── mod.lua
├── version.json
├── install.bat
├── uninstall.bat
├── update.bat
├── update.ps1
├── Liveries/
│   ├── FA-18C_hornet/
│   │   ├── TF51_BANDITS_Hornet_01/
│   │   └── TF51_BANDITS_Hornet_02/
│   └── F-16C_50/
│       ├── TF51_BANDITS_Viper_01/
│       └── TF51_BANDITS_Viper_02/
├── Scripts/
│   └── Hooks/
│       └── tf51_menu_hook.lua
├── Resources/
│   └── (logo.png, Textures/)
└── Sounds/
    └── Music/MainMenu/
```

---

## Desinstalación

Ejecuta `uninstall.bat` con doble-clic.

---

*Task Force 51st BANDITS · DCS World · [github.com/JRK11177YT/TF_51st_Bandits_Modpack](https://github.com/JRK11177YT/TF_51st_Bandits_Modpack)*
