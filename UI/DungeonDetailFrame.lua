-- Dungeon Spam Tracker - Detailed Dungeon Info Frame
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants

-- Dungeon Detail Frame
DST.DungeonDetailFrame = {}
local DetailFrame = DST.DungeonDetailFrame

-- Create the detailed dungeon info frame
function DetailFrame:Create()
    if Addon.DetailFrame then return Addon.DetailFrame end

    local frame = CreateFrame("Frame", "DJDungeonDetailFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:SetSize(750, 650)
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
    frame:SetFrameStrata("DIALOG")
    frame:Hide()

    -- Make closeable with ESC
    tinsert(UISpecialFrames, "DJDungeonDetailFrame")

    -- Dragging
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -20)
    frame.title:SetText("Dungeon Guide")

    -- Close button
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    -- Dungeon info header
    frame.infoHeader = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    frame.infoHeader:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -55)
    frame.infoHeader:SetSize(720, 80)
    frame.infoHeader:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
    frame.infoHeader:SetBackdropColor(0.1, 0.1, 0.2, 0.8)

    -- Dungeon name
    frame.dungeonName = frame.infoHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.dungeonName:SetPoint("TOPLEFT", frame.infoHeader, "TOPLEFT", 10, -8)
    frame.dungeonName:SetText("Dungeon Name")

    -- Dungeon stats
    frame.dungeonStats = frame.infoHeader:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.dungeonStats:SetPoint("TOPLEFT", frame.dungeonName, "BOTTOMLEFT", 0, -5)
    frame.dungeonStats:SetWidth(700)
    frame.dungeonStats:SetJustifyH("LEFT")

    -- Faction info
    frame.factionInfo = frame.infoHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.factionInfo:SetPoint("TOPLEFT", frame.dungeonStats, "BOTTOMLEFT", 0, -5)
    frame.factionInfo:SetWidth(700)
    frame.factionInfo:SetJustifyH("LEFT")

    -- Tab buttons
    frame.tabs = {}
    local tabNames = {"Bosses", "Loot", "Location"}
    for i, tabName in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
        tab:SetSize(100, 30)
        if i == 1 then
            tab:SetPoint("TOPLEFT", frame.infoHeader, "BOTTOMLEFT", 0, -5)
        else
            tab:SetPoint("LEFT", frame.tabs[i-1], "RIGHT", 5, 0)
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
            DetailFrame:SelectTab(frame, self.tabName)
        end)

        frame.tabs[i] = tab
    end

    -- Content scroll frame
    frame.scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    frame.scrollFrame:SetPoint("TOPLEFT", frame.tabs[1], "BOTTOMLEFT", 0, -10)
    frame.scrollFrame:SetSize(700, 430)

    -- Scroll child
    frame.scrollChild = CreateFrame("Frame", nil, frame.scrollFrame)
    frame.scrollChild:SetSize(680, 1)
    frame.scrollFrame:SetScrollChild(frame.scrollChild)

    -- Content text
    frame.contentText = frame.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.contentText:SetPoint("TOPLEFT", frame.scrollChild, "TOPLEFT", 5, -5)
    frame.contentText:SetWidth(670)
    frame.contentText:SetJustifyH("LEFT")
    frame.contentText:SetJustifyV("TOP")
    frame.contentText:SetSpacing(3)

    Addon.DetailFrame = frame
    return frame
end

