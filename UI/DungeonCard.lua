-- Dungeon Spam Tracker - Dungeon Card Component
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants

-- Dungeon Card factory
DST.DungeonCard = {}
local DungeonCard = DST.DungeonCard

-- Create a dungeon info card
function DungeonCard:Create(parent, width)
    local card = CreateFrame("Button", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
    card:SetSize(width or 540, 50)
    card:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    card:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    card:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

    -- Dungeon name
    card.name = card:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    card.name:SetPoint("TOPLEFT", card, "TOPLEFT", 10, -8)
    card.name:SetJustifyH("LEFT")
    card.name:SetWidth(250)

    -- Status indicator
    card.status = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.status:SetPoint("TOPRIGHT", card, "TOPRIGHT", -10, -8)
    card.status:SetJustifyH("RIGHT")

    -- Faction and rep info
    card.factionInfo = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    card.factionInfo:SetPoint("TOPLEFT", card.name, "BOTTOMLEFT", 0, -4)
    card.factionInfo:SetJustifyH("LEFT")
    card.factionInfo:SetWidth(350)

    -- Stats info
    card.statsInfo = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    card.statsInfo:SetPoint("TOPRIGHT", card.status, "BOTTOMRIGHT", 0, -4)
    card.statsInfo:SetJustifyH("RIGHT")
    card.statsInfo:SetWidth(180)

    -- Make clickable
    card:EnableMouse(true)
    card:RegisterForClicks("LeftButtonUp")

    card:SetScript("OnClick", function(self)
        if self.dungeonName and self.dungeonData then
            local isHeroic = self.statusInfo and self.statusInfo.isHeroic
            local addon = DJDungeonSpamGuide
            if addon and addon.ShowDetailView then
                addon:ShowDetailView(self.dungeonName, self.dungeonData, isHeroic)
            end
        end
    end)

    card:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1, 0.82, 0, 1)
        if self.dungeonName then
            DungeonCard:ShowTooltip(self, self.dungeonName)
        end
    end)
    card:SetScript("OnLeave", function(self)
        local status = self.cardStatus or "AVAILABLE"
        local isTargetFaction = self.statusInfo and self.statusInfo.isTargetFaction
        local isHeroic = self.statusInfo and self.statusInfo.isHeroic

        if status == "COMPLETE" then
            self:SetBackdropBorderColor(0.0, 1.0, 0.0, 1)
        elseif status == "RECOMMENDED" then
            self:SetBackdropBorderColor(0.0, 1.0, 0.5, 1)
        elseif status == "LOCKED" then
            if isHeroic then
                self:SetBackdropBorderColor(0.8, 0.4, 0.0, 1)
            else
                self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
            end
        elseif isTargetFaction and not isHeroic then
            self:SetBackdropBorderColor(0.4, 0.6, 1.0, 1)
        elseif isHeroic then
            self:SetBackdropBorderColor(0.7, 0.3, 0.9, 1)
        else
            self:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        end
        GameTooltip:Hide()
    end)

    -- Methods
    card.SetDungeon = DungeonCard.SetDungeon
    card.UpdateCard = DungeonCard.UpdateCard

    return card
end

-- Set dungeon data
function DungeonCard:SetDungeon(dungeonName, dungeonData, statusInfo)
    self.dungeonName = dungeonName
    self.dungeonData = dungeonData
    self.statusInfo = statusInfo

    self:UpdateCard()
end

