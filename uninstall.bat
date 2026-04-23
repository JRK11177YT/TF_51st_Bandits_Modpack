@echo off
chcp 65001 > nul
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║     TASK FORCE 51st BANDITS - Desinstalador         ║
echo  ╚══════════════════════════════════════════════════════╝
echo.

set "MOD_DEST=%USERPROFILE%\Saved Games\DCS\Mods\tech\TF51_Bandits_Modpack"

if not exist "%MOD_DEST%" (
    echo  El mod no está instalado. Nada que hacer.
    pause
    exit /b 0
)

echo  Se eliminará:  %MOD_DEST%
echo.
set /p CONFIRM=  ¿Confirmas? (S/N): 

if /i "%CONFIRM%"=="S" (
    rmdir /S /Q "%MOD_DEST%"
    echo.
    echo  ✔  Mod eliminado correctamente.
) else (
    echo  Cancelado.
)
echo.
pause