-- Show dungeon details
function DetailFrame:Show(dungeonName, dungeonData, isHeroic)
    local frame = Addon.DetailFrame or self:Create()

    frame.currentDungeon = dungeonName
    frame.currentData = dungeonData
    frame.isHeroic = isHeroic or false

    -- Set dungeon name (with HEROIC prefix if applicable)
    local displayName = dungeonName
    if isHeroic then
        displayName = "|cffff8800HEROIC:|r " .. displayName
    end
    frame.dungeonName:SetText("|cff00ff80" .. displayName .. "|r")

    -- Set dungeon stats
    local levelText
    if isHeroic then
        levelText = "70"
    else
        levelText = string.format("%d-%d", dungeonData.minLevel, dungeonData.maxLevel)
    end
    local statsText = string.format(
        "Level: |cffffffff%s|r  |  Duration: |cffffffff~%d min|r  |  Faction: |cffffffff%s|r",
        levelText,
        dungeonData.avgDuration,
        dungeonData.faction
    )
    frame.dungeonStats:SetText(statsText)

    -- Set faction info
    local tracker = Addon.Tracker
    local standing = tracker and tracker:GetFactionStanding(dungeonData.faction) or "Unknown"
    local factionText = string.format(
        "Rep per run: |cffffffff%d|r  |  Rep cap: |cffffffff%s (%d)|r  |  Current standing: |cffffffff%s|r",
        dungeonData.repPerRun,
        dungeonData.repCap,
        dungeonData.repCapValue,
        standing
    )
    frame.factionInfo:SetText(factionText)

    -- Select default tab
    self:SelectTab(frame, "Bosses")

    frame:Show()
end

-- Select tab
function DetailFrame:SelectTab(frame, tabName)
    frame.currentTab = tabName

    -- Update tab appearance
    for _, tab in ipairs(frame.tabs) do
        if tab.tabName == tabName then
            tab:SetBackdropColor(0.2, 0.6, 0.3, 0.9)
            tab:SetBackdropBorderColor(0, 1, 0, 1)
        else
            tab:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
            tab:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        end
    end

    -- Hide any textures/frames from other tabs
    if frame.dungeonMapTexture then
        frame.dungeonMapTexture:Hide()
    end
    if frame.entranceTexture then
        frame.entranceTexture:Hide()
    end
    if frame.mapPlaceholderText then
        frame.mapPlaceholderText:Hide()
    end
    if frame.entrancePlaceholderText then
        frame.entrancePlaceholderText:Hide()
    end

    -- Update content
    if tabName == "Bosses" then
        self:ShowBossesTab(frame)
    elseif tabName == "Loot" then
        self:ShowLootTab(frame)
    elseif tabName == "Location" then
        self:ShowLocationTab(frame)
    end

    -- Reset scroll
    frame.scrollFrame:SetVerticalScroll(0)
end

