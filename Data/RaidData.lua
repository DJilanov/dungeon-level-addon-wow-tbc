-- Dungeon Spam Tracker - Raid Data
local ADDON_NAME, DST = ...

DST.RaidData = {}
local R = DST.RaidData

-- All TBC raids with their information
R.Raids = {
    ["Karazhan"] = {
        id = 532,
        order = 1,
        size = 10,
        minLevel = 70,
        attunement = "Required: Key to Karazhan (quest chain)",
        location = "Deadwind Pass",
        bosses = {
            "Attumen the Huntsman",
            "Moroes",
            "Maiden of Virtue",
            "Opera Event",
            "Curator",
            "Shade of Aran",
            "Terestian Illhoof",
            "Netherspite",
            "Chess Event",
            "Prince Malchezaar",
        },
        guide = {
            "Entry-level 10-man raid",
            "Requires Key to Karazhan attunement",
            "Full clear takes 3-4 hours",
            "Drops Tier 4 tokens and pre-BiS gear",
            "Can be reset weekly",
        },
    },
    ["Gruul's Lair"] = {
        id = 565,
        order = 2,
        size = 25,
        minLevel = 70,
        attunement = "None",
        location = "Blade's Edge Mountains",
        bosses = {
            "High King Maulgar",
            "Gruul the Dragonkiller",
        },
        guide = {
            "Short 25-man raid, 2 bosses",
            "No attunement required",
            "Drops Tier 4 tokens",
            "Maulgar: Kill adds in specific order",
            "Gruul: Move out during Ground Slam, avoid Shatter",
        },
    },
    ["Magtheridon's Lair"] = {
        id = 544,
        order = 3,
        size = 25,
        minLevel = 70,
        attunement = "None",
        location = "Hellfire Citadel",
        bosses = {
            "Magtheridon",
        },
        guide = {
            "Single-boss 25-man raid",
            "No attunement required",
            "Drops Tier 4 tokens",
            "Click cubes to interrupt Infernal spawns",
            "Tank swap on Cleave stacks",
        },
    },
    ["Serpentshrine Cavern"] = {
        id = 548,
        order = 4,
        size = 25,
        minLevel = 70,
        attunement = "Required: Vial of Blessed Water",
        location = "Coilfang Reservoir, Zangarmarsh",
        bosses = {
            "Hydross the Unstable",
            "The Lurker Below",
            "Leotheras the Blind",
            "Fathom-Lord Karathress",
            "Morogrim Tidewalker",
            "Lady Vashj",
        },
        guide = {
            "Tier 5 content, 25-man",
            "Requires SSC attunement chain",
            "Drops Tier 5 tokens",
            "Vashj is final boss, complex mechanics",
        },
    },
    ["Tempest Keep"] = {
        id = 550,
        order = 5,
        size = 25,
        minLevel = 70,
        attunement = "Required: The Eye attunement",
        location = "Netherstorm",
        bosses = {
            "Al'ar",
            "Void Reaver",
            "High Astromancer Solarian",
            "Kael'thas Sunstrider",
        },
        guide = {
            "Tier 5 content, 25-man",
            "Requires TK attunement chain",
            "Drops Tier 5 tokens",
            "Kael'thas: Legendary weapons drop",
        },
    },
    ["Battle for Mount Hyjal"] = {
        id = 534,
        order = 6,
        size = 25,
        minLevel = 70,
        attunement = "Required: Vials of Eternity",
        location = "Caverns of Time, Tanaris",
        bosses = {
            "Rage Winterchill",
            "Anetheron",
            "Kaz'rogal",
            "Azgalor",
            "Archimonde",
        },
        guide = {
            "Tier 6 content, 25-man",
            "Requires SSC/TK completion",
            "Wave-based encounters",
            "Drops Tier 6 tokens",
        },
    },
    ["Black Temple"] = {
        id = 564,
        order = 7,
        size = 25,
        minLevel = 70,
        attunement = "Required: Medallion of Karabor",
        location = "Shadowmoon Valley",
        bosses = {
            "High Warlord Naj'entus",
            "Supremus",
            "Shade of Akama",
            "Teron Gorefiend",
            "Gurtogg Bloodboil",
            "Reliquary of Souls",
            "Mother Shahraz",
            "Illidari Council",
            "Illidan Stormrage",
        },
        guide = {
            "Tier 6 content, 25-man",
            "Long attunement chain",
            "Drops Tier 6 tokens",
            "Illidan drops Warglaives of Azzinoth",
        },
    },
    ["Zul'Aman"] = {
        id = 568,
        order = 8,
        size = 10,
        minLevel = 70,
        attunement = "None",
        location = "Ghostlands",
        bosses = {
            "Nalorakk (Bear)",
            "Akil'zon (Eagle)",
            "Jan'alai (Dragonhawk)",
            "Halazzi (Lynx)",
            "Hex Lord Malacrass",
            "Zul'jin",
        },
        guide = {
            "Timed 10-man raid",
            "No attunement required",
            "Timed run rewards: Bear mount",
            "Drops powerful catch-up gear",
        },
    },
    ["Sunwell Plateau"] = {
        id = 580,
        order = 9,
        size = 25,
        minLevel = 70,
        attunement = "None (in later phases)",
        location = "Isle of Quel'Danas",
        bosses = {
            "Kalecgos",
            "Brutallus",
            "Felmyst",
            "Eredar Twins",
            "M'uru",
            "Kil'jaeden",
        },
        guide = {
            "Final TBC raid, 25-man",
            "Most difficult content",
            "Legendary bow drops from final boss",
            "Requires high gear level",
        },
    },
}

-- Get raid by name
function R:GetRaid(name)
    return self.Raids[name]
end

-- Get ordered list of all raids
function R:GetOrderedRaids()
    local ordered = {}
    for name, data in pairs(self.Raids) do
        table.insert(ordered, {name = name, data = data})
    end
    table.sort(ordered, function(a, b) return a.data.order < b.data.order end)
    return ordered
end

-- Get raids available at level
function R:GetRaidsForLevel(level)
    local raids = {}
    for name, data in pairs(self.Raids) do
        if level >= data.minLevel then
            table.insert(raids, {name = name, data = data})
        end
    end
    table.sort(raids, function(a, b) return a.data.order < b.data.order end)
    return raids
end
