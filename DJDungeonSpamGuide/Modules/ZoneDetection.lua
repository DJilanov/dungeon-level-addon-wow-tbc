-- Dungeon Spam Tracker - Zone Detection Module
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants

-- Create ZoneDetection module
local ZoneDetection = {}
Addon.ZoneDetection = ZoneDetection

-- Track state
ZoneDetection.lastZone = nil
ZoneDetection.hasEnteredOutland = false
ZoneDetection.currentContinent = nil

-- Zone names for detection
local OUTLAND_ZONES = {
    ["Hellfire Peninsula"] = true,
    ["Zangarmarsh"] = true,
    ["Terokkar Forest"] = true,
    ["Nagrand"] = true,
    ["Blade's Edge Mountains"] = true,
    ["Netherstorm"] = true,
    ["Shadowmoon Valley"] = true,
    ["Shattrath City"] = true,
}

local AZEROTH_PORTAL_ZONES = {
    ["Blasted Lands"] = true,
    ["Stormwind City"] = true,
    ["Ironforge"] = true,
}

-- Initialize zone detection
function ZoneDetection:Init()
    self.lastZone = GetRealZoneText()
    self.hasEnteredOutland = self:IsInOutland()
end

-- Check if currently in Outland
function ZoneDetection:IsInOutland()
    local zone = GetRealZoneText()
    return OUTLAND_ZONES[zone] or false
end

-- Check zone and trigger appropriate events
function ZoneDetection:CheckZone(newZone)
    local wasInOutland = self.hasEnteredOutland
    local isNowInOutland = OUTLAND_ZONES[newZone] or false

    -- Detect crossing through Dark Portal
    if not wasInOutland and isNowInOutland then
        -- Just entered Outland!
        self:OnEnterOutland(newZone)
    end

    -- Update state
    self.lastZone = newZone
    self.hasEnteredOutland = isNowInOutland
end

-- Called when player first enters Outland
function ZoneDetection:OnEnterOutland(zone)
    if not Addon:GetSetting("showOnDarkPortal") then return end

    -- Get recommendation
    local recommendation = nil
    if Addon.Recommender then
        recommendation = Addon.Recommender:GetRecommendation()
    end

    if recommendation then
        Addon:Print(string.format(L["DARK_PORTAL_WELCOME"], recommendation.name))

        -- Optionally show the main UI
        C_Timer.After(2, function()
            Addon:Show()
        end)
    end
end

-- Get the current zone category
function ZoneDetection:GetZoneCategory()
    local zone = GetRealZoneText()

    if OUTLAND_ZONES[zone] then
        return "OUTLAND", zone
    elseif AZEROTH_PORTAL_ZONES[zone] then
        return "PORTAL_AREA", zone
    else
        return "AZEROTH", zone
    end
end

-- Check if player is in a specific dungeon zone area
function ZoneDetection:IsNearDungeon(dungeonName)
    local zone = GetRealZoneText()
    local dungeon = DST.DungeonData:GetDungeon(dungeonName)

    if not dungeon then return false end

    -- Map dungeon zones to their entrance zones
    local entranceZones = {
        ["Hellfire Citadel"] = "Hellfire Peninsula",
        ["Coilfang Reservoir"] = "Zangarmarsh",
        ["Auchindoun"] = "Terokkar Forest",
        ["Caverns of Time"] = "Tanaris",
        ["Tempest Keep"] = "Netherstorm",
    }

    local entranceZone = entranceZones[dungeon.zone]
    return zone == entranceZone
end

-- Get nearby dungeons based on current zone
function ZoneDetection:GetNearbyDungeons()
    local zone = GetRealZoneText()
    local nearby = {}

    -- Map zones to dungeon groups
    local zoneToDungeons = {
        ["Hellfire Peninsula"] = {"Hellfire Ramparts", "Blood Furnace", "Shattered Halls"},
        ["Zangarmarsh"] = {"Slave Pens", "Underbog", "Steamvault"},
        ["Terokkar Forest"] = {"Mana-Tombs", "Auchenai Crypts", "Sethekk Halls", "Shadow Labyrinth"},
        ["Tanaris"] = {"Old Hillsbrad", "Black Morass"},
        ["Netherstorm"] = {"Mechanar", "Botanica", "Arcatraz"},
    }

    local dungeonList = zoneToDungeons[zone]
    if dungeonList then
        for _, dungeonName in ipairs(dungeonList) do
            local dungeon = DST.DungeonData:GetDungeon(dungeonName)
            if dungeon then
                table.insert(nearby, {name = dungeonName, data = dungeon})
            end
        end
    end

    return nearby
end

-- Check if player is inside an instance
function ZoneDetection:IsInInstance()
    local inInstance, instanceType = IsInInstance()
    return inInstance and instanceType == "party"
end

-- Get current instance info if in one
function ZoneDetection:GetCurrentInstance()
    if not self:IsInInstance() then return nil end

    local instanceName, instanceType, difficultyID, difficultyName,
          maxPlayers, dynamicDifficulty, isDynamic, instanceID = GetInstanceInfo()

    return {
        name = instanceName,
        type = instanceType,
        id = instanceID,
        difficulty = difficultyName,
        maxPlayers = maxPlayers,
    }
end

-- Get dungeon data for current instance
function ZoneDetection:GetCurrentDungeonData()
    local instance = self:GetCurrentInstance()
    if not instance then return nil end

    local dungeonData, dungeonName = DST.DungeonData:GetDungeonByID(instance.id)
    if dungeonData then
        return dungeonName, dungeonData
    end

    return nil
end
