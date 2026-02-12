-- Dungeon Spam Tracker - Dungeon Data
local ADDON_NAME, DST = ...

DST.DungeonData = {}
local D = DST.DungeonData

-- All TBC dungeons with their stats
-- Data sourced from table.csv
D.Dungeons = {
    ["Hellfire Ramparts"] = {
        id = 543,
        order = 1,
        zone = "Hellfire Citadel",
        faction = "Honor Hold",
        factionID = 946,
        repPerRun = 633,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 36000,
        avgDuration = 20,
        minLevel = 60,
        maxLevel = 67,
        expPerHour = 108000,
        repPerHour = 1900,
        entrance = "Hellfire Peninsula",
        requiredFor = {
            "Heroic Keys (Revered)",
            "Plate/Mail/Cloth gear",
            "BS/JC/LW recipes",
        },
        guide = {
            "Fast dungeon, good for starting out",
            "Boss 1 (Watchkeeper): Tank and spank, interrupt Mortal Strike",
            "Boss 2 (Omor): Face boss away from group, kill adds",
            "Boss 3 (Nazan): Stay spread for fire breath, move from fire pools",
        },
    },
    ["Blood Furnace"] = {
        id = 542,
        order = 2,
        zone = "Hellfire Citadel",
        faction = "Honor Hold",
        factionID = 946,
        repPerRun = 750,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 39600,
        avgDuration = 22,
        minLevel = 61,
        maxLevel = 68,
        expPerHour = 108000,
        repPerHour = 2050,
        entrance = "Hellfire Peninsula",
        requiredFor = {
            "SSC Attunement (Heroic boss kill)",
            "Same as Ramparts",
        },
        guide = {
            "Slightly longer than Ramparts",
            "Boss 1 (The Maker): Interrupt Mind Control, cleave adds",
            "Boss 2 (Broggok): Waves of adds, then boss",
            "Boss 3 (Keli'dan): Run out during Burning Nova cast",
        },
    },
    ["Slave Pens"] = {
        id = 547,
        order = 3,
        zone = "Coilfang Reservoir",
        faction = "Cenarion Expedition",
        factionID = 942,
        repPerRun = 850,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 39600,
        avgDuration = 22,
        minLevel = 62,
        maxLevel = 69,
        expPerHour = 108000,
        repPerHour = 2320,
        entrance = "Zangarmarsh",
        requiredFor = {
            "Heroic key for Coilfang heroics",
            "Clefthoof patterns (LW)",
            "Nature resistance enchants",
        },
        guide = {
            "Underwater entrance in Zangarmarsh",
            "Boss 1 (Mennu): Kill totems quickly",
            "Boss 2 (Rokmar): Tank in corner, avoid cleave",
            "Boss 3 (Quagmirran): Poison cleanse helpful, stay spread",
        },
    },
    ["Underbog"] = {
        id = 546,
        order = 4,
        zone = "Coilfang Reservoir",
        faction = "Cenarion Expedition",
        factionID = 942,
        repPerRun = 900,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 41400,
        avgDuration = 25,
        minLevel = 63,
        maxLevel = 69,
        expPerHour = 99400,
        repPerHour = 2160,
        entrance = "Zangarmarsh",
        requiredFor = {
            "Cenarion Expedition rep grind",
            "Nature resistance gear",
        },
        guide = {
            "More nature damage than Slave Pens",
            "Boss 1 (Hungarfen): Spread for Spore Cloud",
            "Boss 2 (Ghaz'an): Tank swap on Acid Spit stacks",
            "Boss 3 (Swamplord): Interrupt heals if possible",
            "Boss 4 (Black Stalker): Levitate adds, avoid Chain Lightning",
        },
    },
    ["Mana-Tombs"] = {
        id = 557,
        order = 5,
        zone = "Auchindoun",
        faction = "The Consortium",
        factionID = 933,
        repPerRun = 850,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 43200,
        avgDuration = 22,
        minLevel = 64,
        maxLevel = 70,
        expPerHour = 117800,
        repPerHour = 2320,
        entrance = "Terokkar Forest",
        requiredFor = {
            "Ethereum keys (Netherstorm)",
            "JC designs",
            "Ring enchants",
        },
        guide = {
            "Ethereal dungeon in Auchindoun",
            "Boss 1 (Pandemonius): Run away during Void Blast",
            "Boss 2 (Tavarok): Stay at range if possible",
            "Boss 3 (Nexus-Prince): Kill adds, interrupt Arcane Explosion",
        },
    },
    ["Auchenai Crypts"] = {
        id = 558,
        order = 6,
        zone = "Auchindoun",
        faction = "Lower City",
        factionID = 1011,
        repPerRun = 700,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 43200,
        avgDuration = 25,
        minLevel = 65,
        maxLevel = 70,
        expPerHour = 103700,
        repPerHour = 1680,
        entrance = "Terokkar Forest",
        requiredFor = {
            "Heroic key for Auchindoun",
            "Flask recipes (Alchemist)",
            "Cloak/Tailor patterns",
        },
        guide = {
            "Undead dungeon with fear mechanics",
            "Boss 1 (Shirrak): Run from Inhibit Magic, dispel Attract",
            "Boss 2 (Exarch): Kill adds, interrupt heals",
        },
    },
    ["Sethekk Halls"] = {
        id = 556,
        order = 7,
        zone = "Auchindoun",
        faction = "Lower City",
        factionID = 1011,
        repPerRun = 1035,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 45000,
        avgDuration = 25,
        minLevel = 67,
        maxLevel = 70,
        expPerHour = 108000,
        repPerHour = 2490,
        entrance = "Terokkar Forest",
        requiredFor = {
            "Kara attunement chain (Ikiss kill)",
            "Lower City rep",
        },
        guide = {
            "Arakkoa dungeon",
            "Boss 1 (Darkweaver Syth): Kill elemental adds quickly",
            "Boss 2 (Talon King Ikiss): LOS the Arcane Explosion behind pillars",
        },
    },
    ["Old Hillsbrad"] = {
        id = 560,
        order = 8,
        zone = "Caverns of Time",
        faction = "Keepers of Time",
        factionID = 989,
        repPerRun = 975,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 46800,
        avgDuration = 28,
        minLevel = 66,
        maxLevel = 70,
        expPerHour = 100300,
        repPerHour = 2090,
        entrance = "Tanaris",
        requiredFor = {
            "Unlocks Black Morass questline",
            "Ring enchants",
            "LW drums",
            "JC facets",
        },
        guide = {
            "Escort Thrall through Durnholde Keep",
            "Get disguise from NPC outside",
            "Boss 1 (Drake): Tank and spank",
            "Boss 2 (Skarloc): Mounted boss, dismount him",
            "Boss 3 (Epoch Hunter): Final boss, interrupt abilities",
        },
    },
    ["Shadow Labyrinth"] = {
        id = 555,
        order = 9,
        zone = "Auchindoun",
        faction = "Lower City",
        factionID = 1011,
        repPerRun = 1750,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 48600,
        avgDuration = 30,
        minLevel = 68,
        maxLevel = 70,
        expPerHour = 97200,
        repPerHour = 3500,
        entrance = "Terokkar Forest",
        requiredFor = {
            "Kara attunement (Key Fragment 1)",
            "Best for Lower City Exalted",
        },
        guide = {
            "Hardest Auchindoun dungeon",
            "Boss 1 (Hellmaw): Stay behind, cleanse Corrosive Acid",
            "Boss 2 (Blackheart): Phase boss, kill adds",
            "Boss 3 (Grandmaster Vorpil): Kill void portals",
            "Boss 4 (Murmur): Stay spread, run from Sonic Boom",
        },
    },
    ["Steamvault"] = {
        id = 545,
        order = 10,
        zone = "Coilfang Reservoir",
        faction = "Cenarion Expedition",
        factionID = 942,
        repPerRun = 1700,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 48600,
        avgDuration = 28,
        minLevel = 68,
        maxLevel = 70,
        expPerHour = 104100,
        repPerHour = 3640,
        entrance = "Zangarmarsh",
        requiredFor = {
            "Best for Cenarion Expedition Exalted",
            "Nature resistance gear",
        },
        guide = {
            "Best CE rep dungeon",
            "Boss 1 (Hydromancer): Interrupt Frostbolt, kill water elementals",
            "Boss 2 (Steamrigger): Kill gnomes for buffs, tank in corner",
            "Boss 3 (Warlord): Interrupt heals, cleanse disease",
        },
    },
    ["Shattered Halls"] = {
        id = 540,
        order = 11,
        zone = "Hellfire Citadel",
        faction = "Honor Hold",
        factionID = 946,
        repPerRun = 1600,
        repCap = "Honored",
        repCapValue = 9000,
        expPerRun = 50400,
        avgDuration = 25,
        minLevel = 69,
        maxLevel = 70,
        expPerHour = 121000,
        repPerHour = 3840,
        entrance = "Hellfire Peninsula",
        requiredFor = {
            "SSC attunement chain",
            "Best Hellfire faction rep at higher levels",
        },
        guide = {
            "Hardest Hellfire Citadel dungeon",
            "Requires Shattered Halls Key",
            "Boss 1 (Nethekurse): Kill adds, stay spread for shadow bolt volley",
            "Boss 2 (O'mrogg): Tank swap, stay behind",
            "Boss 3 (Kargath): Bladefist charge - stay spread",
        },
    },
    ["Mechanar"] = {
        id = 554,
        order = 12,
        zone = "Tempest Keep",
        faction = "The Sha'tar",
        factionID = 935,
        repPerRun = 1600,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 50400,
        avgDuration = 25,
        minLevel = 69,
        maxLevel = 70,
        expPerHour = 121000,
        repPerHour = 3840,
        entrance = "Netherstorm",
        requiredFor = {
            "Arcatraz key shard",
            "Kara attunement chain",
            "Head glyphs (tank/caster)",
            "PvP gear",
        },
        guide = {
            "First Tempest Keep dungeon",
            "Boss 1 (Mechano-Lord): Interrupt Saw Blade",
            "Boss 2 (Nethermancer): Kill adds, interrupt",
            "Boss 3 (Pathaleon): Dispel mind control, kill adds",
        },
    },
    ["Botanica"] = {
        id = 553,
        order = 13,
        zone = "Tempest Keep",
        faction = "The Sha'tar",
        factionID = 935,
        repPerRun = 2200,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 50400,
        avgDuration = 30,
        minLevel = 70,
        maxLevel = 70,
        expPerHour = 100800,
        repPerHour = 4400,
        entrance = "Netherstorm",
        requiredFor = {
            "Tempest Keep raid attunement",
            "Best Sha'tar rep dungeon",
        },
        guide = {
            "Best Sha'tar rep per hour",
            "Boss 1 (Sarannis): Heal through damage",
            "Boss 2 (Freywinn): Kill tree adds",
            "Boss 3 (Thorngrin): Stay spread for Sacrifice",
            "Boss 4 (Laj): Kill color matching adds",
            "Boss 5 (Warp Splinter): Kill saplings, cleanse",
        },
    },
    ["Arcatraz"] = {
        id = 552,
        order = 14,
        zone = "Tempest Keep",
        faction = "The Sha'tar",
        factionID = 935,
        repPerRun = 1800,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 50400,
        avgDuration = 30,
        minLevel = 70,
        maxLevel = 70,
        expPerHour = 100800,
        repPerHour = 3600,
        entrance = "Netherstorm",
        requiredFor = {
            "Kara attunement (Key Fragment 3)",
            "Requires Arcatraz Key",
        },
        guide = {
            "Hardest Tempest Keep dungeon",
            "Boss 1 (Zereketh): Stay spread, avoid Void Zone",
            "Boss 2 (Dalliah): Interrupt Whirlwind, heal through Gift",
            "Boss 3 (Soccothrates): Kite charges",
            "Boss 4 (Harbinger): Kill adds, interrupt Cosmic Infusion",
        },
    },
    ["Black Morass"] = {
        id = 269,
        order = 15,
        zone = "Caverns of Time",
        faction = "Keepers of Time",
        factionID = 989,
        repPerRun = 1055,
        repCap = "Exalted",
        repCapValue = 42000,
        expPerRun = 48600,
        avgDuration = 28,
        minLevel = 70,
        maxLevel = 70,
        expPerHour = 104100,
        repPerHour = 2260,
        entrance = "Tanaris",
        requiredFor = {
            "Kara/Sunwell attunements",
            "Final Keepers of Time rep",
        },
        guide = {
            "Requires completion of Old Hillsbrad",
            "Wave-based encounter defending Medivh",
            "Use chrono-beacons to slow portals",
            "Boss waves at portals 6, 12, and 18",
            "Kill rift lords quickly to close portals",
        },
    },
}

