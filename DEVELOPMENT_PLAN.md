# TBC Dungeon Spam Tracker Addon - Development Plan

## Overview

A World of Warcraft addon for the 20th Anniversary Edition (The Burning Crusade phase) that helps Alliance players track dungeon spam progress for optimal leveling and reputation gains from level 60-70.

---

## Project Structure

```
DungeonSpamTracker/
├── DungeonSpamTracker.toc           # Addon metadata and file loading order
├── Core/
│   ├── Init.lua                     # Addon initialization and saved variables
│   ├── Constants.lua                # Static data (dungeons, rep thresholds, exp tables)
│   ├── SlashCommands.lua            # /dungeonspam command handler
│   └── Events.lua                   # Game event handlers (zone change, rep update, etc.)
├── Data/
│   ├── DungeonData.lua              # Dungeon information (rep, exp, duration, guides)
│   ├── ReputationThresholds.lua     # Rep caps and heroic requirements
│   └── ExpPerLevel.lua              # Experience required per level (60-70)
├── UI/
│   ├── MainFrame.lua                # Main UI window
│   ├── MainFrame.xml                # XML template for main frame
│   ├── DungeonCard.lua              # Individual dungeon info cards
│   ├── ProgressBar.lua              # Custom progress bar component
│   └── Tooltip.lua                  # Enhanced tooltips for dungeon info
├── Modules/
│   ├── Tracker.lua                  # Core tracking logic (runs, rep, exp)
│   ├── Recommender.lua              # Smart dungeon recommendation engine
│   └── ZoneDetection.lua            # Detect when entering dungeons/Dark Portal
├── Locales/
│   └── enUS.lua                     # English localization
└── Libs/                            # Optional: Ace3 libraries if needed
```

---

## Core Features

### 1. Smart Dungeon Recommendation System

When the player opens the addon or triggers an event, recommend the optimal dungeon based on:

- **Current Level**: Only suggest level-appropriate dungeons
- **Current Reputation Standing**: Skip dungeons where rep is already capped
- **Completion Status**: Track completed dungeon phases

#### Dungeon Progression Order (Alliance)

| Phase | Dungeon | Level Range | Faction | Rep Cap | Notes |
|-------|---------|-------------|---------|---------|-------|
| 1 | Hellfire Ramparts | 60-62 | Honor Hold | Friendly (6,000) | Starting dungeon |
| 2 | Blood Furnace | 61-63 | Honor Hold | Friendly (6,000) | Required for SSC attunement |
| 3 | Slave Pens | 62-64 | Cenarion Expedition | Friendly (6,000) | Coilfang heroic key |
| 4 | Underbog | 63-65 | Cenarion Expedition | Honored (12,000) | Continue CE rep |
| 5 | Mana-Tombs | 64-66 | Consortium | Honored (12,000) | Ethereum keys |
| 6 | Auchenai Crypts | 65-67 | Lower City | Honored (12,000) | Auchindoun heroic key |
| 7 | Sethekk Halls | 67-68 | Lower City | Honored (12,000) | Kara attunement |
| 8 | Old Hillsbrad | 66-68 | Keepers of Time | Exalted | CoT heroic key |
| 9 | Shadow Labyrinth | 68-70 | Lower City | Exalted | Kara attunement |
| 10 | Steamvault | 68-70 | Cenarion Expedition | Exalted | Best CE rep grind |
| 11 | Shattered Halls | 69-70 | Honor Hold | Honored+ | SSC attunement |
| 12 | Mechanar | 69-70 | Sha'tar | Exalted | Head glyphs |
| 13 | Botanica | 70 | Sha'tar | Exalted | Best Sha'tar rep |
| 14 | Arcatraz | 70 | Sha'tar | Exalted | Kara attunement |
| 15 | Black Morass | 70 | Keepers of Time | Exalted | Kara attunement |

### 2. Progress Tracking

Track and display:
- **Runs completed** per dungeon
- **Current reputation** vs target for each faction
- **Estimated runs remaining** to reach rep goals
- **Current XP progress** and runs to level

### 3. Event-Based Notifications

Trigger UI/notifications when:
- **Entering Dark Portal**: Show "Go to Hellfire Ramparts" (or appropriate dungeon)
- **Entering a dungeon**: Show run count, remaining runs for rep cap
- **Completing a dungeon**: Update stats, show next recommendation
- **Reaching rep milestone**: Notify and suggest next dungeon

### 4. Main UI Panel (`/dungeonspam`)

A comprehensive panel showing:

```
+------------------------------------------------------------------+
|  TBC DUNGEON SPAM TRACKER                              [X] Close |
+------------------------------------------------------------------+
|  Character: [Name] | Level: 63 | XP: 145,000/290,000            |
+------------------------------------------------------------------+
|  CURRENT RECOMMENDATION                                          |
|  ┌────────────────────────────────────────────────────────────┐ |
|  │  >> SLAVE PENS <<                                          │ |
|  │  Faction: Cenarion Expedition (2,150 / 6,000 Friendly)     │ |
|  │  Est. Runs to Cap: 5 | Est. Runs to Level: 6               │ |
|  │  Time per Run: ~22 min | Rep/hr: 2,320 | XP/hr: 131,000    │ |
|  └────────────────────────────────────────────────────────────┘ |
+------------------------------------------------------------------+
|  ALL DUNGEONS                                      [Filter: All] |
+------------------------------------------------------------------+
|  ✓ Hellfire Ramparts   | Honor Hold    | COMPLETE (Friendly)    |
|  ✓ Blood Furnace       | Honor Hold    | COMPLETE (Friendly)    |
|  ► Slave Pens          | Cenarion Exp. | 2,150/6,000 (3 runs)   |
|  ○ Underbog            | Cenarion Exp. | Locked (need 63)       |
|  ○ Mana-Tombs          | Consortium    | Locked (need 64)       |
|  ...                                                             |
+------------------------------------------------------------------+
|  QUICK STATS                                                     |
|  Honor Hold: 6,000/6,000 ████████████ Friendly (CAPPED)         |
|  Cenarion:   2,150/6,000 ████░░░░░░░░ Friendly                  |
|  Sha'tar:        0/6,000 ░░░░░░░░░░░░ Neutral                   |
+------------------------------------------------------------------+
```

### 5. Dungeon Detail View

Click a dungeon to see:
- Full dungeon guide/tips
- Boss order and notable drops
- Specific rep and XP values
- Historical run data

---

## Technical Implementation

### TOC File (DungeonSpamTracker.toc)

```lua
## Interface: 11503
## Title: Dungeon Spam Tracker
## Notes: Track TBC dungeon spam progress for leveling and reputation
## Author: [Your Name]
## Version: 1.0.0
## SavedVariables: DungeonSpamTrackerDB
## IconTexture: Interface\Icons\INV_Misc_Book_09

Core\Init.lua
Core\Constants.lua
Data\ExpPerLevel.lua
Data\ReputationThresholds.lua
Data\DungeonData.lua
Core\Events.lua
Core\SlashCommands.lua
Modules\Tracker.lua
Modules\Recommender.lua
Modules\ZoneDetection.lua
UI\MainFrame.xml
UI\MainFrame.lua
UI\DungeonCard.lua
UI\ProgressBar.lua
UI\Tooltip.lua
```

### Key API Functions (WoW 20th Anniversary / 1.15.x)

```lua
-- Player Info
UnitLevel("player")                          -- Current level
UnitXP("player")                             -- Current XP
UnitXPMax("player")                          -- XP needed for current level

-- Reputation
GetNumFactions()                             -- Number of faction entries
GetFactionInfo(index)                        -- Get faction details
GetFactionInfoByID(factionID)                -- Get by faction ID

-- Alliance TBC Faction IDs:
-- Honor Hold: 946
-- Cenarion Expedition: 942
-- The Sha'tar: 935
-- Lower City: 1011
-- Keepers of Time: 989
-- The Consortium: 933

-- Zone Detection
GetInstanceInfo()                            -- Returns instance name, type, etc.
GetRealZoneText()                            -- Current zone name
C_Map.GetBestMapForUnit("player")            -- Map ID

-- Instance IDs for dungeons:
-- Hellfire Ramparts: 543
-- Blood Furnace: 542
-- Slave Pens: 547
-- Underbog: 546
-- Mana-Tombs: 557
-- Auchenai Crypts: 558
-- Sethekk Halls: 556
-- Shadow Labyrinth: 555
-- Old Hillsbrad: 560
-- Black Morass: 269
-- Shattered Halls: 540
-- Mechanar: 554
-- Botanica: 553
-- Arcatraz: 552
-- Steamvault: 545

-- Events to Register
"ZONE_CHANGED_NEW_AREA"                      -- Zone changes
"PLAYER_ENTERING_WORLD"                      -- Loading screen complete
"UPDATE_FACTION"                             -- Rep changed
"PLAYER_XP_UPDATE"                           -- XP changed
"PLAYER_LEVEL_UP"                            -- Level up
"CHAT_MSG_SYSTEM"                            -- For dungeon completion detection
```

### Saved Variables Structure

```lua
DungeonSpamTrackerDB = {
    profile = {
        showOnDarkPortal = true,
        showOnDungeonEnter = true,
        minimap = { hide = false },
        framePosition = { point = "CENTER", x = 0, y = 0 },
    },
    char = {
        -- Per-character data
        dungeonRuns = {
            ["Hellfire Ramparts"] = 12,
            ["Blood Furnace"] = 8,
            -- ...
        },
        completedPhases = {
            ["Hellfire Ramparts"] = true,  -- Rep capped
            -- ...
        },
        lastRecommendation = "Slave Pens",
    }
}
```

