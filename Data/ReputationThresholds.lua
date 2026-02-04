-- Dungeon Spam Tracker - Reputation Thresholds
local ADDON_NAME, DST = ...

DST.RepThresholds = {}
local R = DST.RepThresholds

-- Reputation values for each standing (cumulative from Neutral 0)
R.STANDING_VALUES = {
    ["Neutral"] = 0,
    ["Friendly"] = 3000,
    ["Honored"] = 9000,
    ["Revered"] = 21000,
    ["Exalted"] = 42000,
}

-- Rep within each standing tier
R.STANDING_RANGES = {
    ["Neutral"] = {min = 0, max = 2999},
    ["Friendly"] = {min = 3000, max = 8999},
    ["Honored"] = {min = 9000, max = 20999},
    ["Revered"] = {min = 21000, max = 41999},
    ["Exalted"] = {min = 42000, max = 42999},
}

-- Standing ID to name mapping
R.STANDING_ID_TO_NAME = {
    [4] = "Neutral",
    [5] = "Friendly",
    [6] = "Honored",
    [7] = "Revered",
    [8] = "Exalted",
}

-- Get the absolute rep value from standing and rep within standing
function R:GetAbsoluteRep(standingID, repValue)
    local standingName = self.STANDING_ID_TO_NAME[standingID]
    if not standingName then return 0 end

    local baseValue = self.STANDING_VALUES[standingName] or 0
    return baseValue + repValue
end

-- Get rep remaining to reach a target standing
function R:GetRepToStanding(currentStandingID, currentRep, targetStanding)
    local currentAbsolute = self:GetAbsoluteRep(currentStandingID, currentRep)
    local targetValue = self.STANDING_VALUES[targetStanding] or 0

    return math.max(0, targetValue - currentAbsolute)
end

-- Calculate runs needed to reach target standing
function R:GetRunsToStanding(currentStandingID, currentRep, targetStanding, repPerRun)
    if repPerRun <= 0 then return 0 end

    local repNeeded = self:GetRepToStanding(currentStandingID, currentRep, targetStanding)
    return math.ceil(repNeeded / repPerRun)
end

-- Check if current rep meets or exceeds target standing
function R:HasReachedStanding(currentStandingID, currentRep, targetStanding)
    local currentAbsolute = self:GetAbsoluteRep(currentStandingID, currentRep)
    local targetValue = self.STANDING_VALUES[targetStanding] or 0

    return currentAbsolute >= targetValue
end

-- Get standing name from ID
function R:GetStandingName(standingID)
    return self.STANDING_ID_TO_NAME[standingID] or "Unknown"
end

-- Get progress percentage within current standing
function R:GetStandingProgress(standingID, currentRep)
    local standingName = self.STANDING_ID_TO_NAME[standingID]
    if not standingName then return 0 end

    local range = self.STANDING_RANGES[standingName]
    if not range then return 0 end

    local total = range.max - range.min + 1
    return math.min(100, (currentRep / total) * 100)
end

-- Get max rep for a standing tier
function R:GetStandingMax(standingID)
    local standingName = self.STANDING_ID_TO_NAME[standingID]
    if not standingName then return 0 end

    local range = self.STANDING_RANGES[standingName]
    if not range then return 0 end

    return range.max - range.min + 1
end
