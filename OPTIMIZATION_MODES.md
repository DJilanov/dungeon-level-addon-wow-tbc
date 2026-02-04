# Optimization Modes Feature

The Dungeon Spam Tracker now supports **three optimization modes** to match different player goals:

## 🎯 Optimization Modes

### 1. **Maximize XP**
**Best for**: Players focused on leveling as fast as possible (levels 60-69)

- Prioritizes dungeons with the **highest XP/hour**
- Automatically sorts available dungeons by experience gain rate
- Example: Hellfire Ramparts (135,000 XP/hr) → Blood Furnace (131,000 XP/hr)
- At level 70, automatically switches to rep optimization

**Best XP/Hour Dungeons:**
- Hellfire Ramparts: 135,000 XP/hr
- Slave Pens: 131,000 XP/hr
- Blood Furnace: 131,000 XP/hr
- Mana-Tombs: 131,000 XP/hr
- Shattered Halls: 120,000 XP/hr
- Mechanar: 120,000 XP/hr

### 2. **Balanced** (Default)
**Best for**: Players who want both leveling and reputation progress

- Follows the **natural dungeon progression** order
- Balances level requirements, rep gains, and experience
- Moves through factions systematically
- Ensures all heroic keys are unlocked progressively
- **This is the recommended mode for most players**

