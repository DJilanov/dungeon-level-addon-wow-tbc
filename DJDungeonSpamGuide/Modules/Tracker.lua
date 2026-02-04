-- Dungeon Spam Tracker - Tracker Module
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants
local D = DST.DungeonData
local R = DST.RepThresholds

-- Create Tracker module
local Tracker = {}
Addon.Tracker = Tracker

-- Current player data cache
Tracker.playerLevel = 60
Tracker.playerXP = 0
Tracker.playerXPMax = 0
Tracker.factionData = {}

-- Initialize tracker
function Tracker:Init()
    self:RefreshData()
end

-- Refresh all data
function Tracker:RefreshData()
    self:RefreshLevel()
    self:RefreshXP()
    self:RefreshReputation()
end

-- Refresh player level
function Tracker:RefreshLevel()
    self.playerLevel = UnitLevel("player")
end

-- Refresh XP data
function Tracker:RefreshXP()
    self.playerXP = UnitXP("player")
    self.playerXPMax = UnitXPMax("player")
end

-- Refresh reputation data for all TBC factions
function Tracker:RefreshReputation()
    self.factionData = {}

    for factionName, factionID in pairs(C.FACTION_IDS) do
        local name, description, standingID, barMin, barMax, barValue = GetFactionInfoByID(factionID)

        if name then
            -- barValue is reputation earned within current standing
            -- We need absolute reputation from neutral
            local absoluteRep = R:GetAbsoluteRep(standingID, barValue)

            self.factionData[factionName] = {
                name = name,
                standingID = standingID,
                standingName = R:GetStandingName(standingID),
                currentRep = barValue,
                absoluteRep = absoluteRep,
                barMin = barMin,
                barMax = barMax,
            }
        end
    end
end

-- Get faction data
function Tracker:GetFactionData(factionName)
    return self.factionData[factionName]
end

-- Get current absolute reputation for a faction
function Tracker:GetFactionRep(factionName)
    local data = self.factionData[factionName]
    if data then
        return data.absoluteRep
    end
    return 0
end

-- Get faction standing name
function Tracker:GetFactionStanding(factionName)
    local data = self.factionData[factionName]
    if data then
        return data.standingName
    end
    return "Unknown"
end

-- Check if faction has reached rep cap for a dungeon
function Tracker:IsDungeonRepCapped(dungeonName)
    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then return false end

    local factionRep = self:GetFactionRep(dungeon.faction)
    return factionRep >= dungeon.repCapValue
end

-- Get runs to rep cap for a dungeon
function Tracker:GetRunsToRepCap(dungeonName)
    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then return 0 end

    local currentRep = self:GetFactionRep(dungeon.faction)
    local repNeeded = dungeon.repCapValue - currentRep

    if repNeeded <= 0 then return 0 end

    return math.ceil(repNeeded / dungeon.repPerRun)
end

-- Get runs to next level
function Tracker:GetRunsToLevel(dungeonName)
    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then return 0 end

    local xpNeeded = self.playerXPMax - self.playerXP
    if xpNeeded <= 0 then return 0 end

    return math.ceil(xpNeeded / dungeon.expPerRun)
end

-- Get dungeon run count
function Tracker:GetDungeonRuns(dungeonName)
    if not Addon.charDB then return 0 end
    return Addon.charDB.dungeonRuns[dungeonName] or 0
end

-- Increment dungeon run count
function Tracker:IncrementRun(dungeonName)
    if not Addon.charDB then return end

    if not Addon.charDB.dungeonRuns[dungeonName] then
        Addon.charDB.dungeonRuns[dungeonName] = 0
    end

    Addon.charDB.dungeonRuns[dungeonName] = Addon.charDB.dungeonRuns[dungeonName] + 1
    Addon.charDB.totalRunsAllTime = (Addon.charDB.totalRunsAllTime or 0) + 1

    Addon:Debug("Incremented run for " .. dungeonName .. " to " .. Addon.charDB.dungeonRuns[dungeonName])
end

-- Set dungeon run count manually
function Tracker:SetDungeonRuns(dungeonName, count)
    if not Addon.charDB then return end
    Addon.charDB.dungeonRuns[dungeonName] = count
end

-- Get total runs across all dungeons
function Tracker:GetTotalRuns()
    if not Addon.charDB then return 0 end

    local total = 0
    for _, count in pairs(Addon.charDB.dungeonRuns or {}) do
        total = total + count
    end
    return total
end

-- Mark a dungeon phase as complete (rep capped)
function Tracker:MarkDungeonComplete(dungeonName)
    if not Addon.charDB then return end
    Addon.charDB.completedPhases[dungeonName] = true
end

-- Check if dungeon phase is complete
function Tracker:IsDungeonComplete(dungeonName)
    if not Addon.charDB then return false end
    return Addon.charDB.completedPhases[dungeonName] or self:IsDungeonRepCapped(dungeonName)
end

-- Get dungeon status for UI display
function Tracker:GetDungeonStatus(dungeonName)
    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then
        return "UNKNOWN", nil
    end

    -- Check level requirement
    if self.playerLevel < dungeon.minLevel then
        return "LOCKED", string.format(L["TIP_MIN_LEVEL"], dungeon.minLevel)
    end

    -- Check if rep is capped
    if self:IsDungeonRepCapped(dungeonName) then
        return "COMPLETE", L["COMPLETE"]
    end

    -- Available
    return "AVAILABLE", nil
end

-- Get estimated time to cap a dungeon's rep (in minutes)
function Tracker:GetTimeToRepCap(dungeonName)
    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then return 0 end

    local runs = self:GetRunsToRepCap(dungeonName)
    return runs * dungeon.avgDuration
end

-- Get all faction progress data for UI
function Tracker:GetAllFactionProgress()
    local progress = {}

    for factionName, factionID in pairs(C.FACTION_IDS) do
        local data = self.factionData[factionName]
        if data then
            progress[factionName] = {
                name = factionName,
                standing = data.standingName,
                standingID = data.standingID,
                current = data.absoluteRep,
                currentInStanding = data.currentRep,
                max = R:GetStandingMax(data.standingID),
            }
        end
    end

    return progress
end

-- Calculate total remaining XP to level 70
function Tracker:GetTotalXPTo70()
    if self.playerLevel >= 70 then return 0 end

    local remaining = self.playerXPMax - self.playerXP

    for level = self.playerLevel + 1, 69 do
        remaining = remaining + (DST.ExpPerLevel.XP_TO_LEVEL[level] or 0)
    end

    return remaining
end
