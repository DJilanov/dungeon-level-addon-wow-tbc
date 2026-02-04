# WoW Addon Debugging Guide - DJ Dungeon Spam Guide

## Step 1: Verify Interface Version

Your TOC file currently has:
```
## Interface: 20505
```

This is for **TBC Classic Phase 5**.

### To check your WoW version:
1. Launch WoW
2. Type in chat: `/dump select(4, GetBuildInfo())`
3. You'll see a number like "20505" or "110002"
4. Update line 1 of `DJDungeonSpamGuide.toc` to match that number

**Common Interface Versions:**
- TBC Classic: 20504-20505
- Wrath Classic: 30400-30403
- Cataclysm Classic: 40400+
- Retail (TWW): 110000-110002

## Step 2: Copy Addon to Correct Location

Make sure your addon folder is in the right place:

**For TBC/Wrath/Cata Classic:**
```
World of Warcraft/_classic_/Interface/AddOns/DJDungeonSpamGuide/
```

**For Retail:**
```
World of Warcraft/_retail_/Interface/AddOns/DJDungeonSpamGuide/
```

The folder **must** be named `DJDungeonSpamGuide` (matching the TOC filename).

## Step 3: Enable Lua Errors

In WoW, type:
```
/console scriptErrors 1
```

Then reload:
```
/reload
```

This will show you any Lua errors that occur when the addon loads.

## Step 4: Check Addon Manager

1. Press **Esc** → **AddOns** (or type `/addons`)
2. Look for "DJ Dungeon Spam Guide"
3. Make sure it's checked (enabled)
4. Look for any red error text

## Step 5: Test the Addon

After enabling it and reloading, try these commands:
```
/dungeonspam
/ds
/ds help
```

If it works, you should see the addon's UI or help text.

## Common Issues & Solutions

### Issue: Addon doesn't appear in the addon list
**Solution:**
- Wrong folder location
- Folder name doesn't match TOC filename
- TOC file is missing or corrupted

### Issue: Addon appears but is grayed out
**Solution:**
- Interface version mismatch
- Update the first line of the .toc file

### Issue: Addon loads but doesn't work
**Solution:**
- Check for Lua errors with `/console scriptErrors 1`
- Look for errors when you try to use `/ds`

### Issue: "Interface too old" message
**Solution:**
- Your Interface version in the TOC is too low
- Increase the number on line 1 of the .toc file

## Manual Installation Steps

1. Copy the entire `DJDungeonSpamGuide` folder
2. Navigate to your WoW installation:
   - Windows: `C:\Program Files (x86)\World of Warcraft\`
   - Mac: `/Applications/World of Warcraft/`
3. Go to either `_classic_` or `_retail_` folder (depending on which you play)
4. Go to `Interface\AddOns\`
5. Paste the `DJDungeonSpamGuide` folder there
6. Restart WoW completely (or type `/reload` if already running)

## Still Not Working?

If you've tried all the above and it still doesn't work:

1. Check the addon folder structure looks like this:
```
DJDungeonSpamGuide/
├── DJDungeonSpamGuide.toc
├── Core/
│   ├── Init.lua
│   ├── Constants.lua
│   ├── Events.lua
│   └── SlashCommands.lua
├── Data/
│   ├── DungeonData.lua
│   ├── ExpPerLevel.lua
│   └── ReputationThresholds.lua
├── Locales/
│   └── enUS.lua
├── Modules/
│   ├── Recommender.lua
│   ├── Tracker.lua
│   └── ZoneDetection.lua
└── UI/
    ├── DungeonCard.lua
    ├── MainFrame.lua
    └── ProgressBar.lua
```

2. Enable Lua error display and check what error appears
3. Make sure you're on the correct WoW client (Classic vs Retail)
