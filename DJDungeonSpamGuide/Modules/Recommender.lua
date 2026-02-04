-- Dungeon Spam Tracker - Recommender Module
local ADDON_NAME, DST = ...

local Addon = DJDungeonSpamGuide
local L = DST.L
local C = DST.Constants
local D = DST.DungeonData

-- Create Recommender module
local Recommender = {}
Addon.Recommender = Recommender

-- Initialize recommender
function Recommender:Init()
    -- Nothing to initialize yet
end

-- Get the recommended dungeon based on current state and optimization mode
function Recommender:GetRecommendation()
    local tracker = Addon.Tracker
    if not tracker then return nil end

    local playerLevel = tracker.playerLevel
    local isMaxLevel = playerLevel >= 70

    -- Get optimization mode (with safety check)
    local mode = "balanced"
    if Addon.GetOptimizationMode then
        mode = Addon:GetOptimizationMode()
    end

    if mode == "xp" then
        return self:GetXPOptimizedRecommendation()
    elseif mode == "rep" then
        return self:GetRepOptimizedRecommendation()
    else
        -- Balanced mode (default)
        return self:GetBalancedRecommendation()
    end
end

-- XP Optimization: Prioritize dungeons with best XP/hour
function Recommender:GetXPOptimizedRecommendation()
    local tracker = Addon.Tracker
    if not tracker then return nil end

    local playerLevel = tracker.playerLevel

    -- At level 70, no XP gains, fall back to rep
    if playerLevel >= 70 then
        return self:GetRepOptimizedRecommendation()
    end

    -- Get all available dungeons
    local orderedDungeons = D:GetOrderedDungeons()
    local candidates = {}

    for _, dungeonEntry in ipairs(orderedDungeons) do
        local name = dungeonEntry.name
        local data = dungeonEntry.data

        -- Check level requirement and not rep capped
        if playerLevel >= data.minLevel and not tracker:IsDungeonRepCapped(name) then
            table.insert(candidates, {
                name = name,
                data = data,
                xpPerHour = data.expPerHour,
                repPerHour = data.repPerHour,
            })
        end
    end

    -- Sort by XP/hour descending
    table.sort(candidates, function(a, b)
        return a.xpPerHour > b.xpPerHour
    end)

    if #candidates > 0 then
        local best = candidates[1]
        return {
            name = best.name,
            data = best.data,
            reason = "xp_optimized",
            runsToRepCap = tracker:GetRunsToRepCap(best.name),
            runsToLevel = tracker:GetRunsToLevel(best.name),
        }
    end

    return nil
end

-- Rep Optimization: Prioritize specific faction or best rep/hour
function Recommender:GetRepOptimizedRecommendation()
    local tracker = Addon.Tracker
    if not tracker then return nil end

    local playerLevel = tracker.playerLevel
    local targetFaction = Addon.GetTargetFaction and Addon:GetTargetFaction() or nil

    -- Get all available dungeons
    local orderedDungeons = D:GetOrderedDungeons()
    local candidates = {}

    for _, dungeonEntry in ipairs(orderedDungeons) do
        local name = dungeonEntry.name
        local data = dungeonEntry.data

        -- Check level requirement
        if playerLevel >= data.minLevel then
            -- If targeting specific faction, only include that faction's dungeons
            if targetFaction and data.faction ~= targetFaction then
                -- Skip
            elseif not tracker:IsDungeonRepCapped(name) then
                table.insert(candidates, {
                    name = name,
                    data = data,
                    repPerHour = data.repPerHour,
                    faction = data.faction,
                })
            end
        end
    end

    -- Sort by rep/hour descending
    table.sort(candidates, function(a, b)
        return a.repPerHour > b.repPerHour
    end)

    if #candidates > 0 then
        local best = candidates[1]
        return {
            name = best.name,
            data = best.data,
            reason = "rep_optimized",
            targetFaction = targetFaction or best.faction,
            runsToRepCap = tracker:GetRunsToRepCap(best.name),
            runsToLevel = tracker:GetRunsToLevel(best.name),
        }
    end

    -- If target faction specified but all capped, try other factions
    if targetFaction then
        if Addon.SetTargetFaction then
            Addon:SetTargetFaction(nil)
        end
        return self:GetRepOptimizedRecommendation()
    end

    return nil
end

-- Balanced: Follow progression order (original logic)
function Recommender:GetBalancedRecommendation()
    local tracker = Addon.Tracker
    if not tracker then return nil end

    local playerLevel = tracker.playerLevel
    local isMaxLevel = playerLevel >= 70

    -- Get ordered list of dungeons
    local orderedDungeons = D:GetOrderedDungeons()

    -- Find the first available dungeon that isn't rep capped
    for _, dungeonEntry in ipairs(orderedDungeons) do
        local name = dungeonEntry.name
        local data = dungeonEntry.data

        -- Check level requirement
        if playerLevel >= data.minLevel then
            -- Check if rep is capped
            if not tracker:IsDungeonRepCapped(name) then
                return {
                    name = name,
                    data = data,
                    reason = "balanced",
                    runsToRepCap = tracker:GetRunsToRepCap(name),
                    runsToLevel = tracker:GetRunsToLevel(name),
                }
            end
        end
    end

    -- All dungeons either locked or rep capped
    -- At max level, might want to suggest rep grinds to exalted
    if isMaxLevel then
        return self:GetExaltedGrindRecommendation()
    end

    return nil
