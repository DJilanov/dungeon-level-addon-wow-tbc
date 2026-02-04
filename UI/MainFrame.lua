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

    -- Back button (initially hidden, shown in detail view)
    frame.backButton = CreateFrame("Button", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.backButton:SetSize(80, 30)
    frame.backButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -20)
    frame.backButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.backButton:SetBackdropColor(0.3, 0.3, 0.4, 0.9)
    frame.backButton:SetBackdropBorderColor(0.6, 0.6, 0.7, 1)
    frame.backButton:EnableMouse(true)
    frame.backButton:RegisterForClicks("LeftButtonUp")

    frame.backButton.text = frame.backButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.backButton.text:SetPoint("CENTER")
    frame.backButton.text:SetText("< Back")

    frame.backButton:SetScript("OnClick", function(self)
        Addon:ShowListView()
    end)

    frame.backButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.4, 0.4, 0.5, 1)
        self:SetBackdropBorderColor(0.8, 0.8, 1, 1)
    end)

    frame.backButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.3, 0.3, 0.4, 0.9)
        self:SetBackdropBorderColor(0.6, 0.6, 0.7, 1)
    end)

    frame.backButton:Hide() -- Hidden by default

    -- World Map button (shows Outland dungeon locations map)
    frame.worldMapButton = CreateFrame("Button", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.worldMapButton:SetSize(90, 30)
    frame.worldMapButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -20)
    frame.worldMapButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.worldMapButton:SetBackdropColor(0.2, 0.4, 0.6, 0.9)
    frame.worldMapButton:SetBackdropBorderColor(0.4, 0.6, 0.8, 1)
    frame.worldMapButton:EnableMouse(true)
    frame.worldMapButton:RegisterForClicks("LeftButtonUp")

    frame.worldMapButton.text = frame.worldMapButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.worldMapButton.text:SetPoint("CENTER")
    frame.worldMapButton.text:SetText("World Map")

    frame.worldMapButton:SetScript("OnClick", function(self)
        Addon:ShowWorldMapView()
    end)

    frame.worldMapButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.3, 0.5, 0.7, 1)
        self:SetBackdropBorderColor(0.5, 0.7, 1, 1)
    end)

    frame.worldMapButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.2, 0.4, 0.6, 0.9)
        self:SetBackdropBorderColor(0.4, 0.6, 0.8, 1)
    end)

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

    -- Create custom dropdown button (avoids UIDropDownMenu taint)
    frame.factionDropdown = CreateFrame("Button", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.factionDropdown:SetSize(140, 30)
    frame.factionDropdown:SetPoint("LEFT", frame.factionLabel, "RIGHT", 5, 0)
    frame.factionDropdown:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.factionDropdown:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
    frame.factionDropdown:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

    frame.factionDropdown.text = frame.factionDropdown:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.factionDropdown.text:SetPoint("CENTER")
    frame.factionDropdown.text:SetText("Auto")

    -- Create dropdown menu
    frame.factionDropdown.menu = CreateFrame("Frame", nil, frame.factionDropdown, BackdropTemplateMixin and "BackdropTemplate")
    frame.factionDropdown.menu:SetSize(140, 180)
    frame.factionDropdown.menu:SetPoint("TOP", frame.factionDropdown, "BOTTOM", 0, -2)
    frame.factionDropdown.menu:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.factionDropdown.menu:SetBackdropColor(0.1, 0.1, 0.1, 0.95)
    frame.factionDropdown.menu:SetFrameStrata("DIALOG")
    frame.factionDropdown.menu:SetFrameLevel(frame:GetFrameLevel() + 10)
    frame.factionDropdown.menu:Hide()

    -- Create faction buttons
    local factions = {"Auto", "Honor Hold", "Cenarion Expedition", "The Sha'tar", "Lower City", "Keepers of Time", "The Consortium"}
    frame.factionDropdown.buttons = {}

    for i, faction in ipairs(factions) do
        local btn = CreateFrame("Button", nil, frame.factionDropdown.menu, BackdropTemplateMixin and "BackdropTemplate")
        btn:SetSize(134, 22)
        btn:SetPoint("TOP", frame.factionDropdown.menu, "TOP", 0, -3 - (i-1) * 24)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = nil,
            tile = false,
        })
        btn:SetBackdropColor(0.2, 0.2, 0.2, 0.5)

        btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btn.text:SetPoint("CENTER")
        btn.text:SetText(faction)

        btn.faction = (faction == "Auto" and nil or faction)
        btn:SetScript("OnClick", function(self)
            if Addon.SetTargetFaction then
                Addon:SetTargetFaction(self.faction)
            end
            frame.factionDropdown.text:SetText(faction)
            if self.faction and Addon.Print then
                Addon:Print(string.format(L["FACTION_CHANGED"], faction))
            end
            frame.factionDropdown.menu:Hide()
            frame:Refresh()
        end)

        btn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.4, 0.4, 0.6, 0.8)
        end)

        btn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0.2, 0.2, 0.2, 0.5)
        end)

        table.insert(frame.factionDropdown.buttons, btn)
    end

    -- Toggle dropdown menu
    frame.factionDropdown:SetScript("OnClick", function(self)
        if self.menu:IsShown() then
            self.menu:Hide()
        else
            self.menu:Show()
        end
    end)

    frame.factionDropdown:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1, 1, 1, 1)
    end)

    frame.factionDropdown:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    end)

    -- Hide menu when clicking elsewhere
    frame.factionDropdown.menu:SetScript("OnHide", function(self)
        -- Menu hidden
    end)

    -- Refresh optimization mode buttons function
    frame.RefreshOptModeButtons = function(self)
        -- Only update optimization buttons in dungeons view
        if frame.viewMode ~= "dungeons" then return end

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

            -- Sync dropdown text with current target faction
            local targetFaction = addon and addon.GetTargetFaction and addon:GetTargetFaction()
            frame.factionDropdown.text:SetText(targetFaction or "Auto")
        else
            frame.factionLabel:Hide()
            frame.factionDropdown:Hide()
        end
    end

    -- Dungeon list section header (with more spacing from buttons)
    frame.listHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.listHeader:SetPoint("TOPLEFT", frame.recPanel, "BOTTOMLEFT", 5, -30)
    frame.listHeader:SetText("All Dungeons")

    -- View mode selector - Dungeons, Heroics, and Raids buttons (on same row as optimization buttons)
    frame.viewMode = "dungeons" -- default to dungeons
    frame.navigationView = "list" -- "list" or "detail"

    -- Dungeons button
    frame.dungeonsButton = CreateFrame("Button", "DSTDungeonsBtn", frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.dungeonsButton:SetSize(85, 30)
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
        frame.viewMode = "dungeons"
        frame.listHeader:SetText("Normal Dungeons")
        self:Hide()
        frame.heroicsButton:Show()
        frame.raidsButton:Hide()

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

        C_Timer.After(0.2, function()
            if frame and frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end)

    -- Heroics button
    frame.heroicsButton = CreateFrame("Button", "DSTHeroicsBtn", frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.heroicsButton:SetSize(85, 30)
    frame.heroicsButton:SetPoint("LEFT", frame.optModeLabel, "LEFT", 550, 0)
    frame.heroicsButton:SetFrameLevel(frame:GetFrameLevel() + 2)
    frame.heroicsButton:EnableMouse(true)
    frame.heroicsButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.heroicsButton:SetBackdropColor(0.6, 0.3, 0.7, 0.9)
    frame.heroicsButton:SetBackdropBorderColor(0.8, 0.5, 0.9, 1)

    frame.heroicsButton.text = frame.heroicsButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.heroicsButton.text:SetPoint("CENTER")
    frame.heroicsButton.text:SetText("Heroics")

    frame.heroicsButton:Enable()
    frame.heroicsButton:RegisterForClicks("LeftButtonUp")

    frame.heroicsButton:SetScript("OnClick", function(self)
        frame.viewMode = "heroics"
        frame.listHeader:SetText("Heroic Dungeons")
        self:Hide()
        frame.dungeonsButton:Hide()
        frame.raidsButton:Show()

        -- Hide optimization buttons in heroics view
        frame.optModeLabel:Hide()
        frame.factionLabel:Hide()
        frame.factionDropdown:Hide()
        for _, btn in ipairs(frame.optModeButtons) do
            btn:Hide()
        end
        frame:Refresh()

        C_Timer.After(0.2, function()
            if frame and frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end)

    -- Raids button
    frame.raidsButton = CreateFrame("Button", "DSTRaidsBtn", frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.raidsButton:SetSize(85, 30)
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

    frame.raidsButton:Enable()
    frame.raidsButton:RegisterForClicks("LeftButtonUp")

    frame.raidsButton:SetScript("OnClick", function(self)
        frame.viewMode = "raids"
        frame.listHeader:SetText("Raids")
        self:Hide()
        frame.heroicsButton:Hide()
        frame.dungeonsButton:Show()

        -- Hide optimization buttons in raids view
        frame.optModeLabel:Hide()
        frame.factionLabel:Hide()
        frame.factionDropdown:Hide()
        for _, btn in ipairs(frame.optModeButtons) do
            btn:Hide()
        end
        frame:Refresh()

        C_Timer.After(0.2, function()
            if frame and frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end)

    -- Initially hide dungeons button (dungeons is default active view, so show Heroics button to switch)
    frame.dungeonsButton:Hide()
    frame.raidsButton:Hide()

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

    -- Detail View Container (initially hidden)
    frame.detailContainer = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.detailContainer:SetPoint("TOPLEFT", frame.header, "BOTTOMLEFT", 0, -10)
    frame.detailContainer:SetSize(670, 420)
    frame.detailContainer:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.detailContainer:SetBackdropColor(0.1, 0.1, 0.2, 0.8)
    frame.detailContainer:Hide()

    -- Dungeon name in detail view
    frame.detailContainer.dungeonName = frame.detailContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.detailContainer.dungeonName:SetPoint("TOPLEFT", frame.detailContainer, "TOPLEFT", 10, -8)

    -- Dungeon stats in detail view
    frame.detailContainer.dungeonStats = frame.detailContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.detailContainer.dungeonStats:SetPoint("TOPLEFT", frame.detailContainer.dungeonName, "BOTTOMLEFT", 0, -5)
    frame.detailContainer.dungeonStats:SetWidth(650)
    frame.detailContainer.dungeonStats:SetJustifyH("LEFT")

    -- Tab buttons for detail view
    frame.detailContainer.tabs = {}
    local tabNames = {"Loot", "Bosses", "Map", "Location"}
    for i, tabName in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, frame.detailContainer, BackdropTemplateMixin and "BackdropTemplate")
        tab:SetSize(100, 30)
        if i == 1 then
            tab:SetPoint("TOPLEFT", frame.detailContainer.dungeonStats, "BOTTOMLEFT", 0, -10)
        else
            tab:SetPoint("LEFT", frame.detailContainer.tabs[i-1], "RIGHT", 5, 0)
        end

        tab:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = false,
            edgeSize = 12,
            insets = {left = 3, right = 3, top = 3, bottom = 3}
        })
        tab:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
        tab:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(tabName)

        tab.tabName = tabName
        tab:SetScript("OnClick", function(self)
            Addon:SelectDetailTab(self.tabName)
        end)

        frame.detailContainer.tabs[i] = tab
    end

    -- Content scroll frame for detail view
    frame.detailScrollFrame = CreateFrame("ScrollFrame", nil, frame.detailContainer, "UIPanelScrollFrameTemplate")
    frame.detailScrollFrame:SetPoint("TOPLEFT", frame.detailContainer.tabs[1], "BOTTOMLEFT", 0, -10)
    frame.detailScrollFrame:SetSize(640, 280)

    -- Scroll child for detail view
    frame.detailScrollChild = CreateFrame("Frame", nil, frame.detailScrollFrame)
    frame.detailScrollChild:SetSize(620, 1)
    frame.detailScrollFrame:SetScrollChild(frame.detailScrollChild)

    -- Content text for detail view
    frame.detailContentText = frame.detailScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.detailContentText:SetPoint("TOPLEFT", frame.detailScrollChild, "TOPLEFT", 5, -5)
    frame.detailContentText:SetWidth(610)
    frame.detailContentText:SetJustifyH("LEFT")
    frame.detailContentText:SetJustifyV("TOP")
    frame.detailContentText:SetSpacing(3)

    -- Container for loot item buttons (used when showing loot)
    frame.detailLootContainer = CreateFrame("Frame", nil, frame.detailScrollChild)
    frame.detailLootContainer:SetPoint("TOPLEFT", frame.detailScrollChild, "TOPLEFT", 5, -5)
    frame.detailLootContainer:SetSize(610, 1)
    frame.detailLootContainer:Hide()

    frame.lootButtons = {}

    -- Container for map display (used when showing map)
    frame.detailMapContainer = CreateFrame("Frame", nil, frame.detailScrollChild)
    frame.detailMapContainer:SetPoint("TOPLEFT", frame.detailScrollChild, "TOPLEFT", 5, -5)
    frame.detailMapContainer:SetSize(610, 400)
    frame.detailMapContainer:Hide()

    -- Map texture
    frame.detailMapTexture = frame.detailMapContainer:CreateTexture(nil, "ARTWORK")
    frame.detailMapTexture:SetPoint("TOP", frame.detailMapContainer, "TOP", 0, 0)
    frame.detailMapTexture:SetSize(512, 512)

    -- Map info text
    frame.detailMapInfo = frame.detailMapContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.detailMapInfo:SetPoint("TOPLEFT", frame.detailMapTexture, "BOTTOMLEFT", 0, -10)
    frame.detailMapInfo:SetWidth(610)
    frame.detailMapInfo:SetJustifyH("LEFT")

    -- Methods (wrapped to preserve correct self reference)
    frame.Refresh = function() Addon:RefreshMainFrame() end
    frame.RefreshHeader = function() Addon:RefreshHeader() end
    frame.RefreshRecommendation = function() Addon:RefreshRecommendation() end
    frame.RefreshDungeonList = function() Addon:RefreshDungeonList() end
    frame.RefreshFactions = function() Addon:RefreshFactions() end

    -- Initialize optimization mode buttons
    frame:RefreshOptModeButtons()

    -- Register for item info events to refresh loot display when items finish loading
    frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    frame:SetScript("OnEvent", function(self, event, itemID, success)
        if event == "GET_ITEM_INFO_RECEIVED" and success then
            -- Only refresh if we're in detail view showing loot tab
            if Addon.MainFrame and Addon.MainFrame.navigationView == "detail" and Addon.MainFrame.currentTab == "Loot" then
                C_Timer.After(0.1, function()
                    if Addon and Addon.ShowLootTab then
                        Addon:ShowLootTab()
                    end
                end)
            end
        end
    end)

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

    if viewMode == "heroics" then
        -- Show heroic dungeons (all TBC dungeons have heroic versions)
        if not DST.DungeonData then return end

        local playerLevel = UnitLevel("player")
        local orderedDungeons = DST.DungeonData:GetOrderedDungeons()

        for i, dungeonEntry in ipairs(orderedDungeons) do
            local name = dungeonEntry.name
            local data = dungeonEntry.data

            local card = DST.DungeonCard:Create(frame.scrollChild, 620)
            card:SetPoint("TOPLEFT", frame.scrollChild, "TOPLEFT", 0, yOffset)

            -- Determine heroic status
            local status = "LOCKED"
            local statusText = "Requires Level 70"
            local factionStanding = "N/A"

            if playerLevel >= 70 then
                -- Check faction reputation for key
                local factionID = data.factionID
                if factionID then
                    local factionName, _, standingID = GetFactionInfoByID(factionID)
                    -- Revered = 7, Exalted = 8
                    if standingID and standingID >= 7 then
                        status = "AVAILABLE"
                        statusText = "Heroic - Key Obtained"
                        factionStanding = (standingID == 8) and "Exalted" or "Revered"
                    else
                        status = "LOCKED"
                        statusText = "Requires Revered with " .. data.faction
                        factionStanding = self.Tracker and self.Tracker:GetFactionStanding(factionID) or "Unknown"
                    end
                else
                    -- No faction requirement (shouldn't happen for TBC dungeons)
                    status = "AVAILABLE"
                    statusText = "Heroic"
                end
            elseif playerLevel >= 68 then
                statusText = "Almost Ready (2-3 levels)"
            end

            -- Create heroic status
            local heroicStatus = {
                name = name,
                data = data,
                status = status,
                statusText = statusText,
                isRecommended = false,
                isHeroic = true,
                runsCompleted = 0, -- Could track heroic runs separately
                runsToRepCap = 0,
                runsToLevel = 0,
                factionRep = 0,
                factionStanding = factionStanding,
            }

            card:SetDungeon(name, data, heroicStatus)
            table.insert(frame.dungeonCards, card)
            card:Show()

            yOffset = yOffset - 55
        end
    elseif viewMode == "raids" then
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

-- Show detail view for a dungeon or raid
function Addon:ShowDetailView(dungeonName, dungeonData, isHeroic)
    if not self.MainFrame then return end

    local frame = self.MainFrame
    frame.navigationView = "detail"

    -- Store current dungeon/raid info
    frame.currentDungeon = dungeonName
    frame.currentData = dungeonData
    frame.isHeroic = isHeroic or false

    -- Determine if this is a raid (raids have 'size' field, dungeons have 'minLevel')
    frame.isRaid = (dungeonData.size ~= nil)

    -- Hide list view elements
    frame.recPanel:Hide()
    frame.listHeader:Hide()
    frame.scrollFrame:Hide()
    frame.factionPanel:Hide()
    frame.optModeLabel:Hide()
    for _, btn in ipairs(frame.optModeButtons) do
        btn:Hide()
    end
    frame.factionLabel:Hide()
    frame.factionDropdown:Hide()
    frame.dungeonsButton:Hide()
    frame.heroicsButton:Hide()
    frame.raidsButton:Hide()

    -- Show back button and detail container
    frame.backButton:Show()
    frame.detailContainer:Show()

    -- Hide world map button in detail view
    if frame.worldMapButton then
        frame.worldMapButton:Hide()
    end

    -- Update detail view content
    local displayName = dungeonName
    if isHeroic then
        displayName = "|cffff8800HEROIC:|r " .. displayName
    elseif frame.isRaid then
        displayName = "|cffff00ff[RAID]|r " .. displayName
    end
    frame.detailContainer.dungeonName:SetText("|cff00ff80" .. displayName .. "|r")

    -- Set stats based on whether it's a dungeon or raid
    local statsText
    if frame.isRaid then
        -- Raid stats
        local raidSize = dungeonData.size or 25
        local attunement = dungeonData.attunement or "None"
        statsText = string.format(
            "Size: |cffffffff%d-man|r  |  Level: |cffffffff%d|r  |  Attunement: |cffffffff%s|r",
            raidSize,
            dungeonData.minLevel or 70,
            attunement
        )
    else
        -- Dungeon stats
        local levelText
        if frame.isHeroic then
            levelText = "70"
        else
            levelText = string.format("%d-%d", dungeonData.minLevel, dungeonData.maxLevel)
        end
        statsText = string.format(
            "Level: |cffffffff%s|r  |  Duration: |cffffffff~%d min|r  |  Faction: |cffffffff%s|r  |  Rep/run: |cffffffff%d|r",
            levelText,
            dungeonData.avgDuration,
            dungeonData.faction,
            dungeonData.repPerRun
        )
    end
    frame.detailContainer.dungeonStats:SetText(statsText)

    -- Select default tab (Loot for raids, Bosses is more useful)
    if frame.isRaid then
        self:SelectDetailTab("Bosses")
    else
        self:SelectDetailTab("Loot")
    end
end

-- Show list view (back from detail)
function Addon:ShowListView()
    if not self.MainFrame then return end

    local frame = self.MainFrame
    frame.navigationView = "list"

    -- Show list view elements
    frame.recPanel:Show()
    frame.listHeader:Show()
    frame.scrollFrame:Show()
    frame.factionPanel:Show()

    -- Show appropriate view mode button
    if frame.viewMode == "dungeons" then
        frame.optModeLabel:Show()
        frame:RefreshOptModeButtons()
        for _, btn in ipairs(frame.optModeButtons) do
            btn:Show()
        end
        frame.heroicsButton:Show()
    elseif frame.viewMode == "heroics" then
        frame.raidsButton:Show()
    elseif frame.viewMode == "raids" then
        frame.dungeonsButton:Show()
    end

    -- Hide back button and detail container
    frame.backButton:Hide()
    frame.detailContainer:Hide()

    -- Hide world map container if it exists
    if frame.worldMapContainer then
        frame.worldMapContainer:Hide()
    end

    -- Show world map button
    if frame.worldMapButton then
        frame.worldMapButton:Show()
    end

    -- Clear current dungeon
    frame.currentDungeon = nil
    frame.currentData = nil
    frame.isHeroic = nil
end

-- Select detail tab
function Addon:SelectDetailTab(tabName)
    if not self.MainFrame or not self.MainFrame.detailContainer then return end

    local frame = self.MainFrame
    frame.currentTab = tabName

    -- Update tab appearance
    for _, tab in ipairs(frame.detailContainer.tabs) do
        if tab.tabName == tabName then
            tab:SetBackdropColor(0.2, 0.6, 0.3, 0.9)
            tab:SetBackdropBorderColor(0, 1, 0, 1)
        else
            tab:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
            tab:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        end
    end

    -- Update content
    if tabName == "Loot" then
        self:ShowLootTab()
    elseif tabName == "Bosses" then
        self:ShowBossesTab()
    elseif tabName == "Map" then
        self:ShowMapTab()
    elseif tabName == "Location" then
        self:ShowLocationTab()
    end

    -- Reset scroll
    frame.detailScrollFrame:SetVerticalScroll(0)
end

-- Show loot tab
function Addon:ShowLootTab()
    if not self.MainFrame or not self.MainFrame.currentDungeon then return end

    local frame = self.MainFrame

    -- Hide text content, show loot container
    frame.detailContentText:Hide()
    frame.detailLootContainer:Show()
    frame.detailScrollFrame:Show()

    -- Hide map texture and container
    if frame.mapTextureFrame then
        frame.mapTextureFrame:Hide()
    end
    frame.detailMapContainer:Hide()

    -- Clear existing loot buttons
    for _, btn in ipairs(frame.lootButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    wipe(frame.lootButtons)

    -- Get loot data for dungeon or raid
    local lootData
    if frame.isRaid then
        lootData = DST.LootData and DST.LootData:GetRaidLoot(frame.currentDungeon)
    else
        lootData = DST.LootData and DST.LootData:GetDungeonLoot(frame.currentDungeon)
    end
    local yOffset = 0

    if lootData and lootData.bosses then
        for bossIndex, boss in ipairs(lootData.bosses) do
            -- Boss name header
            local bossHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            bossHeader:SetParent(frame.detailLootContainer)
            bossHeader:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 0, yOffset)
            bossHeader:SetText(string.format("|cff00ff80%s|r", boss.name))
            table.insert(frame.lootButtons, bossHeader)
            yOffset = yOffset - 20

            if boss.items then
                -- For raids, items is a direct array; for dungeons, it's {normal: [], heroic: []}
                local itemList
                if frame.isRaid then
                    itemList = boss.items
                else
                    itemList = frame.isHeroic and boss.items.heroic or boss.items.normal
                end

                if itemList and #itemList > 0 then
                    local col = 0
                    local rowOffset = yOffset

                    for itemIndex, itemID in ipairs(itemList) do
                        -- Create clickable item button
                        local itemBtn = CreateFrame("Button", nil, frame.detailLootContainer)
                        itemBtn:SetSize(280, 18)

                        if col == 0 then
                            itemBtn:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 10, rowOffset)
                        else
                            itemBtn:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 320, rowOffset)
                        end

                        -- Item icon
                        itemBtn.icon = itemBtn:CreateTexture(nil, "ARTWORK")
                        itemBtn.icon:SetSize(16, 16)
                        itemBtn.icon:SetPoint("LEFT", itemBtn, "LEFT", 0, 0)

                        -- Item text
                        itemBtn.text = itemBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        itemBtn.text:SetPoint("LEFT", itemBtn.icon, "RIGHT", 3, 0)
                        itemBtn.text:SetJustifyH("LEFT")
                        itemBtn.text:SetWidth(210)

                        -- Drop rate text (right aligned)
                        itemBtn.dropRate = itemBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        itemBtn.dropRate:SetPoint("RIGHT", itemBtn, "RIGHT", 0, 0)
                        itemBtn.dropRate:SetJustifyH("RIGHT")
                        itemBtn.dropRate:SetTextColor(0.7, 0.7, 0.7, 1)

                        -- Request item info
                        local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType,
                              itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemID)

                        if itemLink then
                            -- Set item icon
                            if itemTexture then
                                itemBtn.icon:SetTexture(itemTexture)
                            else
                                -- Fallback icon if texture not available
                                itemBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                            end

                            -- Get quality color
                            local r, g, b = GetItemQualityColor(itemQuality or 1)
                            itemBtn.text:SetTextColor(r, g, b, 1)
                            itemBtn.text:SetText(itemName or "Item " .. itemID)
                            itemBtn.itemLink = itemLink

                            -- Get drop rate if available from boss data
                            local dropRate = boss.dropRates and boss.dropRates[itemID]
                            if dropRate then
                                itemBtn.dropRate:SetText(string.format("%.1f%%", dropRate))
                            else
                                -- Hide drop rate if no data available
                                itemBtn.dropRate:SetText("")
                            end
                        else
                            -- Set loading icon
                            itemBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                            itemBtn.text:SetTextColor(0.67, 0.67, 0.67, 1)
                            itemBtn.text:SetText("[Loading...]")
                            itemBtn.itemID = itemID
                            C_Item.RequestLoadItemDataByID(itemID)
                        end

                        -- Click to link item in chat
                        itemBtn:SetScript("OnClick", function(self)
                            if self.itemLink then
                                -- Use WoW's built-in handler for shift-click to link, ctrl-click for dressing room, etc.
                                HandleModifiedItemClick(self.itemLink)
                            end
                        end)

                        -- Hover to show tooltip
                        itemBtn:SetScript("OnEnter", function(self)
                            if self.itemLink or self.itemID then
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                                if self.itemLink then
                                    GameTooltip:SetHyperlink(self.itemLink)
                                else
                                    GameTooltip:SetItemByID(self.itemID)
                                end
                                GameTooltip:Show()
                            end
                        end)

                        itemBtn:SetScript("OnLeave", function(self)
                            GameTooltip:Hide()
                        end)

                        table.insert(frame.lootButtons, itemBtn)

                        -- Two columns layout
                        col = col + 1
                        if col >= 2 then
                            col = 0
                            rowOffset = rowOffset - 20
                        end
                    end

                    -- Adjust offset for next boss
                    if col > 0 then
                        rowOffset = rowOffset - 20
                    end
                    yOffset = rowOffset - 10
                else
                    local noItems = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    noItems:SetParent(frame.detailLootContainer)
                    noItems:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 10, yOffset)
                    noItems:SetText("|cffaaaaaa(No items for this difficulty)|r")
                    table.insert(frame.lootButtons, noItems)
                    yOffset = yOffset - 20
                end
            else
                -- For raids, use itemCount; for dungeons, use normal/heroic
                local count
                if frame.isRaid then
                    count = boss.itemCount or 0
                else
                    count = frame.isHeroic and (boss.heroic or 0) or (boss.normal or 0)
                end
                local countText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                countText:SetParent(frame.detailLootContainer)
                countText:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 10, yOffset)
                countText:SetText(string.format("|cffffffff%d items|r |cffaaaaaa(detailed item data not yet added)|r", count))
                table.insert(frame.lootButtons, countText)
                yOffset = yOffset - 20
            end

            yOffset = yOffset - 5
        end

        -- Add help text at bottom
        local helpText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        helpText:SetParent(frame.detailLootContainer)
        helpText:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 0, yOffset - 10)
        helpText:SetText("|cffaaaaaa* Hover over items to see stats\n* Shift-click to link in chat|r")
        table.insert(frame.lootButtons, helpText)
        yOffset = yOffset - 40
    else
        local noData = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noData:SetParent(frame.detailLootContainer)
        noData:SetPoint("TOPLEFT", frame.detailLootContainer, "TOPLEFT", 0, yOffset)
        noData:SetText("|cffff9900No loot information available.|r")
        table.insert(frame.lootButtons, noData)
        yOffset = yOffset - 30
    end

    frame.detailScrollChild:SetHeight(math.max(math.abs(yOffset) + 20, frame.detailScrollFrame:GetHeight()))
