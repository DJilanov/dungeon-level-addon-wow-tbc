-- Dungeon Spam Tracker - Slash Commands
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L

-- Register slash commands
SLASH_DUNGEONSPAM1 = "/dungeonspam"
SLASH_DUNGEONSPAM2 = "/ds"

SlashCmdList["DUNGEONSPAM"] = function(msg)
    -- Debug: Confirm handler is called
    if not Addon then
        print("[DST] ERROR: DJDungeonSpamGuide addon table not found!")
        return
    end

    msg = string.lower(msg or "")
    local args = {}
    for word in msg:gmatch("%S+") do
        table.insert(args, word)
    end

    local cmd = args[1] or ""

    if cmd == "reset" then
        -- Confirm reset - using direct confirmation to avoid StaticPopupDialogs taint
        print("|cffff9900[DST]|r Are you sure you want to reset? Type '/ds confirmreset' to confirm.")

    elseif cmd == "confirmreset" then
        -- Confirmed reset
        Addon:ResetData()

    elseif cmd == "config" or cmd == "options" or cmd == "settings" then
        -- Show options (future implementation)
        Addon:Print("Options panel coming soon!")

    elseif cmd == "debug" then
        -- Toggle debug mode
        Addon.debugMode = not Addon.debugMode
        Addon:Print("Debug mode: " .. (Addon.debugMode and "ON" or "OFF"))

    elseif cmd == "recommend" or cmd == "rec" then
        -- Show current recommendation
        if Addon.Recommender then
            local rec = Addon.Recommender:GetRecommendation()
            if rec then
                Addon:Print("Recommended: " .. rec.name)
                Addon:Print("  Faction: " .. rec.data.faction)
                Addon:Print("  Rep/Run: " .. rec.data.repPerRun)
                Addon:Print("  XP/Run: " .. rec.data.expPerRun)
            else
                Addon:Print("No recommendation available (level 70 or all reps capped)")
            end
        end

    elseif cmd == "status" then
        -- Show current status
        local level = UnitLevel("player")
        local xp = UnitXP("player")
        local xpMax = UnitXPMax("player")

        Addon:Print("=== Dungeon Spam Tracker Status ===")
        Addon:Print(string.format("Level: %d | XP: %d / %d", level, xp, xpMax))

        if Addon.Tracker then
            local totalRuns = Addon.Tracker:GetTotalRuns()
            Addon:Print(string.format("Total dungeon runs: %d", totalRuns))
        end

    elseif cmd == "runs" then
        -- Show run counts
        if Addon.Tracker then
            Addon:Print("=== Dungeon Run Counts ===")
            local runs = Addon.charDB.dungeonRuns or {}
            local hasRuns = false
            for dungeon, count in pairs(runs) do
                if count > 0 then
                    Addon:Print(string.format("  %s: %d runs", dungeon, count))
                    hasRuns = true
                end
            end
            if not hasRuns then
                Addon:Print("  No runs recorded yet.")
            end
        end

    elseif cmd == "mode" then
        -- Change optimization mode
        local mode = args[2]
        if mode == "xp" or mode == "balanced" or mode == "rep" then
            Addon:SetOptimizationMode(mode)
            local modeNames = {xp = L["OPT_XP"], balanced = L["OPT_BALANCED"], rep = L["OPT_REP"]}
            Addon:Print(string.format(L["MODE_CHANGED"], modeNames[mode]))
        else
            Addon:Print("Usage: /ds mode <xp|balanced|rep>")
            Addon:Print("Current mode: " .. Addon:GetOptimizationMode())
        end

    elseif cmd == "faction" then
        -- Set target faction for rep mode
        local faction = args[2]
        if faction then
            -- Try to match faction name (case insensitive)
            local C = DST.Constants
            local hellfireFaction = C.hellfireFaction or "Honor Hold"
            local factions = {
                ["honor"] = hellfireFaction,
                ["thrallmar"] = hellfireFaction,
                ["hellfire"] = hellfireFaction,
                ["cenarion"] = "Cenarion Expedition",
                ["shatar"] = "The Sha'tar",
                ["lower"] = "Lower City",
                ["keepers"] = "Keepers of Time",
                ["consortium"] = "The Consortium",
            }

            local matched = factions[string.lower(faction)]
            if matched then
                Addon:SetTargetFaction(matched)
                Addon:Print(string.format(L["FACTION_CHANGED"], matched))
                -- Automatically switch to rep mode
                if Addon:GetOptimizationMode() ~= "rep" then
                    Addon:SetOptimizationMode("rep")
                    Addon:Print(string.format(L["MODE_CHANGED"], L["OPT_REP"]))
                end
            else
                Addon:Print("Unknown faction. Use: honor/thrallmar, cenarion, shatar, lower, keepers, consortium")
            end
        else
            local current = Addon:GetTargetFaction()
            Addon:Print("Target faction: " .. (current or "Auto"))
            Addon:Print("Usage: /ds faction <name>")
        end

    elseif cmd == "help" or cmd == "?" then
        -- Show help
        Addon:Print("=== Dungeon Spam Tracker Commands ===")
        Addon:Print("/ds - Open the tracker window")
        Addon:Print("/ds reset - Reset all tracking data")
        Addon:Print("/ds recommend - Show current dungeon recommendation")
        Addon:Print("/ds status - Show current status")
        Addon:Print("/ds runs - Show dungeon run counts")
        Addon:Print("/ds mode <xp|balanced|rep> - Change optimization mode")
        Addon:Print("/ds faction <name> - Set target faction for rep mode")
        Addon:Print("/ds help - Show this help message")

    else
        -- Toggle main frame
        local success, err = pcall(function()
            Addon:Toggle()
        end)
        if not success then
            print("|cffff0000[DST] Error:|r " .. tostring(err))
            print("[DST] Please report this error and type /console scriptErrors 1 to see full details")
        end
    end
end

-- Toggle main frame
function Addon:Toggle()
    -- Safety check
    if not self then
        print("[DST] ERROR: Addon table is nil in Toggle!")
        return
    end

    -- Try to create main frame if it doesn't exist
    if not self.MainFrame then
        print("[DST] Creating main frame...")
        local success, err = pcall(function()
            self:CreateMainFrame()
        end)
        if not success then
            print("|cffff0000[DST] Failed to create main frame:|r " .. tostring(err))
            return
        end
    end

    -- Check if frame was successfully created
    if not self.MainFrame then
        print("[DST] ERROR: MainFrame is still nil after CreateMainFrame!")
        return
    end

    -- Toggle visibility
    if self.MainFrame:IsShown() then
        self.MainFrame:Hide()
    else
        self.MainFrame:Show()
        local success, err = pcall(function()
            self.MainFrame:Refresh()
        end)
        if not success then
            print("|cffff0000[DST] Warning: Failed to refresh main frame:|r " .. tostring(err))
        end
    end
end

-- Show main frame
function Addon:Show()
    if not self.MainFrame then
        self:CreateMainFrame()
    end
    self.MainFrame:Show()
    self.MainFrame:Refresh()
end

-- Hide main frame
function Addon:Hide()
    if self.MainFrame then
        self.MainFrame:Hide()
    end
end

-- Confirmation dialog for reset
-- TEMPORARILY DISABLED FOR DEBUGGING - Testing if StaticPopupDialogs causes taint
--[[
StaticPopupDialogs["DST_CONFIRM_RESET"] = {
    text = "Are you sure you want to reset all Dungeon Spam Tracker data?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        Addon:ResetData()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}
]]--
