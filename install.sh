#!/bin/bash
set -e

echo "Shua Dev Framework — Installer"
echo "==============================="
echo ""

# Check for existing config
if [ -f ~/.claude/CLAUDE.md ]; then
    BACKUP="$HOME/.claude/CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)"
    echo "Existing CLAUDE.md found. Backing up to: $BACKUP"
    cp ~/.claude/CLAUDE.md "$BACKUP"
fi

if [ -f ~/.claude/settings.json ]; then
    BACKUP="$HOME/.claude/settings.json.backup.$(date +%Y%m%d%H%M%S)"
    echo "Existing settings.json found. Backing up to: $BACKUP"
    cp ~/.claude/settings.json "$BACKUP"
fi

# Create directory structure
echo ""
echo "Creating directory structure..."
mkdir -p ~/.claude/{commands,skills/orchestrator-framework,skills/spec-writing,skills/mcp-server-setup,rules}

# Prompt for personalization
echo ""
read -p "Your name (e.g., Jane Smith): " USER_NAME
read -p "Your location (e.g., San Francisco, CA): " USER_LOCATION
read -p "Your machine (e.g., MacBook Pro M4 with 64GB): " USER_MACHINE

# Install CLAUDE.md with personalization
echo ""
echo "Installing CLAUDE.md..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
sed \
    -e "s/\[YOUR_NAME\]/$USER_NAME/g" \
    -e "s/\[YOUR_LOCATION\]/$USER_LOCATION/g" \
    -e "s/\[YOUR_MACHINE\]/$USER_MACHINE/g" \
    "$SCRIPT_DIR/global-claude-md.template" > ~/.claude/CLAUDE.md

# Copy all config files
echo "Installing settings.json..."
cp "$SCRIPT_DIR/settings.json" ~/.claude/settings.json

echo "Installing commands..."
cp "$SCRIPT_DIR/commands/"*.md ~/.claude/commands/

echo "Installing skills..."
cp "$SCRIPT_DIR/skills/orchestrator-framework/SKILL.md" ~/.claude/skills/orchestrator-framework/
cp "$SCRIPT_DIR/skills/spec-writing/SKILL.md" ~/.claude/skills/spec-writing/
cp "$SCRIPT_DIR/skills/mcp-server-setup/SKILL.md" ~/.claude/skills/mcp-server-setup/

echo "Installing rules..."
cp "$SCRIPT_DIR/rules/"*.md ~/.claude/rules/

# Initialize lessons file if it doesn't exist
if [ ! -f ~/.claude/lessons.md ]; then
    echo "Initializing lessons.md..."
    cp "$SCRIPT_DIR/lessons.md.example" ~/.claude/lessons.md
else
    echo "Existing lessons.md found — keeping it."
fi

echo ""
echo "Installation complete!"
echo ""
echo "Installed to ~/.claude/:"
find ~/.claude -type f | sort | sed 's|^|  |'
echo ""
echo "Every new Claude Code session will now load this configuration automatically."
