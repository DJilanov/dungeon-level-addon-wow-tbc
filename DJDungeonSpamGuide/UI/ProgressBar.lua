-- Dungeon Spam Tracker - Progress Bar Component
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local C = DST.Constants

-- Progress Bar factory
DST.ProgressBar = {}
local ProgressBar = DST.ProgressBar

-- Create a new progress bar
function ProgressBar:Create(parent, width, height)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(width or 200, height or 20)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:GetStatusBarTexture():SetHorizTile(false)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(0)

    -- Background
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0.1, 0.1, 0.1, 0.8)

    -- Border
    bar.border = CreateFrame("Frame", nil, bar, BackdropTemplateMixin and "BackdropTemplate")
    bar.border:SetAllPoints()
    bar.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = {left = 2, right = 2, top = 2, bottom = 2}
    })
    bar.border:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

    -- Text
    bar.text = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bar.text:SetPoint("CENTER")
    bar.text:SetJustifyH("CENTER")
    bar.text:SetText("")

    -- Methods
    bar.SetProgress = ProgressBar.SetProgress
    bar.SetColor = ProgressBar.SetColor
    bar.SetText = ProgressBar.SetTextCustom
    bar.SetMaxValue = ProgressBar.SetMaxValue

    return bar
end

-- Set progress (0-100 or current/max)
function ProgressBar:SetProgress(current, max)
    if max then
        self:SetMinMaxValues(0, max)
        self:SetValue(current)
    else
        self:SetMinMaxValues(0, 100)
        self:SetValue(current)
    end
end

-- Set color
function ProgressBar:SetColor(r, g, b, a)
    self:SetStatusBarColor(r, g, b, a or 1)
end

-- Set text
function ProgressBar:SetTextCustom(text)
    self.text:SetText(text or "")
end

-- Set max value
function ProgressBar:SetMaxValue(max)
    local _, currentMax = self:GetMinMaxValues()
    if currentMax ~= max then
        local current = self:GetValue()
        self:SetMinMaxValues(0, max)
        self:SetValue(current)
    end
end

-- Create reputation progress bar
function ProgressBar:CreateRepBar(parent, factionName, width)
    local bar = self:Create(parent, width or 300, 18)

    -- Store faction info
    bar.factionName = factionName

    -- Update method
    bar.UpdateRep = function(self)
        local tracker = Addon.Tracker
        if not tracker then return end

        local factionData = tracker:GetFactionData(self.factionName)
        if not factionData then return end

        -- Set color based on standing
        local color = C.STANDING_COLORS[factionData.standingID] or {1, 1, 1}
        self:SetColor(color[1], color[2], color[3])

        -- Calculate progress within current standing
        local progress = DST.RepThresholds:GetStandingProgress(factionData.standingID, factionData.currentRep)
        local max = DST.RepThresholds:GetStandingMax(factionData.standingID)

        self:SetProgress(factionData.currentRep, max)

        -- Set text
        local text = string.format("%s: %d/%d %s",
            self.factionName,
            factionData.currentRep,
            max,
            factionData.standingName
        )
        self:SetText(text)
    end

    return bar
end

-- Create XP progress bar
function ProgressBar:CreateXPBar(parent, width)
    local bar = self:Create(parent, width or 400, 20)

    -- Set color for XP
    bar:SetColor(0.5, 0.0, 0.8) -- Purple

    -- Update method
    bar.UpdateXP = function(self)
        local tracker = Addon.Tracker
        if not tracker then return end

        local level = tracker.playerLevel
        local currentXP = tracker.playerXP
        local maxXP = tracker.playerXPMax

        if level >= 70 then
            self:SetProgress(100)
            self:SetText("Level 70 (Max)")
            self:SetColor(0.0, 1.0, 0.0) -- Green for max level
        else
            self:SetProgress(currentXP, maxXP)

            local percent = maxXP > 0 and (currentXP / maxXP * 100) or 0
            local text = string.format("Level %d: %s / %s (%.1f%%)",
                level,
                self:FormatNumber(currentXP),
                self:FormatNumber(maxXP),
                percent
            )
            self:SetText(text)
        end
    end

    -- Format number with commas
    bar.FormatNumber = function(self, num)
        local formatted = tostring(num)
        local k
        while true do
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
            if k == 0 then break end
        end
        return formatted
    end

    return bar
end

-- Create simple percentage bar
function ProgressBar:CreatePercentBar(parent, width, height)
    local bar = self:Create(parent, width or 150, height or 16)

    bar.SetPercent = function(self, percent, text)
        self:SetProgress(percent)
        if text then
            self:SetText(text)
        else
            self:SetText(string.format("%.0f%%", percent))
        end
    end

    return bar
end