end

-- Show bosses tab
function Addon:ShowBossesTab()
    if not self.MainFrame or not self.MainFrame.currentDungeon then return end

    local frame = self.MainFrame

    -- Show text content, hide loot container
    frame.detailContentText:Show()
    frame.detailLootContainer:Hide()
    frame.detailScrollFrame:Show()

    -- Hide map texture and container
    if frame.mapTextureFrame then
        frame.mapTextureFrame:Hide()
    end
    frame.detailMapContainer:Hide()

    local modeText
    if frame.isRaid then
        modeText = "|cffff00ff25-Man Raid|r"
        -- Check if it's a 10-man raid
        if frame.currentData and frame.currentData.size == 10 then
            modeText = "|cffff00ff10-Man Raid|r"
        end
    else
        modeText = frame.isHeroic and "|cffff8800Heroic Mode|r" or "|cff00ff80Normal Mode|r"
    end
    local text = "|cffffd700=== Boss Overview (" .. modeText .. ") ===|r\n\n"

    -- Try to get boss data from BossData.lua
    local bossData
    if frame.isRaid then
        bossData = DST.BossData and DST.BossData:GetRaidBossesDetailed(frame.currentDungeon)
    else
        bossData = DST.BossData and DST.BossData:GetDungeonBosses(frame.currentDungeon)
    end

    if bossData and next(bossData) then
        -- Use BossData for detailed boss information
        local bossIndex = 1
        for bossName, data in pairs(bossData) do
            text = text .. string.format("|cff00ff80%d. %s|r\n", bossIndex, bossName)

            -- Health (raids only have normal mode)
            if data.health then
                local health = (not frame.isRaid and frame.isHeroic) and data.health.heroic or data.health.normal
                if health then
                    text = text .. string.format("   |cffffffffHealth:|r %s\n", health)
                end
            end

            -- Mana
            if data.mana then
                local mana = (not frame.isRaid and frame.isHeroic) and data.mana.heroic or data.mana.normal
                if mana then
                    text = text .. string.format("   |cffffffffMana:|r %s\n", mana)
                end
            end

            -- Abilities
            if data.abilities and #data.abilities > 0 then
                text = text .. "\n   |cffffd700Abilities:|r\n"
                for _, ability in ipairs(data.abilities) do
                    text = text .. string.format("   • |cff00ccff%s:|r %s\n", ability.name, ability.desc)
                end
            end

            -- Adds
            if data.adds then
                text = text .. string.format("\n   |cffff9900Adds:|r %s\n", data.adds)
            end

            -- Notes
            if data.notes then
                text = text .. string.format("\n   |cffaaffaa⚡ Strategy:|r %s\n", data.notes)
            end

            text = text .. "\n"
            bossIndex = bossIndex + 1
        end
    else
        -- Fallback to loot data for boss list
        local lootData = DST.LootData and DST.LootData:GetDungeonLoot(frame.currentDungeon)

        if lootData and lootData.bosses then
            text = text .. "|cffff9900Boss stats not yet available for this dungeon.|r\n\n"
            text = text .. "|cffffffffBoss Encounters:|r\n\n"
            for i, boss in ipairs(lootData.bosses) do
                text = text .. string.format("|cff00ff80%d. %s|r\n", i, boss.name)
            end
        elseif frame.currentData and frame.currentData.guide then
            text = text .. "|cffffffffBoss encounters:|r\n\n"
            for i, line in ipairs(frame.currentData.guide) do
                if line:match("^Boss %d") or line:match("%):") then
                    text = text .. "|cff00ff80" .. line .. "|r\n\n"
                else
                    text = text .. line .. "\n"
                end
            end
        else
            text = text .. "|cffff9900No boss information available.|r"
        end
    end

    frame.detailContentText:SetText(text)
    frame.detailScrollChild:SetHeight(math.max(frame.detailContentText:GetStringHeight() + 20, frame.detailScrollFrame:GetHeight()))