-- Show bosses tab
function DetailFrame:ShowBossesTab(frame)
    local modeText = frame.isHeroic and "|cffff8800Heroic Mode|r" or (frame.isRaid and "|cffff00ffRaid|r" or "|cff00ff80Normal Mode|r")
    local text = "|cffffd700=== Boss Overview (" .. modeText .. ") ===|r\n\n"

    -- Try cached loot data first, then fallback to guide
    local lootData
    if frame.isRaid then
        lootData = DST.LootData and DST.LootData:GetRaidLoot(frame.currentDungeon)
    else
        lootData = DST.LootData and DST.LootData:GetDungeonLoot(frame.currentDungeon)
    end

    if lootData and lootData.bosses then
        -- Show bosses from cached loot data
        for i, boss in ipairs(lootData.bosses) do
            text = text .. string.format("|cff00ff80%d. %s|r\n", i, boss.name)

            if frame.isRaid then
                -- Raids: show actual items
                if boss.items and #boss.items > 0 then
                    text = text .. string.format("   Loot: |cffffffff%d items|r\n", #boss.items)
                    -- Display first few items as preview
                    local maxPreview = 5
                    for idx = 1, math.min(#boss.items, maxPreview) do
                        local itemID = boss.items[idx]
                        text = text .. "      " .. (select(2, GetItemInfo(itemID)) or "[Item "..itemID.."]") .. "\n"
                    end
                    if #boss.items > maxPreview then
                        text = text .. "      |cffaaaaaa... and " .. (#boss.items - maxPreview) .. " more|r\n"
                    end
                end
            elseif frame.isHeroic then
                -- Show only heroic loot in heroic mode
                if boss.heroic and boss.heroic > 0 then
                    text = text .. string.format("   Loot: |cffffffff%d items|r\n", boss.heroic)
                end
            else
                -- Show only normal loot in normal mode
                if boss.normal and boss.normal > 0 then
                    text = text .. string.format("   Loot: |cffffffff%d items|r\n", boss.normal)
                end
            end
            text = text .. "\n"
        end
    elseif frame.currentData and frame.currentData.guide then
        -- Fallback to guide data
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

    frame.contentText:SetText(text)
    frame.scrollChild:SetHeight(math.max(frame.contentText:GetStringHeight() + 20, frame.scrollFrame:GetHeight()))
end

-- Show loot tab
function DetailFrame:ShowLootTab(frame)
    local modeText = frame.isHeroic and "|cffff8800Heroic Mode|r" or (frame.isRaid and "|cffff00ffRaid|r" or "|cff00ff80Normal Mode|r")
    local text = "|cffffd700=== Loot Information (" .. modeText .. ") ===|r\n\n"

    local lootData
    if frame.isRaid then
        lootData = DST.LootData and DST.LootData:GetRaidLoot(frame.currentDungeon)
    else
        lootData = DST.LootData and DST.LootData:GetDungeonLoot(frame.currentDungeon)
    end

    if lootData and lootData.bosses then
        -- Use cached loot data
        if frame.isRaid then
            text = text .. "This raid drops loot from the following bosses:\n\n"
        else
            text = text .. "This dungeon drops loot from the following bosses:\n\n"
        end

        local totalItems = 0
        for i, boss in ipairs(lootData.bosses) do
            text = text .. string.format("|cff00ff80%s|r\n", boss.name)

            if frame.isRaid then
                -- Raids: show actual items
                if boss.items and #boss.items > 0 then
                    text = text .. string.format("   Drops: |cffffffff%d items|r\n", #boss.items)
                    -- Display item links
                    for _, itemID in ipairs(boss.items) do
                        text = text .. "      " .. (select(2, GetItemInfo(itemID)) or "[Item "..itemID.."]") .. "\n"
                    end
                    totalItems = totalItems + #boss.items
                end
            elseif frame.isHeroic then
                -- Show only heroic loot in heroic mode
                if boss.heroic and boss.heroic > 0 then
                    text = text .. string.format("   Drops: |cffffffff%d items|r\n", boss.heroic)
                    totalItems = totalItems + boss.heroic
                end
            else
                -- Show only normal loot in normal mode
                if boss.normal and boss.normal > 0 then
                    text = text .. string.format("   Drops: |cffffffff%d items|r\n", boss.normal)
                    totalItems = totalItems + boss.normal
                end
            end
            text = text .. "\n"
        end

        text = text .. string.format("\n|cffffd700Total available items:|r |cffffffff%d|r\n", totalItems)
        if frame.isRaid then
            text = text .. "\n|cffaaaaaa" .. "Raids drop epic (purple) and legendary (orange) gear" .. "|r"
        else
            text = text .. "\n|cffaaaaaa" .. (frame.isHeroic and "Heroic dungeons drop epic (purple) gear" or "Normal dungeons drop rare (blue) gear") .. "|r"
        end
    else
        text = text .. "|cffff9900No loot information available.|r"
    end

    frame.contentText:SetText(text)
    frame.scrollChild:SetHeight(math.max(frame.contentText:GetStringHeight() + 20, frame.scrollFrame:GetHeight()))
end

-- Show strategy tab
function DetailFrame:ShowStrategyTab(frame)
    if not frame.currentData or not frame.currentData.guide then
        frame.contentText:SetText("|cffff9900No strategy guide available.|r")
        frame.scrollChild:SetHeight(50)
        return
    end

    local text = "|cffffd700=== Dungeon Strategy Guide ===|r\n\n"
    text = text .. "|cffffffffLocation:|r " .. (frame.currentData.entrance or frame.currentData.zone) .. "\n\n"

    text = text .. "|cffffd700Boss Strategies:|r\n\n"

    for i, line in ipairs(frame.currentData.guide) do
        -- Highlight boss names
        if line:match("^Boss %d") or line:match("%):") or line:match("^%w+ %d+:") then
            text = text .. "|cff00ff80" .. line .. "|r\n"
        else
            text = text .. "   " .. line .. "\n"
        end
    end

    if frame.currentData.requiredFor and #frame.currentData.requiredFor > 0 then
        text = text .. "\n|cffffd700Important for:|r\n"
        for _, req in ipairs(frame.currentData.requiredFor) do
            text = text .. "   • " .. req .. "\n"
        end
    end

    frame.contentText:SetText(text)
    frame.scrollChild:SetHeight(math.max(frame.contentText:GetStringHeight() + 20, frame.scrollFrame:GetHeight()))
end

-- Helper: Get dungeon map texture path
function DetailFrame:GetDungeonMapTexture(dungeonName)
    -- Use our own texture files (self-contained, no Atlas dependency)
    local cleanName = dungeonName:gsub(" ", "")
    -- We have JPG files for all TBC dungeons now
    return string.format("Interface\\AddOns\\DJDungeonSpamGuide\\Textures\\%s_Map.jpg", cleanName)
end

-- Helper: Check if texture exists
function DetailFrame:TextureExists(texturePath)
    if not texturePath then return false end
    -- List of dungeons that have map textures (with exact names as they appear in files)
    local hasTexture = {
        ["HellfireRamparts"] = true,
        ["BloodFurnace"] = true,
        ["SlavePens"] = true,
        ["Underbog"] = true,
        ["Mana-Tombs"] = true,  -- Note: includes hyphen
        ["AuchenaiCrypts"] = true,
        ["SethekkHalls"] = true,
        ["ShadowLabyrinth"] = true,
        ["OldHillsbrad"] = true,
        ["BlackMorass"] = true,
        ["ShatteredHalls"] = true,
        ["Mechanar"] = true,
        ["Botanica"] = true,
        ["Arcatraz"] = true,
        ["Steamvault"] = true,
    }

    -- Check if this is a map texture and if we have it
    if texturePath:find("_Map%.jpg") then
        for dungeonName, _ in pairs(hasTexture) do
            if texturePath:find(dungeonName) then
                return true
            end
        end
    end

    return false
end

-- Show location tab
function DetailFrame:ShowLocationTab(frame)
    if not frame.currentData then
        frame.contentText:SetText("|cffff9900No location information available.|r")
        frame.scrollChild:SetHeight(50)
        return
    end

    local data = frame.currentData
    local dungeonName = frame.currentDungeon
    local text = "|cffffd700=== Location & Entrance ===|r\n\n"

    -- Zone and entrance
    text = text .. "|cffffffffZone:|r |cff00ff80" .. (data.zone or "Unknown") .. "|r\n"
    text = text .. "|cffffffffEntrance:|r " .. (data.entrance or data.zone or "Unknown") .. "\n\n"

    -- Level requirement
    text = text .. "|cffffd700Requirements:|r\n"
    if frame.isHeroic then
        text = text .. "   Level: |cffffffff70|r |cffff8800(Heroic)|r\n"
        text = text .. string.format("   Faction Key: |cffffffff%s (Revered)|r\n", data.faction)
    else
        text = text .. string.format("   Level: |cffffffff%d-%d|r\n", data.minLevel, data.maxLevel)
    end
    text = text .. "\n"

    -- Dungeon info
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

    frame.contentText:SetText(text)
    frame.scrollChild:SetHeight(math.max(frame.contentText:GetStringHeight() + 20, frame.scrollFrame:GetHeight()))
end
