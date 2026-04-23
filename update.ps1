# ============================================================
#  TASK FORCE 51st BANDITS - Auto-Updater
#  update.ps1  |  Comprueba y descarga nuevas versiones
#              |  desde GitHub Releases
# ============================================================
#
#  CONFIGURACIÓN (editar antes de distribuir):
#    $GitHubOwner  →  tu usuario o organización de GitHub
#    $GitHubRepo   →  nombre del repositorio
#
#  FLUJO:
#    1. Lee la versión instalada de version.json local
#    2. Consulta la GitHub API para la última release
#    3. Compara versiones con semver
#    4. Si hay actualización, descarga el .zip y lo instala
# ============================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── CONFIGURACIÓN ─────────────────────────────────────────────
$GitHubOwner = "JRK11177YT"
$GitHubRepo  = "TF_51st_Bandits_Modpack"
# ──────────────────────────────────────────────────────────────

$ModFolderName = "TF51_Bandits_Modpack"
$ModInstallDir = Join-Path $env:USERPROFILE "Saved Games\DCS\Mods\tech\$ModFolderName"
$TempDir       = Join-Path $env:TEMP "TF51_Update"
$LocalVersion  = $null
$RemoteVersion = $null

# ── Cabecera ──────────────────────────────────────────────────
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║   TASK FORCE 51st BANDITS - Auto-Updater             ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ── 1. Leer versión local instalada ───────────────────────────
$LocalVersionFile = Join-Path $ModInstallDir "version.json"

if (Test-Path $LocalVersionFile) {
    try {
        $LocalData    = Get-Content $LocalVersionFile -Raw | ConvertFrom-Json
        $LocalVersion = $LocalData.version
        Write-Host "  Versión instalada : " -NoNewline
        Write-Host "v$LocalVersion" -ForegroundColor Yellow
    } catch {
        Write-Host "  [AVISO] No se pudo leer version.json local. Se asume v0.0.0" -ForegroundColor Yellow
        $LocalVersion = "0.0.0"
    }
} else {
    Write-Host "  [INFO] Mod no instalado todavía. Se procederá a instalación limpia." -ForegroundColor Yellow
    $LocalVersion = "0.0.0"
}

# ── 2. Consultar GitHub API ───────────────────────────────────
$ApiUrl = "https://api.github.com/repos/$GitHubOwner/$GitHubRepo/releases/latest"
Write-Host "  Consultando GitHub... " -NoNewline

try {
    $Headers  = @{ "User-Agent" = "TF51-Bandits-Updater/1.0" }
    $Response = Invoke-RestMethod -Uri $ApiUrl -Headers $Headers -TimeoutSec 15
    $RemoteVersion = $Response.tag_name -replace '^v', ''   # elimina la 'v' del tag (v1.2.0 → 1.2.0)
    Write-Host "OK" -ForegroundColor Green
    Write-Host "  Última versión    : " -NoNewline
    Write-Host "v$RemoteVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR" -ForegroundColor Red
    Write-Host ""
    Write-Host "  No se pudo conectar con GitHub." -ForegroundColor Red
    Write-Host "  Comprueba tu conexión a Internet e inténtalo de nuevo." -ForegroundColor Red
    Write-Host ""
    Read-Host "  Pulsa Enter para salir"
    exit 1
}

# ── 3. Comparar versiones (semver) ────────────────────────────
function Compare-SemVer {
    param([string]$Local, [string]$Remote)
    $l = [System.Version]$Local
    $r = [System.Version]$Remote
    return $r.CompareTo($l)   # >0 si Remote es más reciente
}

$VersionDiff = Compare-SemVer -Local $LocalVersion -Remote $RemoteVersion

if ($VersionDiff -le 0) {
    Write-Host ""
    Write-Host "  ✔  Ya tienes la última versión instalada." -ForegroundColor Green
    Write-Host ""
    Read-Host "  Pulsa Enter para salir"
    exit 0
}

# ── 4. Hay actualización disponible ───────────────────────────
Write-Host ""
Write-Host "  ★  Nueva versión disponible: v$RemoteVersion" -ForegroundColor Cyan
if ($Response.body) {
    Write-Host ""
    Write-Host "  Novedades:" -ForegroundColor White
    # Mostrar hasta 10 líneas del changelog
    $Response.body -split "`n" | Select-Object -First 10 | ForEach-Object {
        Write-Host "    $_"
    }
}
Write-Host ""
$Confirm = Read-Host "  ¿Deseas actualizar ahora? (S/N)"
if ($Confirm -notmatch '^[Ss]') {
    Write-Host "  Actualización cancelada." -ForegroundColor Yellow
    exit 0
}

# ── 5. Descargar la release ───────────────────────────────────

# Buscar asset .zip en la release (primero buscamos un asset con nombre específico,
# si no existe usamos el zipball genérico de GitHub)
$ZipAsset = $Response.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1

if ($ZipAsset) {
    $DownloadUrl = $ZipAsset.browser_download_url
    $ZipName     = $ZipAsset.name
} else {
    # Fallback: zipball del código fuente del repo
    $DownloadUrl = $Response.zipball_url
    $ZipName     = "TF51_Bandits_v$RemoteVersion.zip"
}

if (-not (Test-Path $TempDir)) { New-Item -ItemType Directory -Path $TempDir | Out-Null }
$ZipPath = Join-Path $TempDir $ZipName

Write-Host ""
Write-Host "  Descargando $ZipName..." -ForegroundColor Cyan

try {
    # Mostrar progreso de descarga
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath -Headers $Headers
    $ProgressPreference = 'Continue'
    Write-Host "  Descarga completada." -ForegroundColor Green
} catch {
    Write-Host "  [ERROR] Falló la descarga: $_" -ForegroundColor Red
    Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    Read-Host "  Pulsa Enter para salir"
    exit 1
}

# ── 6. Extraer e instalar ─────────────────────────────────────
Write-Host "  Instalando actualización..."

$ExtractDir = Join-Path $TempDir "extracted"
if (Test-Path $ExtractDir) { Remove-Item $ExtractDir -Recurse -Force }

try {
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractDir -Force
} catch {
    Write-Host "  [ERROR] No se pudo extraer el ZIP: $_" -ForegroundColor Red
    Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    Read-Host "  Pulsa Enter para salir"
    exit 1
}

# GitHub zipball crea una subcarpeta con el nombre del repo+commit.
# Buscamos la raíz del mod dentro del zip.
$ExtractedRoot = Get-ChildItem $ExtractDir -Directory | Select-Object -First 1
if ($ExtractedRoot) {
    $SourceDir = $ExtractedRoot.FullName
} else {
    $SourceDir = $ExtractDir
}

# Crear directorio destino si no existe
if (-not (Test-Path $ModInstallDir)) {
    New-Item -ItemType Directory -Path $ModInstallDir | Out-Null
}

# Copiar archivos (sobreescribir)
Copy-Item -Path "$SourceDir\*" -Destination $ModInstallDir -Recurse -Force

Write-Host "  ✔  Mod actualizado a v$RemoteVersion" -ForegroundColor Green

# ── 7. Limpieza ───────────────────────────────────────────────
Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "  ══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Actualización completada. ¡Reinicia DCS para aplicarla!" -ForegroundColor Green
Write-Host "  ══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Read-Host "  Pulsa Enter para salir"
