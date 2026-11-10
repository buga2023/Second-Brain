# Instala skills e regras do Second-Brain em %USERPROFILE%\.claude (Windows).
# Uso: powershell -ExecutionPolicy Bypass -File .\claude-config\install.ps1 [-SkillsOnly]
param([switch]$SkillsOnly)
$ErrorActionPreference = 'Stop'

$here   = $PSScriptRoot
$vault  = Split-Path -Parent $here
$claude = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $env:USERPROFILE '.claude' }
$stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = Join-Path $claude "skills-backup\$stamp"

$skillsDst = Join-Path $claude 'skills'
New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null

Get-ChildItem -Directory (Join-Path $vault 'skills') | ForEach-Object {
  if (-not (Test-Path (Join-Path $_.FullName 'SKILL.md'))) { return }
  $dst = Join-Path $skillsDst $_.Name
  if (Test-Path $dst) {
    New-Item -ItemType Directory -Force -Path $backup | Out-Null
    Move-Item -Path $dst -Destination (Join-Path $backup $_.Name)
  }
  Copy-Item -Recurse -Path $_.FullName -Destination $dst
  Write-Host "skill: $($_.Name)"
}

if (-not $SkillsOnly) {
  $rules = Join-Path $claude 'rules'
  New-Item -ItemType Directory -Force -Path $rules | Out-Null
  $utf8  = New-Object System.Text.UTF8Encoding($false)
  $texto = [System.IO.File]::ReadAllText((Join-Path $here 'regras.md'), $utf8)
  $texto = $texto.Replace('{{VAULT}}', $vault)
  $alvo  = Join-Path $rules 'fluxo-gustavo.md'
  [System.IO.File]::WriteAllText($alvo, $texto, $utf8)
  Write-Host "regras: $alvo"
}

if (Test-Path $backup) { Write-Host "versoes anteriores guardadas em: $backup" }
