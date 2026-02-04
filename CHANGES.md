# Recent Changes to DJ Dungeon Spam Guide

## Completed Tasks

### 1. Removed Strategy Tab
- Removed "Strategy" from the tab list in [DungeonDetailFrame.lua:88](DJDungeonSpamGuide/UI/DungeonDetailFrame.lua#L88)
- Updated SelectTab function to remove Strategy handling
- The detail view now shows only: Bosses, Loot, and Location tabs

### 2. Added Dungeon Map Images from Atlas
- Created helper function `GetAtlasTexturePath()` to map dungeon names to Atlas addon texture paths
- Added support for displaying Atlas dungeon maps in the Location tab
- Maps are displayed as 320x240 textures below location information
- Shows placeholder with message "Map texture not found - Install Atlas addon for maps" if Atlas is not installed

### 3. Added Location/Entrance Screenshots
- Created `/Textures` folder for entrance screenshots
- Added entrance screenshot display (320x240) positioned to the right of dungeon maps
- Entrance screenshots use naming convention: `Interface\AddOns\DJDungeonSpamGuide\Textures\[DungeonName]_Entrance`
- Shows placeholder with message "Entrance screenshot not available" until images are added

## Implementation Details

### Location Tab Changes
The Location tab now displays:
1. Text information (zone, entrance, requirements, etc.)
2. Dungeon map from Atlas addon (left side)
3. Entrance screenshot (right side)

### Adding Custom Entrance Screenshots
To add entrance screenshots, place `.tga` or `.blp` files in:
```
DJDungeonSpamGuide/Textures/
```

Use this naming format:
- `HellfireRamparts_Entrance.tga`
- `BloodFurnace_Entrance.tga`
- `SlavePens_Entrance.tga`
- etc.

Update the `.toc` file if needed to include texture files.
