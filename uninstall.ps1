# Desinstalador do removeimage
# Uso:  irm https://raw.githubusercontent.com/daviguedes-dev/removeimage-/main/uninstall.ps1 | iex

$ErrorActionPreference = 'Stop'
$destino = Join-Path $env:LOCALAPPDATA 'removeimage'

if (Test-Path $destino) {
    Remove-Item -Recurse -Force $destino
    Write-Host "Arquivos removidos de $destino" -ForegroundColor Green
}

$pathUsuario = [Environment]::GetEnvironmentVariable('Path', 'User')
$partes = @($pathUsuario -split ';' | Where-Object { $_ -and $_ -ne $destino })
[Environment]::SetEnvironmentVariable('Path', ($partes -join ';'), 'User')

Write-Host "removeimage desinstalado." -ForegroundColor Green
