-- Dungeon Spam Tracker - Initialization
local ADDON_NAME, DST = ...

-- Create main addon table
DJDungeonSpamGuide = {}
local Addon = DJDungeonSpamGuide

-- Store reference in namespace
DST.Addon = Addon

-- Addon info
Addon.name = ADDON_NAME
Addon.version = GetAddOnMetadata(ADDON_NAME, "Version") or "1.0.0"

-- Default saved variables
local defaults = {
    profile = {
        showOnDarkPortal = true,
        showOnDungeonEnter = true,
        showMinimapButton = true,
        frameScale = 1.0,
        framePosition = {
            point = "CENTER",
            relativePoint = "CENTER",
            xOfs = 0,
            yOfs = 0,
        },
        showCompletedDungeons = true,
        autoTrackRuns = true,
        -- Optimization mode: "xp", "balanced", "rep"
        optimizationMode = "balanced",
        -- Target faction for rep mode
        targetFaction = nil,
    },
    char = {
        dungeonRuns = {},
        completedPhases = {},
        lastRecommendation = nil,
        totalRunsAllTime = 0,
        firstLogin = true,
    },
}

-- Initialize saved variables
function Addon:InitializeDB()
    if not DJDungeonSpamGuideDB then
        DJDungeonSpamGuideDB = {}
    end

    -- Initialize profile settings
    if not DJDungeonSpamGuideDB.profile then
        DJDungeonSpamGuideDB.profile = {}
    end
    for key, value in pairs(defaults.profile) do
        if DJDungeonSpamGuideDB.profile[key] == nil then
            if type(value) == "table" then
                DJDungeonSpamGuideDB.profile[key] = CopyTable(value)
            else
                DJDungeonSpamGuideDB.profile[key] = value
            end
        end
    end

    -- Initialize character-specific settings
    local charKey = UnitName("player") .. "-" .. GetRealmName()
    if not DJDungeonSpamGuideDB.char then
        DJDungeonSpamGuideDB.char = {}
    end
    if not DJDungeonSpamGuideDB.char[charKey] then
        DJDungeonSpamGuideDB.char[charKey] = {}
    end

    for key, value in pairs(defaults.char) do
        if DJDungeonSpamGuideDB.char[charKey][key] == nil then
            if type(value) == "table" then
                DJDungeonSpamGuideDB.char[charKey][key] = CopyTable(value)
            else
                DJDungeonSpamGuideDB.char[charKey][key] = value
            end
        end
    end

    -- Store references
    self.db = DJDungeonSpamGuideDB
    self.profile = DJDungeonSpamGuideDB.profile
    self.charDB = DJDungeonSpamGuideDB.char[charKey]
end

-- Get profile setting
function Addon:GetSetting(key)
    return self.profile and self.profile[key]
end

-- Set profile setting
function Addon:SetSetting(key, value)
    if self.profile then
        self.profile[key] = value
    end
end

-- Get character-specific data
function Addon:GetCharData(key)
    return self.charDB and self.charDB[key]
end

-- Set character-specific data
function Addon:SetCharData(key, value)
    if self.charDB then
        self.charDB[key] = value
    end
end

-- Reset tracking data
function Addon:ResetData()
    if self.charDB then
        self.charDB.dungeonRuns = {}
        self.charDB.completedPhases = {}
        self.charDB.lastRecommendation = nil
        self.charDB.totalRunsAllTime = 0
    end
    if self.Tracker then
        self.Tracker:RefreshData()
    end
    if self.MainFrame and self.MainFrame:IsShown() then
        self.MainFrame:Refresh()
    end
    print("|cff00ff00[DST]|r " .. DST.L["CMD_RESET_CONFIRM"])
end

-- Print addon message
function Addon:Print(msg)
    print("|cff00ff00[DST]|r " .. tostring(msg))
end

-- Debug print (only in dev mode)
function Addon:Debug(msg)
    if self.debugMode then
        print("|cffff9900[DST Debug]|r " .. tostring(msg))
    end
end

-- Get optimization mode
function Addon:GetOptimizationMode()
    return self:GetSetting("optimizationMode") or "balanced"
end

-- Set optimization mode
function Addon:SetOptimizationMode(mode)
    if mode == "xp" or mode == "balanced" or mode == "rep" then
        self:SetSetting("optimizationMode", mode)
        if self.MainFrame and self.MainFrame:IsShown() then
            self.MainFrame:Refresh()
        end
        return true
    end
    return false
end

-- Get target faction for rep optimization
function Addon:GetTargetFaction()
    return self:GetSetting("targetFaction")
end

-- Set target faction for rep optimization
function Addon:SetTargetFaction(faction)
    self:SetSetting("targetFaction", faction)
    if self.MainFrame and self.MainFrame:IsShown() then
        self.MainFrame:Refresh()
    end
end

-- Copy table utility
function CopyTable(t)
    if type(t) ~= "table" then return t end
    local copy = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            copy[k] = CopyTable(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- Debug: Verify Init.lua loaded completely
print("[DST Debug] Init.lua loaded. GetOptimizationMode exists:", Addon.GetOptimizationMode ~= nil)
print("[DST Debug] GetTargetFaction exists:", Addon.GetTargetFaction ~= nil)