-- Update card display
function DungeonCard:UpdateCard()
    if not self.dungeonName or not self.dungeonData then return end

    local data = self.dungeonData
    local status = self.statusInfo

    -- Store status
    self.cardStatus = status.status

    -- Set dungeon name (with HEROIC prefix if applicable)
    local displayName = self.dungeonName
    if status.isHeroic then
        displayName = "|cffff8800HEROIC:|r " .. displayName
    end

    local nameColor = C.COLORS.AVAILABLE
    if status.isRecommended then
        nameColor = C.COLORS.RECOMMENDED
        self:SetBackdropBorderColor(0.0, 1.0, 0.5, 1)
    elseif status.status == "COMPLETE" then
        nameColor = C.COLORS.COMPLETE
        self:SetBackdropBorderColor(0.0, 1.0, 0.0, 1)
    elseif status.status == "LOCKED" then
        nameColor = C.COLORS.LOCKED
        if status.isHeroic then
            -- Orange/red border for locked heroics
            self:SetBackdropBorderColor(0.8, 0.4, 0.0, 1)
        else
            self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
        end
    else
        if status.isHeroic then
            -- Purple border for available heroics
            self:SetBackdropBorderColor(0.7, 0.3, 0.9, 1)
        else
            self:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        end
    end

    -- Highlight target faction dungeons with subtle tint (only for non-heroics)
    if status.isTargetFaction and not status.isHeroic then
        self:SetBackdropColor(0.15, 0.15, 0.25, 0.9)
        -- Add a slight blue tint to border for target faction
        if not status.isRecommended and status.status ~= "COMPLETE" and status.status ~= "LOCKED" then
            self:SetBackdropBorderColor(0.4, 0.6, 1.0, 1)
        end
    elseif status.isHeroic then
        -- Darker background for heroics
        self:SetBackdropColor(0.15, 0.08, 0.15, 0.9)
    else
        self:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    end

    self.name:SetText(string.format("|cff%02x%02x%02x%s|r",
        nameColor[1] * 255,
        nameColor[2] * 255,
        nameColor[3] * 255,
        displayName
    ))

    -- Set status
    local statusText = ""
    if status.isRecommended then
        statusText = "|cff00ff80>> " .. L["RECOMMENDED"] .. " <<|r"
    elseif status.status == "COMPLETE" then
        statusText = "|cff00ff00" .. L["COMPLETE"] .. "|r"
    elseif status.status == "LOCKED" then
        if status.statusText then
            -- Use custom status text for heroics
            statusText = string.format("|cff999999%s|r", status.statusText)
        else
            statusText = string.format("|cff999999%s (Lvl %d)|r", L["LOCKED"], data.minLevel)
        end
    else
        if status.statusText then
            -- Use custom status text (e.g., "Heroic - Key Obtained")
            statusText = string.format("|cffffffff%s|r", status.statusText)
        else
            statusText = string.format("|cffffffff%s|r", L["AVAILABLE"])
        end
    end
    self.status:SetText(statusText)

    -- Set faction info
    local factionText
    local isRaid = (data.size ~= nil) -- Raids have 'size' field (10 or 25), dungeons don't

    if isRaid then
        -- For raids, show size and location instead of faction/rep
        factionText = string.format("%d-man | %s",
            data.size,
            data.location or "Unknown"
        )
    else
        -- For dungeons, show faction and rep info
        factionText = string.format("%s | %s / %s",
            data.faction,
            status.factionStanding or "Unknown",
            data.repCap
        )

        if status.runsCompleted > 0 then
            factionText = factionText .. string.format(" | Runs: %d", status.runsCompleted)
        end

        -- Add rep and exp per run
        factionText = factionText .. string.format(" | Rep: %d  XP: %s",
            data.repPerRun or 0,
            data.expPerRun and string.format("%.1fk", data.expPerRun / 1000) or "0"
        )
    end

    self.factionInfo:SetText(factionText)

    -- Set stats info
    local statsText = ""
    if isRaid then
        -- For raids, show attunement info if available
        if data.attunement and data.attunement ~= "None" then
            statsText = "Attunement: " .. data.attunement
        else
            statsText = "No attunement required"
        end
    else
        -- For dungeons, show rep progress
        if status.runsToRepCap > 0 then
            statsText = string.format("~%d runs to cap", status.runsToRepCap)
        elseif status.status == "COMPLETE" then
            statsText = "Rep Capped"
        end
    end

    self.statsInfo:SetText(statsText)
end