### Dungeon Data Structure

```lua
local DungeonData = {
    ["Hellfire Ramparts"] = {
        id = 543,
        mapID = 3562,
        faction = "Honor Hold",
        factionID = 946,
        repPerRun = 633,
        repCap = "Friendly",
        repCapValue = 6000,
        expPerRun = 45000,
        avgDuration = 20, -- minutes
        minLevel = 60,
        maxLevel = 67,
        zone = "Hellfire Peninsula",
        entrance = { x = 47.5, y = 53.6 },
        guide = {
            "Pull carefully at the start - patrols overlap",
            "Boss 1: Watchkeeper - interrupt Mortal Strike",
            "Boss 2: Omor - tank faces away, cleave adds",
            "Boss 3: Nazan - stay spread, move from fire",
        },
        requiredFor = {
            "Heroic Keys (Revered Honor Hold)",
            "Plate/Mail/Cloth gear",
            "BS/JC/LW recipes",
        },
    },
    -- ... more dungeons
}
```

---

## UI Implementation Details

### Frame Creation (Modern WoW API)

```lua
-- Create main frame using BackdropTemplate for 20th Anniversary
local frame = CreateFrame("Frame", "DungeonSpamTrackerFrame", UIParent,
    BackdropTemplateMixin and "BackdropTemplate")
frame:SetSize(600, 500)
frame:SetPoint("CENTER")
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

-- Make closeable with ESC
tinsert(UISpecialFrames, "DungeonSpamTrackerFrame")
```

### Progress Bar Component

```lua
local function CreateProgressBar(parent, width, height)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(width, height)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetMinMaxValues(0, 100)

    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0.1, 0.1, 0.1, 0.8)

    bar.text = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bar.text:SetPoint("CENTER")

    return bar
end
```

### Slash Command Registration

```lua
SLASH_DUNGEONSPAM1 = "/dungeonspam"
SLASH_DUNGEONSPAM2 = "/ds"
SlashCmdList["DUNGEONSPAM"] = function(msg)
    msg = string.lower(msg or "")
    if msg == "reset" then
        -- Reset tracking data
        DungeonSpamTracker:Reset()
    elseif msg == "config" or msg == "options" then
        -- Show options
        DungeonSpamTracker:ShowOptions()
    else
        -- Toggle main frame
        DungeonSpamTracker:Toggle()
    end
end
```

---

## Reputation Thresholds Reference

| Standing | Min Rep | Max Rep | Total from Neutral |
|----------|---------|---------|-------------------|
| Hated | -42000 | -6001 | - |
| Hostile | -6000 | -3001 | - |
| Unfriendly | -3000 | -1 | - |
| Neutral | 0 | 2999 | 0 |
| Friendly | 3000 | 8999 | 3000 |
| Honored | 9000 | 20999 | 9000 |
| Revered | 21000 | 41999 | 21000 |
| Exalted | 42000 | 42999 | 42000 |

### Heroic Key Requirements (Alliance)

| Key | Faction | Required Standing |
|-----|---------|-------------------|
| Flamewrought Key (Hellfire Citadel) | Honor Hold | Honored |
| Reservoir Key (Coilfang Reservoir) | Cenarion Expedition | Honored |
| Auchenai Key (Auchindoun) | Lower City | Honored |
| Key of Time (Caverns of Time) | Keepers of Time | Honored |
| Warpforged Key (Tempest Keep) | The Sha'tar | Honored |

---

## Experience per Level (TBC)

| Level | XP Required | Cumulative |
|-------|-------------|------------|
| 60-61 | 290,000 | 290,000 |
| 61-62 | 317,000 | 607,000 |
| 62-63 | 349,000 | 956,000 |
| 63-64 | 386,000 | 1,342,000 |
| 64-65 | 428,000 | 1,770,000 |
| 65-66 | 475,000 | 2,245,000 |
| 66-67 | 527,000 | 2,772,000 |
| 67-68 | 586,000 | 3,358,000 |
| 68-69 | 651,000 | 4,009,000 |
| 69-70 | 723,000 | 4,732,000 |

---

## Event Flow

### On Addon Load
1. Initialize saved variables
2. Register events
3. Load character progress
4. Calculate current recommendation

### On Zone Change (Dark Portal / Dungeon)
1. Detect if entering Outland via Dark Portal
2. If first time, show welcome message + first dungeon recommendation
3. If entering dungeon, show dungeon-specific info card

