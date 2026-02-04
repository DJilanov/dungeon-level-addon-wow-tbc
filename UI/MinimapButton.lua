-- Dungeon Spam Tracker - Minimap Button
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L

-- Minimap Button
DST.MinimapButton = {}
local MinimapButton = DST.MinimapButton

-- Create the minimap button
function MinimapButton:Create()
    if Addon.MinimapButton then return Addon.MinimapButton end

    -- Create button
    local button = CreateFrame("Button", "DJDungeonSpamGuideMinimapButton", Minimap)
    button:SetSize(32, 32)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetMovable(true)

    -- Icon texture
    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetSize(20, 20)
    button.icon:SetPoint("CENTER", 0, 1)
    button.icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")

    -- Border/ring
    button.border = button:CreateTexture(nil, "OVERLAY")
    button.border:SetSize(52, 52)
    button.border:SetPoint("TOPLEFT", 0, 0)
    button.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    -- Highlight
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    -- Position (default angle)
    button.angle = 220
    self:UpdatePosition(button)

    -- Click handler
    button:SetScript("OnClick", function(self, btn)
        if btn == "LeftButton" then
            MinimapButton:OnClick()
        elseif btn == "RightButton" then
            MinimapButton:OnRightClick()
        end
    end)

    -- Drag handlers
    button:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", MinimapButton.OnUpdate)
    end)

    button:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
        MinimapButton:SavePosition(self)
    end)

    -- Tooltip
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("|cff00ff00DJ Dungeon Spam Guide|r", 1, 1, 1)
        GameTooltip:AddLine("Left-click to open/close", 1, 1, 1)
        GameTooltip:AddLine("Right-click for options", 1, 1, 1)
        GameTooltip:AddLine("Drag to move", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    Addon.MinimapButton = button
    return button
end

-- Update button position based on angle
function MinimapButton:UpdatePosition(button)
    local angle = button.angle or 220
    local x, y
    local radius = 80

    x = math.cos(angle) * radius
    y = math.sin(angle) * radius

    button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

-- On drag update
function MinimapButton.OnUpdate(self)
    local mx, my = Minimap:GetCenter()
    local px, py = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()

    px, py = px / scale, py / scale

    local angle = math.atan2(py - my, px - mx)
    self.angle = angle

    MinimapButton:UpdatePosition(self)
end

-- Save position
function MinimapButton:SavePosition(button)
    if Addon.profile then
        Addon.profile.minimapButtonAngle = button.angle
    end
end

-- Load position
function MinimapButton:LoadPosition(button)
    if Addon.profile and Addon.profile.minimapButtonAngle then
        button.angle = Addon.profile.minimapButtonAngle
        self:UpdatePosition(button)
    end
end

-- Left click handler
function MinimapButton:OnClick()
    -- Create MainFrame if it doesn't exist
    if not Addon.MainFrame then
        Addon:CreateMainFrame()
    end

    if Addon.MainFrame then
        if Addon.MainFrame:IsShown() then
            Addon.MainFrame:Hide()
        else
            Addon.MainFrame:Show()
            if Addon.MainFrame.Refresh then
                Addon.MainFrame:Refresh()
            end
        end
    end
end

-- Right click handler
function MinimapButton:OnRightClick()
    -- Future: Add options menu
    MinimapButton:OnClick()
end

-- Show/hide minimap button
function MinimapButton:Show()
    if Addon.MinimapButton then
        Addon.MinimapButton:Show()
    end
end

function MinimapButton:Hide()
    if Addon.MinimapButton then
        Addon.MinimapButton:Hide()
    end
end

-- Initialize minimap button
function MinimapButton:Init()
    local button = self:Create()

    -- Load saved position
    self:LoadPosition(button)

    -- Show/hide based on settings
    if Addon:GetSetting("showMinimapButton") then
        button:Show()
    else
        button:Hide()
    end
end
