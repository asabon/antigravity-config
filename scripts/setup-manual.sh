#!/bin/bash
set -e

# Get directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_REPO_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT_DIR="$(pwd)"
TARGET_WORKFLOWS_DIR="$PROJECT_ROOT_DIR/.agent/workflows"
SOURCE_CHECK_UPDATES="$CONFIG_REPO_DIR/.agent/workflows/check-updates.md"
TARGET_CHECK_UPDATES="$TARGET_WORKFLOWS_DIR/check-updates.md"

echo "Setting up Antigravity configuration (Manual Mode)..."
echo "  Config Repo: $CONFIG_REPO_DIR"
echo "  Project Root: $PROJECT_ROOT_DIR"
echo ""

# 1. Create .agent/workflows directory
if [ ! -d "$TARGET_WORKFLOWS_DIR" ]; then
    echo "Creating .agent/workflows directory..."
    mkdir -p "$TARGET_WORKFLOWS_DIR"
fi

# 2. Copy check-updates.md
if [ -f "$TARGET_CHECK_UPDATES" ]; then
    echo "File '$TARGET_CHECK_UPDATES' already exists. Skipping copy."
else
    echo "Copying check-updates.md..."
    cp "$SOURCE_CHECK_UPDATES" "$TARGET_CHECK_UPDATES"
    echo "  Copied to: $TARGET_CHECK_UPDATES"
fi

echo ""
echo "Setup complete!"
echo "Now you can run the following command in your chat to compare and adopt configurations:"
echo "  /check-updates"
