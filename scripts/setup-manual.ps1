$ErrorActionPreference = "Stop"

# Paths
$ConfigRepoDir = Resolve-Path "$PSScriptRoot/.."
$ProjectRootDir = Get-Location
$TargetWorkflowsDir = Join-Path $ProjectRootDir ".agent/workflows"
$SourceCheckUpdates = Join-Path $ConfigRepoDir ".agent/workflows/check-updates.md"
$TargetCheckUpdates = Join-Path $TargetWorkflowsDir "check-updates.md"

Write-Host "Setting up Antigravity configuration (Manual Mode)..."
Write-Host "  Config Repo: $ConfigRepoDir"
Write-Host "  Project Root: $ProjectRootDir"
Write-Host ""

# 1. Create .agent/workflows directory
if (-not (Test-Path $TargetWorkflowsDir)) {
    Write-Host "Creating .agent/workflows directory..."
    New-Item -ItemType Directory -Path $TargetWorkflowsDir -Force | Out-Null
}

# 2. Copy check-updates.md
if (Test-Path $TargetCheckUpdates) {
    Write-Host "File '$TargetCheckUpdates' already exists. Skipping copy." -ForegroundColor Yellow
}
else {
    Write-Host "Copying check-updates.md..."
    Copy-Item -Path $SourceCheckUpdates -Destination $TargetCheckUpdates
    Write-Host "  Copied to: $TargetCheckUpdates" -ForegroundColor Green
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "Now you can run the following command in your chat to compare and adopt configurations:"
Write-Host "  /check-updates" -ForegroundColor Cyan
