# TBC Dungeon Spam Tracker

A World of Warcraft addon for the 20th Anniversary Edition (The Burning Crusade phase) that helps Alliance players track dungeon spam progress for optimal leveling and reputation gains from level 60-70.

## Features

- **Smart Dungeon Recommendations**: Automatically suggests the optimal dungeon based on your current level, reputation, and progression
- **Real-time Tracking**: Tracks dungeon runs, reputation gains, and experience progress
- **Zone Detection**: Shows recommendations when entering Outland via the Dark Portal
- **Comprehensive UI**: Beautiful main frame showing all dungeons, faction progress, and statistics
- **Run Calculations**: Estimates runs needed to cap reputation or reach next level
- **Progress Persistence**: Saves all tracking data between sessions

## Installation

### Automatic Deployment

```bash
./deploy.sh
```

The script will automatically:
- Copy addon files to your WoW AddOns folder
- Verify successful installation
- Show next steps

### Manual Installation

1. Copy the `DungeonSpamTracker` folder to:
   ```
   /Applications/World of Warcraft/_anniversary_/Interface/AddOns/
   ```

2. Restart WoW or type `/reload` in-game

## Usage

### Commands

- `/dungeonspam` or `/ds` - Open/close the tracker window
- `/ds recommend` - Show current dungeon recommendation in chat
- `/ds status` - Show current character status
- `/ds runs` - Show dungeon run counts
- `/ds reset` - Reset all tracking data (with confirmation)
- `/ds help` - Show command help

### Main Interface

The main UI shows:
1. **Character Header**: Your current level and XP progress
2. **Current Recommendation**: The optimal dungeon to run next with stats
3. **All Dungeons**: Complete list with status, rep progress, and estimates
4. **Faction Progress**: Real-time reputation bars for all TBC factions

### Automatic Features

- **Dark Portal Entry**: When entering Outland for the first time, shows recommended starting dungeon
- **Dungeon Entry**: Tracks runs automatically when you enter a dungeon (if enabled in settings)
- **Reputation Updates**: Real-time updates when reputation changes
- **Level Up**: Shows new dungeon recommendations when you level

## Dungeon Progression Guide

The addon tracks these 15 TBC dungeons in optimal order:

1. **Hellfire Ramparts** (60-62) - Honor Hold
2. **Blood Furnace** (61-63) - Honor Hold
3. **Slave Pens** (62-64) - Cenarion Expedition
4. **Underbog** (63-65) - Cenarion Expedition
5. **Mana-Tombs** (64-66) - The Consortium
6. **Auchenai Crypts** (65-67) - Lower City
7. **Sethekk Halls** (67-68) - Lower City
8. **Old Hillsbrad** (66-68) - Keepers of Time
9. **Shadow Labyrinth** (68-70) - Lower City (Exalted)
10. **Steamvault** (68-70) - Cenarion Expedition (Exalted)
11. **Shattered Halls** (69-70) - Honor Hold
12. **Mechanar** (69-70) - The Sha'tar
13. **Botanica** (70) - The Sha'tar (Best rep/hr)
14. **Arcatraz** (70) - The Sha'tar
15. **Black Morass** (70) - Keepers of Time

## Factions & Heroic Keys

### Alliance Factions
- **Honor Hold** - Hellfire Peninsula dungeons
- **Cenarion Expedition** - Zangarmarsh dungeons
- **Lower City** - Auchindoun dungeons
- **Keepers of Time** - Caverns of Time dungeons
- **The Sha'tar** - Tempest Keep dungeons
- **The Consortium** - Mana-Tombs

### Heroic Key Requirements
All heroic keys require **Honored** reputation with the respective faction.

## Development

### Project Structure

```
DungeonSpamTracker/
├── DungeonSpamTracker.toc
├── Core/
│   ├── Init.lua
│   ├── Constants.lua
│   ├── Events.lua
│   └── SlashCommands.lua
├── Data/
│   ├── DungeonData.lua
│   ├── ExpPerLevel.lua
│   └── ReputationThresholds.lua
├── Modules/
│   ├── Tracker.lua
│   ├── Recommender.lua
│   └── ZoneDetection.lua
├── UI/
│   ├── MainFrame.lua
│   ├── DungeonCard.lua
│   └── ProgressBar.lua
└── Locales/
    └── enUS.lua
```

### Key Modules

- **Tracker**: Manages run counts, reputation tracking, and XP progress
- **Recommender**: Smart dungeon recommendation engine
- **ZoneDetection**: Detects Dark Portal entry and current zone
- **MainFrame**: Primary UI with all dungeon information

## Data Source

Dungeon statistics (reputation, experience, duration) sourced from `table.csv` based on TBC Classic data.

## Troubleshooting

### Addon doesn't appear in-game
- Ensure you deployed to the correct folder
- Check interface version matches (should be 11503 for Anniversary TBC)
- Type `/reload` to refresh the UI

### Lua errors
- Check the error message with an error display addon
- Verify all files were copied correctly
- Try resetting with `/ds reset`

### Reputation not updating
- Verify you have the correct faction IDs for Alliance
- Check that UPDATE_FACTION events are firing
- Try leaving and re-entering a dungeon

## Version

**1.0.0** - Initial Release

## Author

Dimitar Jilanov

## License

This addon is free to use and modify for personal use.

---

**Note**: This addon is designed specifically for the TBC phase of WoW's 20th Anniversary Edition. It tracks Alliance factions and dungeons.
