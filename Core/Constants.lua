-- Dungeon Spam Tracker - Constants
local ADDON_NAME, DST = ...

DST.Constants = {}
local C = DST.Constants

-- Faction IDs (Alliance)
C.FACTION_IDS = {
    ["Honor Hold"] = 946,
    ["Cenarion Expedition"] = 942,
    ["The Sha'tar"] = 935,
    ["Lower City"] = 1011,
    ["Keepers of Time"] = 989,
    ["The Consortium"] = 933,
}

-- Reputation standing thresholds
C.REP_STANDINGS = {
    HATED = -42000,
    HOSTILE = -6000,
    UNFRIENDLY = -3000,
    NEUTRAL = 0,
    FRIENDLY = 3000,
    HONORED = 9000,
    REVERED = 21000,
    EXALTED = 42000,
}

-- Standing names
C.STANDING_NAMES = {
    [1] = "Hated",
    [2] = "Hostile",
    [3] = "Unfriendly",
    [4] = "Neutral",
    [5] = "Friendly",
    [6] = "Honored",
    [7] = "Revered",
    [8] = "Exalted",
}

-- Standing colors
C.STANDING_COLORS = {
    [1] = {0.5, 0.0, 0.0},    -- Hated - Dark Red
    [2] = {1.0, 0.0, 0.0},    -- Hostile - Red
    [3] = {1.0, 0.5, 0.0},    -- Unfriendly - Orange
    [4] = {1.0, 1.0, 0.0},    -- Neutral - Yellow
    [5] = {0.0, 1.0, 0.0},    -- Friendly - Green
    [6] = {0.0, 1.0, 0.5},    -- Honored - Teal
    [7] = {0.0, 0.5, 1.0},    -- Revered - Blue
    [8] = {0.6, 0.2, 0.8},    -- Exalted - Purple
}

-- Instance IDs for dungeons
C.INSTANCE_IDS = {
    [543] = "Hellfire Ramparts",
    [542] = "Blood Furnace",
    [540] = "Shattered Halls",
    [547] = "Slave Pens",
    [546] = "Underbog",
    [545] = "Steamvault",
    [557] = "Mana-Tombs",
    [558] = "Auchenai Crypts",
    [556] = "Sethekk Halls",
    [555] = "Shadow Labyrinth",
    [560] = "Old Hillsbrad",
    [269] = "Black Morass",
    [554] = "Mechanar",
    [553] = "Botanica",
    [552] = "Arcatraz",
}

-- Zone IDs
C.ZONE_IDS = {
    HELLFIRE_PENINSULA = 3483,
    DARK_PORTAL = 3457,
    BLASTED_LANDS = 4,
}

-- Dungeon order for progression
C.DUNGEON_ORDER = {
    "Hellfire Ramparts",
    "Blood Furnace",
    "Slave Pens",
    "Underbog",
    "Mana-Tombs",
    "Auchenai Crypts",
    "Sethekk Halls",
    "Old Hillsbrad",
    "Shadow Labyrinth",
    "Steamvault",
    "Shattered Halls",
    "Mechanar",
    "Botanica",
    "Arcatraz",
    "Black Morass",
}

-- UI Colors
C.COLORS = {
    TITLE = {1, 0.82, 0},           -- Gold
    COMPLETE = {0.0, 1.0, 0.0},     -- Green
    AVAILABLE = {1.0, 1.0, 1.0},    -- White
    LOCKED = {0.5, 0.5, 0.5},       -- Gray
    RECOMMENDED = {0.0, 1.0, 0.5},  -- Bright Green
    HIGHLIGHT = {1.0, 0.82, 0.0},   -- Gold
    WARNING = {1.0, 0.5, 0.0},      -- Orange
    ERROR = {1.0, 0.0, 0.0},        -- Red
}

-- Dungeon categories by zone
C.DUNGEON_ZONES = {
    ["Hellfire Citadel"] = {"Hellfire Ramparts", "Blood Furnace", "Shattered Halls"},
    ["Coilfang Reservoir"] = {"Slave Pens", "Underbog", "Steamvault"},
    ["Auchindoun"] = {"Mana-Tombs", "Auchenai Crypts", "Sethekk Halls", "Shadow Labyrinth"},
    ["Caverns of Time"] = {"Old Hillsbrad", "Black Morass"},
    ["Tempest Keep"] = {"Mechanar", "Botanica", "Arcatraz"},
}

-- Heroic key requirements
C.HEROIC_KEYS = {
    ["Hellfire Citadel"] = {faction = "Honor Hold", standing = "Honored"},
    ["Coilfang Reservoir"] = {faction = "Cenarion Expedition", standing = "Honored"},
    ["Auchindoun"] = {faction = "Lower City", standing = "Honored"},
    ["Caverns of Time"] = {faction = "Keepers of Time", standing = "Honored"},
    ["Tempest Keep"] = {faction = "The Sha'tar", standing = "Honored"},
}