end

-- Show strategy tab
function Addon:ShowStrategyTab()
    if not self.MainFrame or not self.MainFrame.currentData then return end

    local frame = self.MainFrame

    -- Show text content, hide loot container
    frame.detailContentText:Show()
    frame.detailLootContainer:Hide()

    -- Hide map container
    frame.detailMapContainer:Hide()

    local data = frame.currentData

    if not data.guide or #data.guide == 0 then
        frame.detailContentText:SetText("|cffff9900No strategy guide available.|r")
        frame.detailScrollChild:SetHeight(50)
        return
    end

    local text = "|cffffd700=== Dungeon Strategy Guide ===|r\n\n"
    text = text .. "|cffffffffLocation:|r " .. (data.entrance or data.zone) .. "\n\n"
    text = text .. "|cffffd700Boss Strategies:|r\n\n"

    for i, line in ipairs(data.guide) do
        if line:match("^Boss %d") or line:match("%):") or line:match("^%w+ %d+:") then
            text = text .. "|cff00ff80" .. line .. "|r\n"
        else
            text = text .. "   " .. line .. "\n"
        end
    end

    if data.requiredFor and #data.requiredFor > 0 then
        text = text .. "\n|cffffd700Important for:|r\n"
        for _, req in ipairs(data.requiredFor) do
            text = text .. "   • " .. req .. "\n"
        end
    end

    frame.detailContentText:SetText(text)
    frame.detailScrollChild:SetHeight(math.max(frame.detailContentText:GetStringHeight() + 20, frame.detailScrollFrame:GetHeight()))
