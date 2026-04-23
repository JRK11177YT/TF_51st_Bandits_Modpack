@echo off
chcp 65001 > nul
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║     TASK FORCE 51st BANDITS - Modpack Installer     ║
echo  ║                    v1.0.0                            ║
echo  ╚══════════════════════════════════════════════════════╝
echo.

:: ── Detectar Saved Games de DCS World Stable ─────────────────
set "DCS_SAVED=%USERPROFILE%\Saved Games\DCS"

if not exist "%DCS_SAVED%" (
    echo  [ERROR] No se encontró la carpeta de DCS World:
    echo          %DCS_SAVED%
    echo.
    echo  Asegúrate de haber lanzado DCS al menos una vez.
    pause
    exit /b 1
)

:: ── Ruta de destino del mod ───────────────────────────────────
set "MOD_DEST=%DCS_SAVED%\Mods\tech\TF51_Bandits_Modpack"

echo  Instalando en:
echo  %MOD_DEST%
echo.

:: ── Crear directorio si no existe ────────────────────────────
if not exist "%MOD_DEST%" (
    mkdir "%MOD_DEST%"
)

:: ── Copiar archivos ───────────────────────────────────────────
echo  [1/4] Copiando archivos principales...
xcopy /E /I /Y "%~dp0entry.lua"      "%MOD_DEST%\" > nul
xcopy /E /I /Y "%~dp0mod.lua"        "%MOD_DEST%\" > nul
xcopy /E /I /Y "%~dp0version.json"   "%MOD_DEST%\" > nul

echo  [2/4] Copiando liveries (skins)...
xcopy /E /I /Y "%~dp0Liveries"    "%MOD_DEST%\Liveries\" > nul

echo  [3/4] Copiando scripts y hooks...
xcopy /E /I /Y "%~dp0Scripts"     "%MOD_DEST%\Scripts\" > nul

echo  [4/4] Copiando recursos (sonido, imágenes)...
if exist "%~dp0Resources"  xcopy /E /I /Y "%~dp0Resources"  "%MOD_DEST%\Resources\" > nul
if exist "%~dp0Sounds"     xcopy /E /I /Y "%~dp0Sounds"     "%MOD_DEST%\Sounds\" > nul

echo.
echo  ✔  Instalación completada.
echo.
echo  Siguiente paso:
echo    1. Abre DCS World
echo    2. Ve a  Opciones → Módulos  y verifica que aparece
echo       "Task Force 51st BANDITS - Modpack"
echo    3. ¡Selecciona las skins TF51 al crear tu piloto!
echo.
pause