-- Show tooltip
function DungeonCard:ShowTooltip(card, dungeonName)
    local data = DST.DungeonData:GetDungeon(dungeonName)
    if not data then return end

    GameTooltip:SetOwner(card, "ANCHOR_RIGHT")
    GameTooltip:ClearLines()

    -- Title
    GameTooltip:AddLine(dungeonName, 1, 0.82, 0)
    GameTooltip:AddLine(" ")

    -- Stats
    GameTooltip:AddDoubleLine(L["TIME_PER_RUN"], string.format("%d min", data.avgDuration), 1, 1, 1, 1, 1, 1)
    GameTooltip:AddDoubleLine(L["REP_PER_RUN"], tostring(data.repPerRun), 1, 1, 1, 1, 1, 1)
    GameTooltip:AddDoubleLine(L["EXP_PER_RUN"], tostring(data.expPerRun), 1, 1, 1, 1, 1, 1)
    GameTooltip:AddDoubleLine(L["REP_PER_HOUR"], tostring(data.repPerHour), 1, 1, 1, 0.5, 1, 0.5)
    GameTooltip:AddDoubleLine(L["EXP_PER_HOUR"], tostring(data.expPerHour), 1, 1, 1, 0.5, 1, 0.5)

    -- Guide
    if data.guide and #data.guide > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Quick Guide:", 0, 1, 0)
        for _, tip in ipairs(data.guide) do
            GameTooltip:AddLine("  • " .. tip, 1, 1, 1, true)
        end
    end

    -- Required for
    if data.requiredFor and #data.requiredFor > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Required For:", 1, 0.82, 0)
        for _, req in ipairs(data.requiredFor) do
            GameTooltip:AddLine("  • " .. req, 1, 1, 1)
        end
    end

    GameTooltip:Show()
end

-- Create compact dungeon card for list view
function DungeonCard:CreateCompact(parent, width)
    local card = CreateFrame("Button", nil, parent)
    card:SetSize(width or 520, 30)
    card:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

    -- Background
    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints()
    card.bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

    -- Status icon
    card.icon = card:CreateTexture(nil, "ARTWORK")
    card.icon:SetPoint("LEFT", card, "LEFT", 5, 0)
    card.icon:SetSize(16, 16)

    -- Dungeon name
    card.name = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.name:SetPoint("LEFT", card.icon, "RIGHT", 5, 0)
    card.name:SetJustifyH("LEFT")
    card.name:SetWidth(200)

    -- Faction
    card.faction = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    card.faction:SetPoint("LEFT", card.name, "RIGHT", 10, 0)
    card.faction:SetJustifyH("LEFT")
    card.faction:SetWidth(150)

    -- Status text
    card.statusText = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    card.statusText:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    card.statusText:SetJustifyH("RIGHT")

    -- Methods
    card.SetDungeonCompact = DungeonCard.SetDungeonCompact

    return card
end

-- Set dungeon data for compact card
function DungeonCard:SetDungeonCompact(dungeonName, dungeonData, statusInfo)
    self.dungeonName = dungeonName
    self.dungeonData = dungeonData

    local data = dungeonData
    local status = statusInfo

    -- Set icon based on status
    if status.isRecommended then
        self.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
        self.bg:SetColorTexture(0.0, 0.5, 0.2, 0.5)
    elseif status.status == "COMPLETE" then
        self.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
        self.bg:SetColorTexture(0.0, 0.3, 0.0, 0.3)
    elseif status.status == "LOCKED" then
        self.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
        self.bg:SetColorTexture(0.3, 0.3, 0.3, 0.3)
    else
        self.icon:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        self.bg:SetColorTexture(0.1, 0.1, 0.1, 0.3)
    end

    -- Set name
    self.name:SetText(dungeonName)

    -- Set faction
    self.faction:SetText(string.format("%s (%s)", data.faction, status.factionStanding or "?"))

    -- Set status
    local statusText = ""
    if status.status == "COMPLETE" then
        statusText = "|cff00ff00COMPLETE|r"
    elseif status.status == "LOCKED" then
        statusText = string.format("|cff999999Locked (Lvl %d)|r", data.minLevel)
    elseif status.runsToRepCap > 0 then
        statusText = string.format("%d runs to cap", status.runsToRepCap)
    end

    self.statusText:SetText(statusText)
end
