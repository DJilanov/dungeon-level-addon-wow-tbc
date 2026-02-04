-- Dungeon Spam Tracker - Event Handler
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants

-- Create event frame
local EventFrame = CreateFrame("Frame")
Addon.EventFrame = EventFrame

-- Track state
local isInDungeon = false
local currentDungeon = nil
local lastZone = nil
local isLoggingOut = false

-- Initialize events (no longer used - see bottom of file for event registration)
function EventFrame:Init()
    -- Deprecated - events are now registered at file load to prevent taint
end

-- Main event handler
function EventFrame:OnEvent(event, ...)
    -- Stop processing events if logging out to avoid UI taint
    if isLoggingOut and event ~= "PLAYER_LOGOUT" then
        return
    end

    if event == "ADDON_LOADED" then
        self:OnAddonLoaded(...)
    elseif event == "PLAYER_ENTERING_WORLD" then
        self:OnPlayerEnteringWorld(...)
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        self:OnZoneChanged()
    elseif event == "UPDATE_FACTION" then
        self:OnFactionUpdate()
    elseif event == "PLAYER_XP_UPDATE" then
        self:OnXPUpdate()
    elseif event == "PLAYER_LEVEL_UP" then
        self:OnLevelUp(...)
    elseif event == "CHAT_MSG_SYSTEM" then
        self:OnSystemMessage(...)
    elseif event == "PLAYER_LOGOUT" then
        isLoggingOut = true
        -- Hide UI to prevent taint issues
        if Addon.MainFrame then
            Addon.MainFrame:Hide()
        end
    end
end

-- Addon loaded
function EventFrame:OnAddonLoaded(loadedAddon)
    if loadedAddon ~= ADDON_NAME then return end

    -- Delay ALL initialization to avoid taint
    C_Timer.After(1, function()
        -- Initialize database
        Addon:InitializeDB()

        -- Initialize modules
        if Addon.Tracker then
            Addon.Tracker:Init()
        end
        if Addon.Recommender then
            Addon.Recommender:Init()
        end
        if Addon.ZoneDetection then
            Addon.ZoneDetection:Init()
        end

        -- Initialize minimap button
        if DST.MinimapButton then
            DST.MinimapButton:Init()
        end

        -- Show welcome message on first login
        if Addon.charDB and Addon.charDB.firstLogin then
            Addon:Print(L["ADDON_LOADED"])
            Addon.charDB.firstLogin = false
        end
    end)

    -- Unregister this event
    self:UnregisterEvent("ADDON_LOADED")
end

-- Player entering world (after loading screens)
function EventFrame:OnPlayerEnteringWorld(isInitialLogin, isReloadingUi)
    -- Check current zone
    C_Timer.After(1, function()
        self:OnZoneChanged()
    end)

    -- Refresh tracker data
    if Addon.Tracker then
        Addon.Tracker:RefreshData()
    end
end

-- Zone changed
function EventFrame:OnZoneChanged()
    local zoneName = GetRealZoneText()
    local inInstance, instanceType = IsInInstance()

    -- Check if entering Outland via Dark Portal
    if Addon.ZoneDetection then
        Addon.ZoneDetection:CheckZone(zoneName)
    end

    -- Check if entering a dungeon
    if inInstance and instanceType == "party" then
        local instanceName, _, _, _, _, _, _, instanceID = GetInstanceInfo()

        if not isInDungeon then
            -- Just entered a dungeon
            isInDungeon = true
            currentDungeon = instanceName

            self:OnDungeonEnter(instanceName, instanceID)
        end
    else
        if isInDungeon then
            -- Just left a dungeon
            self:OnDungeonExit(currentDungeon)
            isInDungeon = false
            currentDungeon = nil
        end
    end

    lastZone = zoneName
end

-- Entered a dungeon
function EventFrame:OnDungeonEnter(instanceName, instanceID)
    -- Find dungeon data
    local dungeonData, dungeonName = DST.DungeonData:GetDungeonByID(instanceID)

    if dungeonData and Addon:GetSetting("showOnDungeonEnter") then
        -- Increment run counter
        if Addon.Tracker then
            local runs = Addon.Tracker:GetDungeonRuns(dungeonName)
            Addon:Print(string.format(L["DUNGEON_ENTERED"], dungeonName, runs + 1))

            -- Calculate remaining runs
            local runsToRepCap = Addon.Tracker:GetRunsToRepCap(dungeonName)
            if runsToRepCap > 0 then
                Addon:Print(string.format(L["TIP_RUNS_REMAINING"], runsToRepCap))
            end
        end

        -- Auto-track the run
        if Addon:GetSetting("autoTrackRuns") and Addon.Tracker then
            Addon.Tracker:IncrementRun(dungeonName)
        end
    end
end

-- Exited a dungeon
function EventFrame:OnDungeonExit(instanceName)
    -- Could add completion logic here
    -- For now, we track runs on entry
end

-- Faction/Reputation updated
function EventFrame:OnFactionUpdate()
    if Addon.Tracker then
        Addon.Tracker:RefreshReputation()
    end

    -- Update UI if visible (use pcall to prevent taint)
    if Addon.MainFrame and Addon.MainFrame:IsShown() then
        pcall(function() Addon.MainFrame:Refresh() end)
    end
end

-- XP updated
function EventFrame:OnXPUpdate()
    if Addon.Tracker then
        Addon.Tracker:RefreshXP()
    end

    -- Update UI if visible (use pcall to prevent taint)
    if Addon.MainFrame and Addon.MainFrame:IsShown() then
        pcall(function() Addon.MainFrame:RefreshHeader() end)
    end
end

-- Player leveled up
function EventFrame:OnLevelUp(newLevel)
    Addon:Print(string.format(L["LEVEL_UP"], newLevel))

    -- Update tracker
    if Addon.Tracker then
        Addon.Tracker:RefreshData()
    end

    -- Get new recommendation
    if Addon.Recommender then
        local recommendation = Addon.Recommender:GetRecommendation()
        if recommendation then
            Addon:Print(string.format(L["NEXT_DUNGEON"], recommendation.name))
        end
    end
end

-- System message (for detecting dungeon completion)
function EventFrame:OnSystemMessage(msg)
    -- Could parse for boss kills or instance completion here
    -- For TBC, we mainly track via zone changes
end

-- Register events after player enters world to avoid taint
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and select(1, ...) == ADDON_NAME then
        EventFrame:OnAddonLoaded(...)
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Now it's safe to register all events
        EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
        EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        EventFrame:RegisterEvent("UPDATE_FACTION")
        EventFrame:RegisterEvent("PLAYER_XP_UPDATE")
        EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
        EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
        EventFrame:RegisterEvent("PLAYER_LOGOUT")
        -- Switch to full event handler
        EventFrame:SetScript("OnEvent", EventFrame.OnEvent)
        EventFrame:OnPlayerEnteringWorld(...)
    end
end)
