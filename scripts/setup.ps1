$ErrorActionPreference = "Stop"

# Use PSScriptRoot to properly locate the source files relative to the script
# The target directory is presumed to be the root of the project consuming this config,
# which is two levels up from scripts/setup.ps1 (i.e., .shared-config/scripts/setup.ps1 -> .shared-config -> project-root)
# IF this script is run from inside the submodule.
# HOWEVER, simpler assumption: User runs this script FROM the project root, defining where the config is.
# Let's support running it via: ./.shared-config/scripts/setup.ps1

$ConfigRepoDir = Resolve-Path "$PSScriptRoot/.."
$ProjectRootDir = Get-Location

Write-Host "Setting up Antigravity configuration..."
Write-Host "  Config Repo: $ConfigRepoDir"
Write-Host "  Project Root: $ProjectRootDir"
Write-Host ""

# 1. Create .agent directory in project root
$AgentDir = Join-Path $ProjectRootDir ".agent"
if (-not (Test-Path $AgentDir)) {
    Write-Host "Creating .agent directory..."
    New-Item -ItemType Directory -Path $AgentDir | Out-Null
}
else {
    Write-Host ".agent directory already exists."
}

# 2. Copy config.yml.sample if config.yml doesn't exist
$SourceConfig = Join-Path $ConfigRepoDir ".agent/config.yml.sample"
$TargetConfig = Join-Path $AgentDir "config.yml"

if (-not (Test-Path $TargetConfig)) {
    Write-Host "Copying config.yml.sample..."
    Copy-Item $SourceConfig $TargetConfig
    Write-Host "  Please edit $TargetConfig to set your preferences." -ForegroundColor Yellow
}
else {
    Write-Host "config.yml already exists. Skipping copy."
}

# 3. Link AGENT.md
$SourceRules = Join-Path $ConfigRepoDir ".agent/AGENT.md"
$TargetRules = Join-Path $AgentDir "AGENT.md"

if (Test-Path $TargetRules) {
    Write-Host ".agent/AGENT.md already exists. Please remove it if you want to link to the shared config." -ForegroundColor Yellow
}
else {
    Write-Host "Linking AGENT.md..."
    # Try HardLink first as it doesn't require admin privileges for files
    try {
        New-Item -ItemType HardLink -Path $TargetRules -Target $SourceRules | Out-Null
    }
    catch {
        Write-Host "  HardLink failed, trying SymbolicLink..."
        New-Item -ItemType SymbolicLink -Path $TargetRules -Target $SourceRules | Out-Null
    }
}

# 4. Link workflows directory
$SourceWorkflows = Join-Path $ConfigRepoDir ".agent/workflows"
$TargetWorkflows = Join-Path $AgentDir "workflows"

if (Test-Path $TargetWorkflows) {
    Write-Host ".agent/workflows already exists. Skipping link." -ForegroundColor Yellow
}
else {
    Write-Host "Linking workflows directory..."
    # Use Junction for directories on Windows (no admin required usually)
    New-Item -ItemType Junction -Path $TargetWorkflows -Target $SourceWorkflows | Out-Null
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