### On Dungeon Completion
1. Increment run counter
2. Update estimated rep (actual rep updates via UPDATE_FACTION event)
3. Recalculate recommendation
4. Show completion notification

### On Rep Update
1. Check if any rep cap reached
2. Update UI progress bars
3. If cap reached, mark dungeon phase complete
4. Recalculate recommendation

---

## Development Phases

### Phase 1: Core Foundation
- [ ] Create addon folder structure
- [ ] Write TOC file with correct interface version
- [ ] Implement Init.lua with saved variables
- [ ] Create dungeon data tables from CSV
- [ ] Implement basic slash command

### Phase 2: Tracking Logic
- [ ] Implement reputation tracking module
- [ ] Implement XP tracking module
- [ ] Create dungeon run counter
- [ ] Build recommendation engine

### Phase 3: UI Development
- [ ] Create main frame with backdrop
- [ ] Build dungeon list view
- [ ] Create progress bar components
- [ ] Add faction reputation display
- [ ] Implement current recommendation panel

### Phase 4: Event Handling
- [ ] Zone change detection
- [ ] Dark Portal entry detection
- [ ] Dungeon entry/exit detection
- [ ] Rep and XP update handlers

### Phase 5: Polish & Testing
- [ ] Add dungeon guides/tips
- [ ] Implement minimap button (optional)
- [ ] Test all dungeons
- [ ] Performance optimization
- [ ] Final UI polish

---

## Deploy Script

Create `deploy.sh` in the addon root:

```bash
#!/bin/bash

# Configuration
ADDON_NAME="DungeonSpamTracker"
SOURCE_DIR="$(dirname "$0")"
WOW_ADDONS_DIR="/Applications/World of Warcraft/_anniversary_/Interface/AddOns"
TARGET_DIR="$WOW_ADDONS_DIR/$ADDON_NAME"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Deploying $ADDON_NAME..."

# Check if WoW AddOns directory exists
if [ ! -d "$WOW_ADDONS_DIR" ]; then
    echo -e "${RED}Error: WoW AddOns directory not found at $WOW_ADDONS_DIR${NC}"
    exit 1
fi

# Remove existing addon folder if it exists
if [ -d "$TARGET_DIR" ]; then
    echo "Removing existing addon folder..."
    rm -rf "$TARGET_DIR"
fi

# Create target directory
mkdir -p "$TARGET_DIR"

# Copy all addon files
echo "Copying addon files..."
cp -R "$SOURCE_DIR"/* "$TARGET_DIR/"

# Remove non-addon files from target
rm -f "$TARGET_DIR/deploy.sh"
rm -f "$TARGET_DIR/README.md"
rm -f "$TARGET_DIR/DEVELOPMENT_PLAN.md"
rm -f "$TARGET_DIR/table.csv"
rm -rf "$TARGET_DIR/.git"
rm -f "$TARGET_DIR/.gitignore"

echo -e "${GREEN}Deployment complete!${NC}"
echo "Addon installed to: $TARGET_DIR"
echo ""
echo "To test: Restart WoW or type /reload in-game"
```

Make executable:
```bash
chmod +x deploy.sh
```

---

## Testing Checklist

- [ ] Addon loads without errors
- [ ] `/dungeonspam` opens UI
- [ ] `/ds` alias works
- [ ] UI displays correctly at various resolutions
- [ ] Rep tracking updates in real-time
- [ ] XP tracking updates correctly
- [ ] Dungeon recommendations are accurate
- [ ] Zone detection works (Dark Portal, dungeons)
- [ ] Progress persists between sessions
- [ ] ESC closes the window
- [ ] Frame is draggable and position saves
- [ ] No Lua errors in error log

---

## Notes for 20th Anniversary Edition

The 20th Anniversary Edition uses a modified Classic client with some API differences:

1. **Interface Version**: Use `11503` or check current version in-game with `/dump select(4, GetBuildInfo())`

2. **BackdropTemplate**: Required for frames with backdrops - use `BackdropTemplateMixin and "BackdropTemplate"` as template

3. **C_AddOns API**: Use `C_AddOns.GetAddOnMetadata()` instead of `GetAddOnMetadata()`

4. **No C_Container**: Container API is different from Retail

5. **Classic Rep System**: Use `GetFactionInfo()` and `GetFactionInfoByID()`

6. **Instance Detection**: `GetInstanceInfo()` works similarly to other Classic versions

---

## Resources & References

- WoW API Documentation: https://wowpedia.fandom.com/wiki/World_of_Warcraft_API
- TBC Dungeon Data: Sourced from table.csv
- AtlasLootClassic addon structure: Reference implementation
- WoW Addon Development: https://www.wowinterface.com/

---

*Last Updated: February 2026*
*Target Release: TBC 20th Anniversary Launch*
