-- Dungeon Spam Tracker - Experience Per Level Data
local ADDON_NAME, DST = ...

DST.ExpPerLevel = {}
local E = DST.ExpPerLevel

-- Experience required to level up from each level
-- Source: TBC Classic data
E.XP_TO_LEVEL = {
    [60] = 290000,
    [61] = 317000,
    [62] = 349000,
    [63] = 386000,
    [64] = 428000,
    [65] = 475000,
    [66] = 527000,
    [67] = 586000,
    [68] = 651000,
    [69] = 723000,
}

-- Cumulative XP from 60 to each level
E.CUMULATIVE_XP = {
    [60] = 0,
    [61] = 290000,
    [62] = 607000,
    [63] = 956000,
    [64] = 1342000,
    [65] = 1770000,
    [66] = 2245000,
    [67] = 2772000,
    [68] = 3358000,
    [69] = 4009000,
    [70] = 4732000,
}

-- Get XP required to reach next level from current level
function E:GetXPToNextLevel(level)
    return self.XP_TO_LEVEL[level] or 0
end

-- Get cumulative XP from 60 to target level
function E:GetCumulativeXP(level)
    return self.CUMULATIVE_XP[level] or 0
end

-- Calculate total XP remaining to level 70 from current state
function E:GetTotalXPRemaining(currentLevel, currentXP)
    if currentLevel >= 70 then return 0 end

    local xpToNextLevel = self:GetXPToNextLevel(currentLevel) - currentXP
    local xpForRemainingLevels = 0

    for lvl = currentLevel + 1, 69 do
        xpForRemainingLevels = xpForRemainingLevels + (self.XP_TO_LEVEL[lvl] or 0)
    end

    return xpToNextLevel + xpForRemainingLevels
end

-- Calculate estimated runs to level up based on XP per run
function E:GetRunsToLevel(currentLevel, currentXP, xpPerRun)
    if xpPerRun <= 0 then return 0 end

    local xpNeeded = self:GetXPToNextLevel(currentLevel) - currentXP
    return math.ceil(xpNeeded / xpPerRun)
end

-- Calculate estimated runs to reach level 70
function E:GetRunsTo70(currentLevel, currentXP, xpPerRun)
    if xpPerRun <= 0 then return 0 end

    local totalXPNeeded = self:GetTotalXPRemaining(currentLevel, currentXP)
    return math.ceil(totalXPNeeded / xpPerRun)
end