end

-- Show map tab
function Addon:ShowMapTab()
    if not self.MainFrame or not self.MainFrame.currentDungeon then return end

    local frame = self.MainFrame

    -- Hide text content and loot container, we'll use the map texture
    frame.detailContentText:Hide()
    frame.detailLootContainer:Hide()
    frame.detailScrollFrame:Hide()
    frame.detailMapContainer:Hide()

    -- Create map texture frame if it doesn't exist (parent to detailContainer, not scrollChild)
    if not frame.mapTextureFrame then
        frame.mapTextureFrame = CreateFrame("Frame", nil, frame.detailContainer)
        frame.mapTextureFrame:SetPoint("CENTER", frame.detailContainer, "CENTER", 0, -50)
        frame.mapTextureFrame:SetSize(500, 400)

        -- Map texture (dungeon maps are 1002x668, so use 450x300 to maintain aspect ratio)
        frame.mapTextureFrame.texture = frame.mapTextureFrame:CreateTexture(nil, "ARTWORK")
        frame.mapTextureFrame.texture:SetPoint("CENTER")
        frame.mapTextureFrame.texture:SetSize(450, 300)
        frame.mapTextureFrame.texture:SetTexCoord(0, 1, 0, 1)  -- Reset texture coordinates
        frame.mapTextureFrame.texture:SetBlendMode("BLEND")     -- Set blend mode

        -- Info text below map
        frame.mapTextureFrame.infoText = frame.mapTextureFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        frame.mapTextureFrame.infoText:SetPoint("TOP", frame.mapTextureFrame.texture, "BOTTOM", 0, -10)
        frame.mapTextureFrame.infoText:SetWidth(450)
        frame.mapTextureFrame.infoText:SetJustifyH("CENTER")
    end

    frame.mapTextureFrame:Show()

    -- Check if it's a raid with an image first
    local mapPath
    if frame.isRaid and frame.currentData and frame.currentData.image then
        mapPath = "Interface\\AddOns\\DJDungeonSpamGuide\\" .. frame.currentData.image
    else
        -- Try to load dungeon map texture
        mapPath = self:GetDungeonMapTexture(frame.currentDungeon)
    end

    if mapPath then
        frame.mapTextureFrame.texture:SetTexture(mapPath)
        frame.mapTextureFrame.texture:SetTexCoord(0, 1, 0, 1)  -- Reset coords each time
        frame.mapTextureFrame.texture:Show()
        frame.mapTextureFrame.infoText:SetText("|cff00ff80" .. frame.currentDungeon .. " Map|r")
    else
        -- Show placeholder
        frame.mapTextureFrame.texture:Hide()
        frame.mapTextureFrame.infoText:SetText("|cffff9900Map texture not available\n|cffffffffUse in-game map (M) to view dungeon layout|r")
    end
