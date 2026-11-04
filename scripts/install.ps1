$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$sourceRoot = Join-Path $repo '.agents/skills'
if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
  throw "Missing skill source directory: $sourceRoot"
}

$skills = @(Get-ChildItem -LiteralPath $sourceRoot -Directory | Where-Object {
  Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf
})
if ($skills.Count -eq 0) { throw "No skills found in $sourceRoot" }

$destinations = @(
  (Join-Path $HOME '.agents/skills'),
  (Join-Path $HOME '.claude/skills')
)

# Inspect all potential collisions before creating any links.
foreach ($destination in $destinations) {
  foreach ($skill in $skills) {
    $link = Join-Path $destination $skill.Name
    $existing = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
    if ($null -eq $existing) { continue }
    $isLink = ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
    $resolved = if ($isLink) {
      # PowerShell Resolve-Path may keep the junction path; inspect its actual target.
      $target = [string]$existing.Target
      if ([IO.Path]::IsPathRooted($target)) {
        [IO.Path]::GetFullPath($target).TrimEnd('\')
      } else { '' }
    } else { '' }
    if (-not $isLink -or $resolved -ine $skill.FullName.TrimEnd('\')) {
      throw "Conflict: $link exists and is not a VMCSkills link to $($skill.FullName)"
    }
  }
}

foreach ($destination in $destinations) {
  New-Item -ItemType Directory -Force -Path $destination | Out-Null
  foreach ($skill in $skills) {
    $link = Join-Path $destination $skill.Name
    $existing = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
    if ($null -ne $existing) {
      Write-Output "Already linked: $link"
      continue
    }
    New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
    Write-Output "Linked: $link -> $($skill.FullName)"
  }
}
Write-Output 'VMCSkills installation complete.'
