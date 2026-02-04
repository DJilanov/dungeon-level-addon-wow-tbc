-- Dungeon Spam Tracker - Main Frame UI
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants

-- Create main frame
function Addon:CreateMainFrame()
    if self.MainFrame then return self.MainFrame end

    local frame = CreateFrame("Frame", "DJDungeonSpamGuideFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:SetSize(700, 600)
    frame:SetPoint("CENTER")
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 11, right = 12, top = 12, bottom = 11}
    })
    frame:SetBackdropColor(0, 0, 0, 0.95)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    frame:Hide()

    -- Make closeable with ESC
    tinsert(UISpecialFrames, "DJDungeonSpamGuideFrame")

    -- Dragging
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        if Addon.profile then
            Addon.profile.framePosition = {
                point = point,
                relativePoint = relativePoint,
                xOfs = xOfs,
                yOfs = yOfs,
            }
        end
    end)

    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -20)
    frame.title:SetText("|cff00ff00" .. L["ADDON_NAME"] .. "|r")

    -- Close button
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    -- Character info header
    frame.header = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.header:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -50)
    frame.header:SetSize(670, 60)
    frame.header:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.header:SetBackdropColor(0.1, 0.1, 0.2, 0.8)

    -- Character name and level
    frame.header.charInfo = frame.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.header.charInfo:SetPoint("TOPLEFT", frame.header, "TOPLEFT", 10, -8)

    -- XP bar
    frame.header.xpBar = DST.ProgressBar:CreateXPBar(frame.header, 650)
    frame.header.xpBar:SetPoint("TOPLEFT", frame.header.charInfo, "BOTTOMLEFT", 0, -5)

    -- Current recommendation panel
    frame.recPanel = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.recPanel:SetPoint("TOPLEFT", frame.header, "BOTTOMLEFT", 0, -10)
    frame.recPanel:SetSize(670, 100)
    frame.recPanel:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.recPanel:SetBackdropColor(0.0, 0.2, 0.1, 0.8)
    frame.recPanel:SetBackdropBorderColor(0.0, 1.0, 0.5, 1)

    -- Recommendation title
    frame.recPanel.title = frame.recPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.recPanel.title:SetPoint("TOP", frame.recPanel, "TOP", 0, -8)
    frame.recPanel.title:SetText(L["CURRENT_RECOMMENDATION"])

    -- Recommendation text
    frame.recPanel.text = frame.recPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.recPanel.text:SetPoint("TOPLEFT", frame.recPanel.title, "BOTTOMLEFT", -200, -8)
    frame.recPanel.text:SetWidth(650)
    frame.recPanel.text:SetJustifyH("CENTER")

    -- Optimization mode selector (with more spacing from recommendation panel)
    frame.optModeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.optModeLabel:SetPoint("TOPLEFT", frame.recPanel, "BOTTOMLEFT", 5, -20)
    frame.optModeLabel:SetText(L["OPT_MODE"] .. ":")

    -- Create optimization mode buttons
    frame.optModeButtons = {}
    local modeButtons = {
        {mode = "xp", label = L["OPT_XP"], tooltip = L["OPT_XP_DESC"]},
        {mode = "balanced", label = L["OPT_BALANCED"], tooltip = L["OPT_BALANCED_DESC"]},
        {mode = "rep", label = L["OPT_REP"], tooltip = L["OPT_REP_DESC"]},
    }

    for i, modeData in ipairs(modeButtons) do
        local btn = CreateFrame("Button", "DSTOptBtn"..i, frame, BackdropTemplateMixin and "BackdropTemplate")
        btn:SetSize(140, 30)
        btn.mode = modeData.mode
        btn.tooltip = modeData.tooltip

        if i == 1 then
            btn:SetPoint("LEFT", frame.optModeLabel, "RIGHT", 10, 0)
        else
            btn:SetPoint("LEFT", frame.optModeButtons[i-1], "RIGHT", 5, 0)
        end

        -- Enable mouse interaction properly
        btn:SetFrameLevel(frame:GetFrameLevel() + 2)
        btn:EnableMouse(true)

        -- Custom button background that scales properly
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = false,
            tileSize = 16,
            edgeSize = 12,
            insets = {left = 3, right = 3, top = 3, bottom = 3}
        })
        btn:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
        btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

        -- Create properly centered text
        btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0)
        btn.text:SetText(modeData.label)
        btn.text:SetJustifyH("CENTER")
        btn.text:SetJustifyV("MIDDLE")

        btn:SetScript("OnClick", function(self)
            local addon = DJDungeonSpamGuide
            if addon and addon.SetOptimizationMode then
                local success = addon:SetOptimizationMode(self.mode)
                if success then
                    if addon.Print then
                        addon:Print(string.format(L["MODE_CHANGED"], modeData.label))
                    end
                    frame:RefreshOptModeButtons()
                    frame:Refresh()
                end
            end
        end)

        btn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.4, 0.4, 0.4, 0.9)
            self:SetBackdropBorderColor(1, 1, 0, 1)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(modeData.label, 1, 1, 1)
            GameTooltip:AddLine(self.tooltip, nil, nil, nil, true)
            GameTooltip:Show()
        end)

        btn:SetScript("OnLeave", function(self)
            local currentMode = Addon.GetOptimizationMode and Addon:GetOptimizationMode() or "balanced"
            if self.mode == currentMode then
                self:SetBackdropColor(0.2, 0.6, 0.2, 0.9)
                self:SetBackdropBorderColor(0, 1, 0, 1)
            else
                self:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
                self:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
            end
            GameTooltip:Hide()
        end)

        -- Explicitly enable button and register for clicks
        btn:Enable()
        btn:RegisterForClicks("LeftButtonUp")

        frame.optModeButtons[i] = btn
    end

    -- Target faction dropdown (for rep mode)
    frame.factionLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.factionLabel:SetPoint("LEFT", frame.optModeButtons[3], "RIGHT", 15, 0)
    frame.factionLabel:SetText(L["TARGET_FACTION"] .. ":")

    frame.factionDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
    frame.factionDropdown:SetPoint("LEFT", frame.factionLabel, "RIGHT", -15, -2)
    UIDropDownMenu_SetWidth(frame.factionDropdown, 140)
    UIDropDownMenu_SetText(frame.factionDropdown, "Auto")

    -- Faction dropdown initialize function
    UIDropDownMenu_Initialize(frame.factionDropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo()

        -- Add "Auto" option
        info.text = "Auto"
        info.value = nil
        info.func = function()
            if Addon.SetTargetFaction then
                Addon:SetTargetFaction(nil)
            end
            UIDropDownMenu_SetText(frame.factionDropdown, "Auto")
            frame:Refresh()
        end
        local currentFaction = Addon.GetTargetFaction and Addon:GetTargetFaction() or nil
        info.checked = (currentFaction == nil)
        UIDropDownMenu_AddButton(info)

        -- Add each faction
        local factions = {
            "Honor Hold",
            "Cenarion Expedition",
            "The Sha'tar",
            "Lower City",
            "Keepers of Time",
            "The Consortium",
        }

        for _, faction in ipairs(factions) do
            info = UIDropDownMenu_CreateInfo()
            info.text = faction
            info.value = faction
            info.func = function()
                if Addon.SetTargetFaction then
                    Addon:SetTargetFaction(faction)
                end
                UIDropDownMenu_SetText(frame.factionDropdown, faction)
                if Addon.Print then
                    Addon:Print(string.format(L["FACTION_CHANGED"], faction))
                end
                frame:Refresh()
            end
            info.checked = (currentFaction == faction)
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Refresh optimization mode buttons function
    frame.RefreshOptModeButtons = function(self)
        local addon = DJDungeonSpamGuide
        local currentMode = addon and addon.GetOptimizationMode and addon:GetOptimizationMode() or "balanced"
        for _, btn in ipairs(frame.optModeButtons) do
            if btn.mode == currentMode then
                -- Active button - green highlight
                btn:SetBackdropColor(0.2, 0.6, 0.2, 0.9)
                btn:SetBackdropBorderColor(0, 1, 0, 1)
                btn:Disable()
            else
                -- Inactive button - normal gray
                btn:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
                btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
                btn:Enable()
            end
        end

        -- Show/hide faction dropdown based on mode
        if currentMode == "rep" then
            frame.factionLabel:Show()
            frame.factionDropdown:Show()
        else
            frame.factionLabel:Hide()
            frame.factionDropdown:Hide()
        end
    end

    -- Dungeon list section header (with more spacing from buttons)
    frame.listHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.listHeader:SetPoint("TOPLEFT", frame.recPanel, "BOTTOMLEFT", 5, -30)
    frame.listHeader:SetText("All Dungeons")

    -- View mode selector - Dungeons and Raids buttons (on same row as optimization buttons)
    frame.viewMode = "dungeons" -- default to dungeons

    -- Dungeons button (positioned after faction dropdown, or after opt buttons if dropdown hidden)
    frame.dungeonsButton = CreateFrame("Button", "DSTDungeonsBtn", frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.dungeonsButton:SetSize(100, 30)
    frame.dungeonsButton:SetPoint("LEFT", frame.optModeLabel, "LEFT", 550, 0)
    frame.dungeonsButton:SetFrameLevel(frame:GetFrameLevel() + 2)
    frame.dungeonsButton:EnableMouse(true)
    frame.dungeonsButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.dungeonsButton:SetBackdropColor(0.2, 0.6, 0.3, 0.9)
    frame.dungeonsButton:SetBackdropBorderColor(0, 1, 0, 1)

    frame.dungeonsButton.text = frame.dungeonsButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.dungeonsButton.text:SetPoint("CENTER")
    frame.dungeonsButton.text:SetText("Dungeons")

    -- Enable button and register for clicks
    frame.dungeonsButton:Enable()
    frame.dungeonsButton:RegisterForClicks("LeftButtonUp")

    frame.dungeonsButton:SetScript("OnClick", function(self)
        -- Clicking Dungeons button switches TO dungeons view
        frame.viewMode = "dungeons"
        frame.listHeader:SetText("All Dungeons")
        self:Hide()
        frame.raidsButton:Show()

        -- Restore saved optimization mode if exists
        local addon = DJDungeonSpamGuide
        if addon and addon.SetOptimizationMode and frame.savedOptMode then
            addon:SetOptimizationMode(frame.savedOptMode)
            frame.savedOptMode = nil
        end

        -- Show optimization buttons in dungeons view
        frame.optModeLabel:Show()
        frame.factionLabel:Show()
        frame.factionDropdown:Show()
        for _, btn in ipairs(frame.optModeButtons) do
            btn:Show()
        end
        frame:RefreshOptModeButtons()
        frame:Refresh()

        -- Force scroll to top with delay
        C_Timer.After(0.2, function()
            if frame and frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end)

    -- Raids button (same position as dungeons button, on optimization row)
    frame.raidsButton = CreateFrame("Button", "DSTRaidsBtn", frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.raidsButton:SetSize(100, 30)
    frame.raidsButton:SetPoint("LEFT", frame.optModeLabel, "LEFT", 550, 0)
    frame.raidsButton:SetFrameLevel(frame:GetFrameLevel() + 2)
    frame.raidsButton:EnableMouse(true)
    frame.raidsButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.raidsButton:SetBackdropColor(0.7, 0.2, 0.5, 0.9)
    frame.raidsButton:SetBackdropBorderColor(1, 0.3, 0.7, 1)

    frame.raidsButton.text = frame.raidsButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.raidsButton.text:SetPoint("CENTER")
    frame.raidsButton.text:SetText("Raids")

    -- Enable button and register for clicks
    frame.raidsButton:Enable()
    frame.raidsButton:RegisterForClicks("LeftButtonUp")

    frame.raidsButton:SetScript("OnClick", function(self)
        -- Clicking Raids button switches TO raids view
        frame.viewMode = "raids"
        frame.listHeader:SetText("All Raids")
        self:Hide()
        frame.dungeonsButton:Show()

        -- Save current mode and switch to balanced for raids view
        local addon = DJDungeonSpamGuide
        if addon and addon.GetOptimizationMode then
            frame.savedOptMode = addon:GetOptimizationMode()
            if addon.SetOptimizationMode and frame.savedOptMode ~= "balanced" then
                addon:SetOptimizationMode("balanced")
            end
        end

        -- Hide optimization buttons in raids view (they're only for dungeons)
        frame.optModeLabel:Hide()
        frame.factionLabel:Hide()
        frame.factionDropdown:Hide()
        for _, btn in ipairs(frame.optModeButtons) do
            btn:Hide()
        end
        frame:Refresh()

        -- Force scroll to top with delay
        C_Timer.After(0.2, function()
            if frame and frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end)

    -- Initially hide dungeons button (dungeons is default active view, so show Raids button to switch)
    frame.dungeonsButton:Hide()

    -- Scroll frame for dungeon list (smaller height to fit faction panel)
    frame.scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    frame.scrollFrame:SetPoint("TOPLEFT", frame.listHeader, "BOTTOMLEFT", 0, -5)
    frame.scrollFrame:SetSize(650, 180)

    -- Scroll child
    frame.scrollChild = CreateFrame("Frame", nil, frame.scrollFrame)
    frame.scrollChild:SetSize(630, 1)
    frame.scrollFrame:SetScrollChild(frame.scrollChild)

    -- Dungeon cards container
    frame.dungeonCards = {}

    -- Faction progress section
    frame.factionPanel = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.factionPanel:SetPoint("TOPLEFT", frame.scrollFrame, "BOTTOMLEFT", 0, -10)
    frame.factionPanel:SetSize(670, 120)
    frame.factionPanel:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.factionPanel:SetBackdropColor(0.1, 0.1, 0.2, 0.8)

    -- Faction progress title
    frame.factionPanel.title = frame.factionPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.factionPanel.title:SetPoint("TOPLEFT", frame.factionPanel, "TOPLEFT", 10, -5)
    frame.factionPanel.title:SetText(L["QUICK_STATS"])

    -- Create faction progress bars
    frame.factionBars = {}
    local factionOrder = {
        "Honor Hold",
        "Cenarion Expedition",
        "The Sha'tar",
        "Lower City",
        "Keepers of Time",
        "The Consortium",
    }

    local yOffset = -25
    for i, factionName in ipairs(factionOrder) do
        local bar = DST.ProgressBar:CreateRepBar(frame.factionPanel, factionName, 310)

        if i <= 3 then
            -- Left column
            bar:SetPoint("TOPLEFT", frame.factionPanel, "TOPLEFT", 10, yOffset)
            if i == 3 then
                yOffset = -25 -- Reset for right column
            else
                yOffset = yOffset - 23
            end
        else
            -- Right column
            bar:SetPoint("TOPRIGHT", frame.factionPanel, "TOPRIGHT", -10, yOffset)
            yOffset = yOffset - 23
        end

        frame.factionBars[factionName] = bar
    end

    -- Methods (wrapped to preserve correct self reference)
    frame.Refresh = function() Addon:RefreshMainFrame() end
    frame.RefreshHeader = function() Addon:RefreshHeader() end
    frame.RefreshRecommendation = function() Addon:RefreshRecommendation() end
    frame.RefreshDungeonList = function() Addon:RefreshDungeonList() end
    frame.RefreshFactions = function() Addon:RefreshFactions() end

    -- Initialize optimization mode buttons
    frame:RefreshOptModeButtons()

    self.MainFrame = frame
    return frame
end

-- Refresh entire frame
function Addon:RefreshMainFrame()
    if not self.MainFrame then return end

    self.MainFrame:RefreshOptModeButtons()
    self:RefreshHeader()
    self:RefreshRecommendation()
    self:RefreshDungeonList()
    self:RefreshFactions()
end

-- Refresh header (character info and XP)
function Addon:RefreshHeader()
    if not self.MainFrame then return end

    local tracker = self.Tracker
    if not tracker then return end

    local frame = self.MainFrame
    local charName = UnitName("player")
    local level = tracker.playerLevel

    frame.header.charInfo:SetText(string.format("Character: |cffffffff%s|r  |  Level: |cffffffff%d|r", charName, level))

    -- Update XP bar
    if frame.header.xpBar and frame.header.xpBar.UpdateXP then
        frame.header.xpBar:UpdateXP()
    end
end

-- Refresh recommendation panel
function Addon:RefreshRecommendation()
    if not self.MainFrame then return end

    local recommender = self.Recommender
    if not recommender then return end

    local frame = self.MainFrame
    local rec = recommender:GetRecommendation()

    if rec then
        local text = string.format(
            "|cff00ff80>> %s <<|r\n" ..
            "Faction: %s (%s) | Runs to Cap: %d | Runs to Level: %d\n" ..
            "Time: ~%d min | Rep/hr: %s | XP/hr: %s",
            rec.name,
            rec.data.faction,
            self.Tracker:GetFactionStanding(rec.data.faction),
            rec.runsToRepCap,
            rec.runsToLevel,
            rec.data.avgDuration,
            self:FormatNumber(rec.data.repPerHour),
            self:FormatNumber(rec.data.expPerHour)
        )
        frame.recPanel.text:SetText(text)
    else
        frame.recPanel.text:SetText("|cff999999No recommendation available\n(Level 70 or all reputations capped)|r")
    end
end

-- Refresh dungeon/raid list
function Addon:RefreshDungeonList()
    if not self.MainFrame then return end

    local frame = self.MainFrame
    local viewMode = frame.viewMode or "dungeons"

    -- Clear existing cards thoroughly
    for _, card in ipairs(frame.dungeonCards) do
        card:Hide()
        card:SetParent(nil)
        card:ClearAllPoints()
    end
    wipe(frame.dungeonCards)

    -- Also hide any orphaned children of scrollChild
    local children = {frame.scrollChild:GetChildren()}
    for _, child in ipairs(children) do
        if child.SetDungeon then
            child:Hide()
        end
    end

    local yOffset = -5

    if viewMode == "raids" then
        -- Show raids
        if not DST.RaidData then return end

        local allRaids = DST.RaidData:GetOrderedRaids()

        for i, raidEntry in ipairs(allRaids) do
            local card = DST.DungeonCard:Create(frame.scrollChild, 620)
            card:SetPoint("TOPLEFT", frame.scrollChild, "TOPLEFT", 0, yOffset)

            -- Create raid status info
            local raidStatus = {
                name = raidEntry.name,
                data = raidEntry.data,
                status = "AVAILABLE",
                statusText = nil,
                isRecommended = false,
                runsCompleted = 0,
                runsToRepCap = 0,
                runsToLevel = 0,
                factionRep = 0,
                factionStanding = "N/A",
            }
            card:SetDungeon(raidEntry.name, raidEntry.data, raidStatus)

            table.insert(frame.dungeonCards, card)
            card:Show()

            yOffset = yOffset - 55
        end
    else
        -- Show dungeons
        local recommender = self.Recommender
        if not recommender then return end

        local allDungeons = recommender:GetAllDungeonStatus()

        for i, dungeonStatus in ipairs(allDungeons) do
            local card = DST.DungeonCard:Create(frame.scrollChild, 620)
            card:SetPoint("TOPLEFT", frame.scrollChild, "TOPLEFT", 0, yOffset)
            card:SetDungeon(dungeonStatus.name, dungeonStatus.data, dungeonStatus)

            table.insert(frame.dungeonCards, card)
            card:Show()

            yOffset = yOffset - 55
        end
    end

    -- Update scroll child height
    local newHeight = math.max(math.abs(yOffset) + 50, frame.scrollFrame:GetHeight())
    frame.scrollChild:SetHeight(newHeight)
end

-- Refresh faction progress bars
function Addon:RefreshFactions()
    if not self.MainFrame then return end

    local frame = self.MainFrame

    for factionName, bar in pairs(frame.factionBars) do
        if bar.UpdateRep then
            bar:UpdateRep()
        end
    end
end

-- Format number with commas
function Addon:FormatNumber(num)
    local formatted = tostring(num)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end
