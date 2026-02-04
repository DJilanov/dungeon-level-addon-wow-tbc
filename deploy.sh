#!/bin/bash

# DungeonSpamTracker - Deploy Script
# Deploys addon to WoW 20th Anniversary AddOns folder

# Configuration
ADDON_NAME="DJDungeonSpamGuide"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
WOW_ADDONS_DIR="/Applications/World of Warcraft/_anniversary_/Interface/AddOns"
TARGET_DIR="$WOW_ADDONS_DIR/$ADDON_NAME"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}  DJ Dungeon Spam Guide Deployment    ${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Check if WoW AddOns directory exists
if [ ! -d "$WOW_ADDONS_DIR" ]; then
    echo -e "${RED}Error: WoW AddOns directory not found!${NC}"
    echo "Expected: $WOW_ADDONS_DIR"
    echo ""
    echo "Please ensure World of Warcraft is installed and the path is correct."
    exit 1
fi

# Check if source addon folder exists
ADDON_SOURCE="$SOURCE_DIR/$ADDON_NAME"
if [ ! -d "$ADDON_SOURCE" ]; then
    echo -e "${YELLOW}Warning: Addon source folder not found at $ADDON_SOURCE${NC}"
    echo "Looking for addon files in current directory..."

    # Check if we're inside the addon folder already
    if [ -f "$SOURCE_DIR/DJDungeonSpamGuide.toc" ]; then
        ADDON_SOURCE="$SOURCE_DIR"
        echo -e "${GREEN}Found addon files in current directory${NC}"
    else
        echo -e "${RED}Error: No addon files found!${NC}"
        echo "Please ensure the addon folder structure is correct."
        exit 1
    fi
fi

echo "Source: $ADDON_SOURCE"
echo "Target: $TARGET_DIR"
echo ""

# Remove existing addon folder if it exists
if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Removing existing addon installation...${NC}"
    rm -rf "$TARGET_DIR"
fi

# Create target directory
mkdir -p "$TARGET_DIR"

# Copy addon files
echo "Copying addon files..."

# List of files/folders to copy (modify as needed)
COPY_ITEMS=(
    "DJDungeonSpamGuide.toc"
    "Core"
    "Data"
    "UI"
    "Modules"
    "Locales"
    "Textures"
    "Libs"
)

# Copy each item if it exists
for item in "${COPY_ITEMS[@]}"; do
    if [ -e "$ADDON_SOURCE/$item" ]; then
        cp -R "$ADDON_SOURCE/$item" "$TARGET_DIR/"
        echo "  - Copied: $item"
    fi
done

# If structured copy didn't work, copy everything and exclude non-addon files
if [ ! -f "$TARGET_DIR/DJDungeonSpamGuide.toc" ]; then
    echo "Using full directory copy..."
    cp -R "$ADDON_SOURCE"/* "$TARGET_DIR/" 2>/dev/null

    # Remove non-addon files from target
    rm -f "$TARGET_DIR/deploy.sh" 2>/dev/null
    rm -f "$TARGET_DIR/README.md" 2>/dev/null
    rm -f "$TARGET_DIR/DEVELOPMENT_PLAN.md" 2>/dev/null
    rm -f "$TARGET_DIR/OPTIMIZATION_MODES.md" 2>/dev/null
    rm -f "$TARGET_DIR/table.csv" 2>/dev/null
    rm -rf "$TARGET_DIR/.git" 2>/dev/null
    rm -f "$TARGET_DIR/.gitignore" 2>/dev/null
    rm -f "$TARGET_DIR/.DS_Store" 2>/dev/null
fi

# Verify deployment
if [ -f "$TARGET_DIR/DJDungeonSpamGuide.toc" ]; then
    echo ""
    echo -e "${GREEN}======================================${NC}"
    echo -e "${GREEN}  Deployment Successful!              ${NC}"
    echo -e "${GREEN}======================================${NC}"
    echo ""
    echo "Addon installed to:"
    echo "  $TARGET_DIR"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Start/Restart World of Warcraft"
    echo "  2. Or type /reload in-game to reload UI"
    echo "  3. Type /dungeonspam or /ds to open the tracker"
    echo ""
else
    echo ""
    echo -e "${RED}======================================${NC}"
    echo -e "${RED}  Deployment Failed!                  ${NC}"
    echo -e "${RED}======================================${NC}"
    echo ""
    echo "The TOC file was not found after deployment."
    echo "Please check the addon folder structure."
    exit 1
fi