-- Update Hellfire Citadel dungeons to use the correct faction for the player's side
function D:InitPlayerFaction()
    local C = DST.Constants
    local hellfireFaction = C.hellfireFaction
    local hellfireFactionID = C.hellfireFactionID

    if hellfireFaction and hellfireFactionID then
        local hellfireDungeons = {"Hellfire Ramparts", "Blood Furnace", "Shattered Halls"}
        for _, name in ipairs(hellfireDungeons) do
            if self.Dungeons[name] then
                self.Dungeons[name].faction = hellfireFaction
                self.Dungeons[name].factionID = hellfireFactionID
            end
        end
    end
end

-- Get dungeon by name
function D:GetDungeon(name)
    return self.Dungeons[name]
end

-- Get dungeon by instance ID
function D:GetDungeonByID(instanceID)
    for name, data in pairs(self.Dungeons) do
        if data.id == instanceID then
            return data, name
        end
    end
    return nil
end

-- Get all dungeons for a faction
function D:GetDungeonsByFaction(faction)
    local dungeons = {}
    for name, data in pairs(self.Dungeons) do
        if data.faction == faction then
            table.insert(dungeons, {name = name, data = data})
        end
    end
    table.sort(dungeons, function(a, b) return a.data.order < b.data.order end)
    return dungeons
end

-- Get dungeons available at a given level
function D:GetDungeonsForLevel(level)
    local dungeons = {}
    for name, data in pairs(self.Dungeons) do
        if level >= data.minLevel then
            table.insert(dungeons, {name = name, data = data})
        end
    end
    table.sort(dungeons, function(a, b) return a.data.order < b.data.order end)
    return dungeons
end

-- Get ordered list of all dungeons
function D:GetOrderedDungeons()
    local ordered = {}
    for name, data in pairs(self.Dungeons) do
        table.insert(ordered, {name = name, data = data})
    end
    table.sort(ordered, function(a, b) return a.data.order < b.data.order end)
    return ordered
end

-- Calculate runs needed to cap rep
function D:GetRunsToRepCap(dungeonName, currentRep)
    local dungeon = self.Dungeons[dungeonName]
    if not dungeon then return 0 end

    local repNeeded = dungeon.repCapValue - currentRep
    if repNeeded <= 0 then return 0 end

    return math.ceil(repNeeded / dungeon.repPerRun)
end