end

-- Get dungeon map texture path
function Addon:GetDungeonMapTexture(dungeonName)
    -- Map of dungeon names to our downloaded texture files
    local mapTextures = {
        -- TBC Dungeons - using our downloaded maps from Textures folder (uncompressed TGA)
        ["Hellfire Ramparts"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\HellfireRamparts_Map",
        ["Blood Furnace"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\BloodFurnace_Map",
        ["Slave Pens"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\SlavePens_Map",
        ["Underbog"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Underbog_Map",
        ["Mana-Tombs"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Mana-Tombs_Map",
        ["Auchenai Crypts"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\AuchenaiCrypts_Map",
        ["Sethekk Halls"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\SethekkHalls_Map",
        ["Shadow Labyrinth"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\ShadowLabyrinth_Map",
        ["Steamvault"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Steamvault_Map",
        ["Botanica"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Botanica_Map",
        ["Mechanar"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Mechanar_Map",
        ["Arcatraz"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Arcatraz_Map",
        ["Old Hillsbrad"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\OldHillsbrad_Map",
        ["Black Morass"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\BlackMorass_Map",
        ["Shattered Halls"] = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\ShatteredHalls_Map",
    }

    return mapTextures[dungeonName]
end

-- Show World Map view (Outland dungeon locations)
function Addon:ShowWorldMapView()
    if not self.MainFrame then return end

    local frame = self.MainFrame
    frame.navigationView = "worldmap"

    -- Hide list view elements
    frame.recPanel:Hide()
    frame.listHeader:Hide()
    frame.scrollFrame:Hide()
    frame.factionPanel:Hide()

    -- Hide all view mode buttons
    if frame.optModeLabel then frame.optModeLabel:Hide() end
    for _, btn in ipairs(frame.optModeButtons or {}) do
        btn:Hide()
    end
    frame.heroicsButton:Hide()
    frame.raidsButton:Hide()
    frame.dungeonsButton:Hide()

    -- Show back button
    frame.backButton:Show()

    -- Hide detail container (using scroll frame for map instead)
    if frame.detailContainer then
        frame.detailContainer:Hide()
    end

    -- Hide world map button when in world map view
    frame.worldMapButton:Hide()

    -- Create or show world map container
    if not frame.worldMapContainer then
        frame.worldMapContainer = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
        frame.worldMapContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -65)
        frame.worldMapContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -15, 15)
        frame.worldMapContainer:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = {left = 4, right = 4, top = 4, bottom = 4}
        })
        frame.worldMapContainer:SetBackdropColor(0, 0, 0, 0.8)
        frame.worldMapContainer:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

        -- Title
        frame.worldMapContainer.title = frame.worldMapContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        frame.worldMapContainer.title:SetPoint("TOP", 0, -10)
        frame.worldMapContainer.title:SetText("|cffffd700TBC Outland Dungeon Locations|r")

        -- Map texture
        frame.worldMapContainer.texture = frame.worldMapContainer:CreateTexture(nil, "ARTWORK")
        frame.worldMapContainer.texture:SetPoint("CENTER", 0, -10)
        frame.worldMapContainer.texture:SetSize(600, 400)

        -- Info text
        frame.worldMapContainer.infoText = frame.worldMapContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        frame.worldMapContainer.infoText:SetPoint("BOTTOM", 0, 10)
        frame.worldMapContainer.infoText:SetWidth(600)
        frame.worldMapContainer.infoText:SetJustifyH("CENTER")
    end

    frame.worldMapContainer:Show()

    -- Load Outland dungeon locations map
    local mapPath = "Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\Outland_DungeonMap"
    if frame.worldMapContainer.texture:SetTexture(mapPath) then
        frame.worldMapContainer.texture:Show()
        frame.worldMapContainer.infoText:SetText("|cff00ff80Outland Dungeon Locations Map|r")
    else
        frame.worldMapContainer.texture:Hide()
        frame.worldMapContainer.infoText:SetText("|cffff9900Map texture not available|r")
    end
end

-- Show location tab
function Addon:ShowLocationTab()
    if not self.MainFrame or not self.MainFrame.currentData then return end

    local frame = self.MainFrame

    -- Show text content, hide loot container
    frame.detailContentText:Show()
    frame.detailLootContainer:Hide()
    frame.detailScrollFrame:Show()

    -- Hide map texture if it exists
    if frame.mapTextureFrame then
        frame.mapTextureFrame:Hide()
    end

    -- Hide map container on location tab
    frame.detailMapContainer:Hide()

    local data = frame.currentData

    local text = "|cffffd700=== Location & Entrance ===|r\n\n"

    if frame.isRaid then
        -- Raid location information
        text = text .. "|cffffffffLocation:|r |cff00ff80" .. (data.location or "Unknown") .. "|r\n\n"

        text = text .. "|cffffd700Raid Information:|r\n"
        text = text .. string.format("   Size: |cffffffff%d-man raid|r\n", data.size or 25)
        text = text .. string.format("   Level Requirement: |cffffffff%d|r\n", data.minLevel or 70)
        text = text .. "\n"

        text = text .. "|cffffd700Attunement:|r\n"
        text = text .. "   " .. (data.attunement or "None") .. "\n\n"

        if data.bosses and #data.bosses > 0 then
            text = text .. "|cffffd700Boss Encounters:|r\n"
            for _, bossName in ipairs(data.bosses) do
                text = text .. "   • " .. bossName .. "\n"
            end
            text = text .. "\n"
        end

        if data.guide and #data.guide > 0 then
            text = text .. "|cffffd700Strategy Overview:|r\n"
            for _, line in ipairs(data.guide) do
                text = text .. "   • " .. line .. "\n"
            end
        end
    else
        -- Dungeon location information
        text = text .. "|cffffffffZone:|r |cff00ff80" .. (data.zone or "Unknown") .. "|r\n"
        text = text .. "|cffffffffEntrance:|r " .. (data.entrance or data.zone or "Unknown") .. "\n\n"

        text = text .. "|cffffd700Requirements:|r\n"
        if frame.isHeroic then
            text = text .. "   Level: |cffffffff70|r |cffff8800(Heroic)|r\n"
            text = text .. string.format("   Faction Key: |cffffffff%s (Revered)|r\n", data.faction)
        else
            text = text .. string.format("   Level: |cffffffff%d-%d|r\n", data.minLevel, data.maxLevel)
        end
        text = text .. "\n"

        text = text .. "|cffffd700Dungeon Information:|r\n"
        text = text .. string.format("   Average Duration: |cffffffff~%d minutes|r\n", data.avgDuration or 25)
        text = text .. string.format("   Associated Faction: |cffffffff%s|r\n", data.faction)

        if data.requiredFor and #data.requiredFor > 0 then
            text = text .. "\n|cffffd700Important For:|r\n"
            for _, requirement in ipairs(data.requiredFor) do
                text = text .. "   • " .. requirement .. "\n"
            end
        end

        text = text .. "\n|cffffd700Reputation Gain:|r\n"
        text = text .. string.format("   Per Run: |cffffffff%d rep|r\n", data.repPerRun or 0)
        text = text .. string.format("   Cap: |cffffffff%s (%d rep)|r\n", data.repCap or "Unknown", data.repCapValue or 0)

        if frame.isHeroic then
            text = text .. "\n|cffaaaaaa* Heroic mode grants reputation beyond normal cap\n* Heroic keys obtained at Revered reputation\n* Daily quest available for additional rewards|r"
        end
    end

    frame.detailContentText:SetText(text)
    frame.detailScrollChild:SetHeight(math.max(frame.detailContentText:GetStringHeight() + 20, frame.detailScrollFrame:GetHeight()))
end
