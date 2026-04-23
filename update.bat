@echo off
chcp 65001 > nul
:: Lanza el updater de PowerShell sin restricción de ejecución
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0update.ps1"
