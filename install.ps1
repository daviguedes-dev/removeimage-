# Instalador do removeimage
# Uso:  irm https://raw.githubusercontent.com/daviguedes-dev/removeimage-/main/install.ps1 | iex

$ErrorActionPreference = 'Stop'

$repo    = 'https://raw.githubusercontent.com/daviguedes-dev/removeimage-/main'
$destino = Join-Path $env:LOCALAPPDATA 'removeimage'
$arquivos = @('removeimage.py', 'removeimage.bat')

Write-Host "Instalando removeimage em $destino ..." -ForegroundColor Cyan

# 1. Verifica o Python
$temPython = (Get-Command py -ErrorAction SilentlyContinue) -or (Get-Command python -ErrorAction SilentlyContinue)
if (-not $temPython) {
    Write-Host "Python nao encontrado. Instale em https://www.python.org/downloads/ (marque 'Add to PATH') e rode o instalador de novo." -ForegroundColor Yellow
    return
}

# 2. Baixa os arquivos
New-Item -ItemType Directory -Force -Path $destino | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
foreach ($arq in $arquivos) {
    Invoke-WebRequest -UseBasicParsing -Uri "$repo/$arq" -OutFile (Join-Path $destino $arq)
}

# 3. Adiciona ao PATH do usuario (se ainda nao estiver)
$pathUsuario = [Environment]::GetEnvironmentVariable('Path', 'User')
$partes = @($pathUsuario -split ';' | Where-Object { $_ })
if ($partes -notcontains $destino) {
    [Environment]::SetEnvironmentVariable('Path', (($partes + $destino) -join ';'), 'User')
    Write-Host "Pasta adicionada ao PATH." -ForegroundColor Green
}
if (($env:Path -split ';') -notcontains $destino) { $env:Path += ";$destino" }

Write-Host ""
Write-Host "Pronto! removeimage instalado." -ForegroundColor Green
Write-Host "Abra um novo terminal e digite:  removeimage --dry-run"
Write-Host "Para desinstalar:  irm $repo/uninstall.ps1 | iex"