end

-- Get recommendation for exalted rep grinding
function Recommender:GetExaltedGrindRecommendation()
    local tracker = Addon.Tracker
    if not tracker then return nil end

    -- Priority order for exalted grinding
    local exaltedPriority = {
        {dungeon = "Botanica", faction = "The Sha'tar"},        -- Best Sha'tar rep
        {dungeon = "Steamvault", faction = "Cenarion Expedition"}, -- Best CE rep
        {dungeon = "Shadow Labyrinth", faction = "Lower City"},   -- Best LC rep
        {dungeon = "Black Morass", faction = "Keepers of Time"},  -- KoT rep
        {dungeon = "Shattered Halls", faction = "Honor Hold"},    -- HH rep
    }

    for _, entry in ipairs(exaltedPriority) do
        local factionData = tracker:GetFactionData(entry.faction)
        if factionData and factionData.standingID < 8 then -- Not yet Exalted
            local dungeonData = D:GetDungeon(entry.dungeon)
            if dungeonData then
                return {
                    name = entry.dungeon,
                    data = dungeonData,
                    reason = "exalted_grind",
                    targetFaction = entry.faction,
                    runsToRepCap = tracker:GetRunsToRepCap(entry.dungeon),
                    runsToLevel = 0,
                }
            end
        end
    end

    return nil
end

-- Get all available dungeons with their status
function Recommender:GetAllDungeonStatus()
    local tracker = Addon.Tracker
    if not tracker then return {} end

    local playerLevel = tracker.playerLevel
    local recommendation = self:GetRecommendation()
    local recommendedName = recommendation and recommendation.name or nil

    local results = {}
    local orderedDungeons = D:GetOrderedDungeons()

    for _, dungeonEntry in ipairs(orderedDungeons) do
        local name = dungeonEntry.name
        local data = dungeonEntry.data

        local status, statusText = tracker:GetDungeonStatus(name)
        local isRecommended = (name == recommendedName)

        local entry = {
            name = name,
            data = data,
            status = status,
            statusText = statusText,
            isRecommended = isRecommended,
            runsCompleted = tracker:GetDungeonRuns(name),
            runsToRepCap = tracker:GetRunsToRepCap(name),
            runsToLevel = tracker:GetRunsToLevel(name),
            factionRep = tracker:GetFactionRep(data.faction),
            factionStanding = tracker:GetFactionStanding(data.faction),
        }

        table.insert(results, entry)
    end

    return results
end

-- Check if a specific dungeon is recommended
function Recommender:IsRecommended(dungeonName)
    local rec = self:GetRecommendation()
    return rec and rec.name == dungeonName
end

-- Get next dungeon after current one in progression
function Recommender:GetNextDungeon(currentDungeonName)
    local orderedDungeons = D:GetOrderedDungeons()
    local foundCurrent = false

    for _, dungeonEntry in ipairs(orderedDungeons) do
        if foundCurrent then
            return dungeonEntry.name, dungeonEntry.data
        end
        if dungeonEntry.name == currentDungeonName then
            foundCurrent = true
        end
    end

    return nil
end

-- Get dungeon recommendation reason text
function Recommender:GetRecommendationReason(dungeonName)
    local tracker = Addon.Tracker
    if not tracker then return "" end

    local dungeon = D:GetDungeon(dungeonName)
    if not dungeon then return "" end

    local status = tracker:GetDungeonStatus(dungeonName)

    if status == "LOCKED" then
        return string.format("Requires level %d", dungeon.minLevel)
    elseif status == "COMPLETE" then
        return string.format("%s rep capped at %s", dungeon.faction, dungeon.repCap)
    else
        local runs = tracker:GetRunsToRepCap(dungeonName)
        if runs > 0 then
            return string.format("%d runs to cap %s rep", runs, dungeon.faction)
        else
            return "Available for rep grinding"
        end
    end
end

-- Calculate optimal dungeon path from current state to all heroic keys
function Recommender:GetOptimalPath()
    local tracker = Addon.Tracker
    if not tracker then return {} end

    local path = {}
    local playerLevel = tracker.playerLevel

    -- Get dungeons in order, filtering by what's needed
    local orderedDungeons = D:GetOrderedDungeons()

    for _, dungeonEntry in ipairs(orderedDungeons) do
        local name = dungeonEntry.name
        local data = dungeonEntry.data

        -- Skip if already rep capped
        if not tracker:IsDungeonRepCapped(name) then
            -- Include if at or above min level
            if playerLevel >= data.minLevel then
                table.insert(path, {
                    name = name,
                    data = data,
                    runsNeeded = tracker:GetRunsToRepCap(name),
                    timeNeeded = tracker:GetTimeToRepCap(name),
                })
            end
        end
    end

    return path
end