**Progression Order:**
1. Hellfire Ramparts → Blood Furnace (Honor Hold to Friendly)
2. Slave Pens → Underbog (Cenarion Expedition)
3. Mana-Tombs (The Consortium)
4. Auchenai Crypts → Sethekk Halls (Lower City)
5. Old Hillsbrad → Shadow Labyrinth (Mixed factions)
6. Steamvault (CE Exalted) → Shattered Halls (HH Honored)
7. Mechanar → Botanica → Arcatraz (Sha'tar Exalted)
8. Black Morass (Keepers of Time)

### 3. **Maximize Rep**
**Best for**: Players at 70 or targeting specific faction rewards

- Prioritizes dungeons with the **highest Rep/hour**
- Can target a **specific faction** or auto-select best rep gains
- Perfect for grinding to Exalted for mounts, recipes, or gear

**Best Rep/Hour Dungeons:**
- Botanica: 4,400 Rep/hr (The Sha'tar) - **BEST**
- Mechanar: 3,840 Rep/hr (The Sha'tar)
- Shattered Halls: 3,840 Rep/hr (Honor Hold)
- Steamvault: 3,640 Rep/hr (Cenarion Expedition)
- Arcatraz: 3,600 Rep/hr (The Sha'tar)
- Shadow Labyrinth: 3,500 Rep/hr (Lower City)

## 🎮 How to Use

### In-Game UI

1. Open the tracker: `/ds` or `/dungeonspam`
2. Look at the top section below the recommendation panel
3. Click one of three buttons: **Maximize XP**, **Balanced**, or **Maximize Rep**
4. If "Maximize Rep" is selected, use the **Target Faction** dropdown to choose:
   - **Auto** - Best rep/hour regardless of faction
   - **Honor Hold** - Hellfire Peninsula dungeons
   - **Cenarion Expedition** - Zangarmarsh dungeons
   - **The Sha'tar** - Tempest Keep dungeons (BEST rep/hr)
   - **Lower City** - Auchindoun dungeons
   - **Keepers of Time** - Caverns of Time dungeons
   - **The Consortium** - Mana-Tombs only

### Slash Commands

```
/ds mode xp          - Switch to Maximize XP mode
/ds mode balanced    - Switch to Balanced mode (default)
/ds mode rep         - Switch to Maximize Rep mode

/ds faction honor    - Target Honor Hold (switches to rep mode)
/ds faction cenarion - Target Cenarion Expedition
/ds faction shatar   - Target The Sha'tar
/ds faction lower    - Target Lower City
/ds faction keepers  - Target Keepers of Time
/ds faction consortium - Target The Consortium
```

## 📊 Use Case Examples

### Example 1: Fast Leveling (60-70)
**Goal**: Hit level 70 as quickly as possible

**Strategy**:
1. Use `/ds mode xp`
2. Run Hellfire Ramparts repeatedly (135k XP/hr, 20 min runs)
3. Switch to Blood Furnace at 61 (131k XP/hr)
4. Continue with highest XP/hr dungeons as they unlock

**Expected Result**: ~35-40 dungeon runs to reach 70

### Example 2: Karazuna Attunement Rush
**Goal**: Get Kara-attuned ASAP at level 70

**Strategy**:
1. Use `/ds mode balanced` while leveling
2. At 70, ensure you've done:
   - Mechanar (Arcatraz key shard)
   - Shadow Labyrinth (Key Fragment 1)
   - Arcatraz (Key Fragment 3)
   - Sethekk Halls (Ikiss kill)

**Expected Result**: Natural progression hits all attunement dungeons

### Example 3: Sha'tar Exalted Grind
**Goal**: Get Sha'tar to Exalted for head enchants

**Strategy**:
1. Use `/ds faction shatar`
2. Run Botanica exclusively (4,400 rep/hr, best in game)
3. If Botanica locked, run Mechanar (3,840 rep/hr)

**Expected Result**: ~12-15 hours of Botanica runs from Neutral to Exalted

### Example 4: All Heroic Keys
**Goal**: Unlock all heroic keys efficiently

**Strategy**:
1. Use `/ds mode balanced` (default)
2. Follow natural progression
3. All factions will reach Honored naturally
4. Keys unlock: Hellfire (HH), Coilfang (CE), Auchindoun (LC), CoT (KoT), TK (Sha'tar)

**Expected Result**: All heroic keys by level 70

## ⚙️ Technical Details

### How Recommendations Work

**XP Mode Algorithm:**
```lua
1. Get all available dungeons (level requirement met, not rep capped)
2. Sort by expPerHour descending
3. Return highest XP/hour dungeon
```

**Balanced Mode Algorithm:**
```lua
1. Get dungeons in preset progression order
2. Find first dungeon where:
   - Player meets level requirement
   - Reputation not yet capped
3. Return that dungeon
```

**Rep Mode Algorithm:**
```lua
1. Get all available dungeons
2. If target faction set: Filter to only that faction's dungeons
3. Sort by repPerHour descending
4. Return highest rep/hour dungeon
```

### Data Accuracy

All dungeon statistics are based on **TBC Classic data** from the CSV file:
- Rep values: Direct from Blizzard API
- XP values: Average from player data (~45k-50k per run)
- Duration: Average clear times from speedrun data
- Rep/hour & XP/hour: Calculated from averages

## 🔄 Mode Switching

You can **change modes at any time**:
- Settings persist between sessions
- Recommendations update immediately
- Run tracking continues regardless of mode
- No penalty for switching modes

## 💡 Tips

1. **Start with Balanced**: It's designed for natural progression and hits all required dungeons
2. **Switch to XP at 68-69**: Maximize those final levels with high XP/hr dungeons
3. **Use Rep Mode at 70**: Focus on specific factions for rewards
4. **Combine with Quest XP**: Dungeon spam is most efficient when combined with quest turn-ins
5. **Target Botanica for Fast Rep**: It's the single best rep/hour dungeon in TBC

## 📈 Expected Time Investment

### To Level 70 (from 60)
- **XP Mode**: ~20-25 hours of dungeons
- **Balanced Mode**: ~22-27 hours of dungeons
- **Rep Mode**: Not recommended (XP is a side effect)

### To All Heroic Keys
- **Balanced Mode**: Naturally achieved by 70
- **XP Mode**: May need 3-5 extra hours of rep grinding
- **Rep Mode**: 15-20 hours if targeting each faction

### To Single Faction Exalted (from Neutral)
- **Botanica (Sha'tar)**: ~12 hours
- **Steamvault (CE)**: ~13 hours
- **Shadow Lab (Lower City)**: ~13 hours
- **Shattered Halls (Honor Hold)**: ~11 hours

---

*Feature added in version 1.0.0*
*Last updated: February 2026*
