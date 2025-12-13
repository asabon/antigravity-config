#!/bin/bash
set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_REPO_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT_DIR="$(pwd)"

echo "Setting up Antigravity configuration..."
echo "  Config Repo: $CONFIG_REPO_DIR"
echo "  Project Root: $PROJECT_ROOT_DIR"
echo ""

# 1. Create .agent directory
if [ ! -d ".agent" ]; then
    echo "Creating .agent directory..."
    mkdir .agent
else
    echo ".agent directory already exists."
fi

# 2. Copy config.yml.sample
SOURCE_CONFIG="$CONFIG_REPO_DIR/.agent/config.yml.sample"
TARGET_CONFIG=".agent/config.yml"

if [ ! -f "$TARGET_CONFIG" ]; then
    echo "Copying config.yml.sample..."
    cp "$SOURCE_CONFIG" "$TARGET_CONFIG"
    echo "  Please edit $TARGET_CONFIG to set your preferences."
else
    echo "config.yml already exists. Skipping copy."
fi

# 3. Link AGENT.md
SOURCE_RULES="$CONFIG_REPO_DIR/.agent/AGENT.md"
TARGET_RULES=".agent/AGENT.md"

if [ -e "$TARGET_RULES" ]; then
    echo ".agent/AGENT.md already exists. Please remove it if you want to link to the shared config."
else
    echo "Linking AGENT.md..."
    # Use relative path for symlink to handle different mount points or path styles better if needed,
    # but absolute is safer for standard use. Using absolute for clarity.
    ln -s "$SOURCE_RULES" "$TARGET_RULES"
fi

# 4. Link workflows directory
SOURCE_WORKFLOWS="$CONFIG_REPO_DIR/.agent/workflows"
TARGET_WORKFLOWS=".agent/workflows"

if [ -e "$TARGET_WORKFLOWS" ]; then
    echo ".agent/workflows already exists. Skipping link."
else
    echo "Linking workflows directory..."
    ln -s "$SOURCE_WORKFLOWS" "$TARGET_WORKFLOWS"
fi

echo ""
echo "Setup complete!"
