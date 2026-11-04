$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Push-Location $repo
try {
  & git rev-parse --is-inside-work-tree | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "Not a Git checkout: $repo" }
  $dirty = & git status --porcelain --untracked-files=normal
  if ($LASTEXITCODE -ne 0) { throw "Cannot inspect Git status" }
  if ($dirty) { throw 'Refusing update: working tree contains local changes or untracked files.' }

  $branch = & git symbolic-ref --quiet --short HEAD
  if ($LASTEXITCODE -ne 0 -or -not $branch) { throw 'Refusing update: detached HEAD.' }
  $upstream = & git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>$null
  if ($LASTEXITCODE -ne 0 -or -not $upstream) { throw "Refusing update: branch $branch has no upstream." }

  Write-Output "Updating $repo ($branch tracking $upstream)"
  & git pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw 'Fast-forward pull failed. No force reset attempted.' }
  & (Join-Path $repo 'scripts/install.ps1')
  if (-not $?) { throw 'Skills link verification/install failed.' }
  $revision = & git rev-parse --short HEAD
  Write-Output "Update complete at $revision."
} finally {
  Pop-Location
}
