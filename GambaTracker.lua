print("Gamba Chlívák ready")

local frame = CreateFrame("Frame", "GambaFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(520, 500)
frame:SetPoint("CENTER")
frame:Hide()
frame.TitleText:SetText("Gamba Chlívák")

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetClampedToScreen(true)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

table.insert(UISpecialFrames, "GambaFrame")

-- Place the crest image at Interface\AddOns\GambaTracker\GambaBackground.tga
local frameBackground = frame:CreateTexture(nil, "BACKGROUND", nil, 7)
frameBackground:SetAllPoints(frame)
frameBackground:SetTexture("Interface\\AddOns\\GambaTracker\\GambaBackground.tga")
frameBackground:SetVertexColor(1, 1, 1, 0.45)

local tab1 = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
tab1:SetSize(150, 24)
tab1:SetPoint("TOP", frame, "TOP", -65, -32)
tab1:SetText("Hall of Shame")
tab1:SetNormalFontObject("GameFontNormal")
tab1:SetHighlightFontObject("GameFontNormal")
tab1:SetDisabledFontObject("GameFontNormal")

local tab2 = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
tab2:SetSize(120, 24)
tab2:SetPoint("LEFT", tab1, "RIGHT", 10, 0)
tab2:SetText("Lets Play")
tab2:SetNormalFontObject("GameFontNormal")
tab2:SetHighlightFontObject("GameFontNormal")
tab2:SetDisabledFontObject("GameFontNormal")

local content = CreateFrame("Frame", nil, frame)
content:SetSize(470, 300)
content:SetPoint("TOPLEFT", 15, -65)
content:SetPoint("BOTTOMRIGHT", -30, 15)

local activeTab = "lets"

local hallTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
hallTitle:SetPoint("TOPLEFT", 10, -10)
hallTitle:SetText("Hall of Shame")
hallTitle:SetTextColor(1, 0.4, 0.4)
hallTitle:Hide()

local hallWinnersTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hallWinnersTitle:SetPoint("TOPLEFT", 14, -76)
hallWinnersTitle:SetText("Winners")
hallWinnersTitle:SetTextColor(0.3, 0.9, 0.3)
hallWinnersTitle:Hide()

local hallLosersTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hallLosersTitle:SetPoint("TOPLEFT", 240, -76)
hallLosersTitle:SetText("Losers")
hallLosersTitle:SetTextColor(1, 0.45, 0.45)
hallLosersTitle:Hide()

local hallRecordText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hallRecordText:SetPoint("TOPLEFT", 14, -34)
hallRecordText:SetText("Chlivak dne: -")
hallRecordText:SetTextColor(1, 0.85, 0.2)
hallRecordText:Hide()

local hallAllTimeRecordText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hallAllTimeRecordText:SetPoint("TOPLEFT", 14, -48)
hallAllTimeRecordText:SetText("Absolutni rekord: -")
hallAllTimeRecordText:SetTextColor(1, 0.6, 0.1)
hallAllTimeRecordText:Hide()

local hallScrollFrame = CreateFrame("ScrollFrame", "GambaHallScrollFrame", content, "UIPanelScrollFrameTemplate")
hallScrollFrame:SetPoint("TOPLEFT", 10, -96)
hallScrollFrame:SetPoint("BOTTOMRIGHT", -28, 10)
hallScrollFrame:EnableMouseWheel(true)
hallScrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local newValue = self:GetVerticalScroll() - delta * 20
    newValue = math.max(0, math.min(newValue, self:GetVerticalScrollRange()))
    self:SetVerticalScroll(newValue)
end)
hallScrollFrame:Hide()

local hallScrollChild = CreateFrame("Frame", nil, hallScrollFrame)
hallScrollChild:SetSize(1, 1)
hallScrollFrame:SetScrollChild(hallScrollChild)

local hallWinnersList = hallScrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
hallWinnersList:SetPoint("TOPLEFT", 4, 0)
hallWinnersList:SetWidth(200)
hallWinnersList:SetJustifyH("LEFT")
hallWinnersList:SetJustifyV("TOP")
hallWinnersList:SetText("-")

local hallLosersList = hallScrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
hallLosersList:SetPoint("TOPLEFT", 220, 0)
hallLosersList:SetWidth(200)
hallLosersList:SetJustifyH("LEFT")
hallLosersList:SetJustifyV("TOP")
hallLosersList:SetText("-")

local letsTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
letsTitle:SetPoint("TOPLEFT", 10, -10)
letsTitle:SetText("Lets Play")
letsTitle:SetTextColor(0.3, 0.9, 0.3)
letsTitle:Hide()

local letsNumberLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
letsNumberLabel:SetPoint("TOPLEFT", 14, -162)
letsNumberLabel:SetText("Amount:")
letsNumberLabel:SetTextColor(1, 0.85, 0.2)
letsNumberLabel:Hide()

local letsNumberInput = CreateFrame("EditBox", nil, content, "InputBoxTemplate")
letsNumberInput:SetSize(200, 30)
letsNumberInput:SetPoint("LEFT", letsNumberLabel, "RIGHT", 8, 0)
letsNumberInput:SetAutoFocus(false)
letsNumberInput:SetMaxLetters(10)
letsNumberInput:SetTextInsets(8, 8, 0, 0)
if letsNumberInput.SetNumeric then
    letsNumberInput:SetNumeric(true)
end
letsNumberInput:SetText("100000")
letsNumberInput:Hide()

local letsPlayersTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
letsPlayersTitle:SetPoint("TOPLEFT", 14, -200)
letsPlayersTitle:SetText("Players (1 join / -1 leave):")
letsPlayersTitle:SetTextColor(1, 0.85, 0.2)
letsPlayersTitle:Hide()

local letsPlayersScrollFrame = CreateFrame("ScrollFrame", "GambaLetsPlayersScrollFrame", content, "UIPanelScrollFrameTemplate")
letsPlayersScrollFrame:SetPoint("TOPLEFT", 10, -222)
letsPlayersScrollFrame:SetPoint("BOTTOMRIGHT", -28, 10)
letsPlayersScrollFrame:EnableMouseWheel(true)
letsPlayersScrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local newValue = self:GetVerticalScroll() - delta * 20
    newValue = math.max(0, math.min(newValue, self:GetVerticalScrollRange()))
    self:SetVerticalScroll(newValue)
end)
letsPlayersScrollFrame:Hide()

local letsPlayersScrollChild = CreateFrame("Frame", nil, letsPlayersScrollFrame)
letsPlayersScrollChild:SetSize(1, 1)
letsPlayersScrollFrame:SetScrollChild(letsPlayersScrollChild)

local letsPlayersList = letsPlayersScrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
letsPlayersList:SetPoint("TOPLEFT", 4, 0)
letsPlayersList:SetWidth(410)
letsPlayersList:SetJustifyH("LEFT")
letsPlayersList:SetJustifyV("TOP")
letsPlayersList:SetText("-")

local joinedPlayers = {}
local joinedPlayersLookup = {}
local joinedPlayersRolls = {}

GambaTrackerDB = _G.GambaTrackerDB or {
    stats = {
        RAID = {},
        PARTY = {}
    },
    record = {},
    allTimeRecord = {}
}
_G.GambaTrackerDB = GambaTrackerDB

local playerStats = {
    RAID = GambaTrackerDB.stats.RAID or {},
    PARTY = GambaTrackerDB.stats.PARTY or {}
}

local hallRecord = GambaTrackerDB.record or {}
GambaTrackerDB.record = hallRecord
if type(hallRecord.players) ~= "table" then
    hallRecord.players = {}
end

local hallAllTimeRecord = GambaTrackerDB.allTimeRecord or {}
GambaTrackerDB.allTimeRecord = hallAllTimeRecord
if hallAllTimeRecord.amount == nil then
    hallAllTimeRecord.amount = 0
end

local function ensureSavedStats()
    if type(GambaTrackerDB) ~= "table" then
        GambaTrackerDB = {
            stats = {
                RAID = {},
                PARTY = {}
            },
            record = {},
            allTimeRecord = {}
        }
        _G.GambaTrackerDB = GambaTrackerDB
    end

    if type(GambaTrackerDB.stats) ~= "table" then
        GambaTrackerDB.stats = {
            RAID = {},
            PARTY = {}
        }
    end

    if type(GambaTrackerDB.stats.RAID) ~= "table" then
        GambaTrackerDB.stats.RAID = {}
    end

    if type(GambaTrackerDB.stats.PARTY) ~= "table" then
        GambaTrackerDB.stats.PARTY = {}
    end

    if type(GambaTrackerDB.record) ~= "table" then
        GambaTrackerDB.record = {}
    end

    if type(GambaTrackerDB.allTimeRecord) ~= "table" then
        GambaTrackerDB.allTimeRecord = {}
    end

    playerStats.RAID = GambaTrackerDB.stats.RAID
    playerStats.PARTY = GambaTrackerDB.stats.PARTY
    hallRecord = GambaTrackerDB.record
    if type(hallRecord.players) ~= "table" then
        hallRecord.players = {}
    end
    hallAllTimeRecord = GambaTrackerDB.allTimeRecord
    if hallAllTimeRecord.amount == nil then
        hallAllTimeRecord.amount = 0
    end
end

local currentGameChannel
local isSelfJoined = false
local isJoinOpen = false
local isRollingStarted = false
local roundResultAnnounced = false

local function styleButton(btn)
    if not btn or type(btn.SetBackdrop) ~= "function" then
        return
    end

    btn:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    btn:SetBackdropColor(0.08, 0.05, 0.04, 1)
    btn:SetBackdropBorderColor(0.9, 0.15, 0.1, 1)
    btn:SetNormalFontObject("GameFontNormal")
    btn:SetHighlightFontObject("GameFontNormal")
    if btn.GetFontString then
        btn:GetFontString():SetTextColor(1, 0.85, 0.2, 1)
    end
end

local function formatAmountWithSpaces(amountText)
    local digits = tostring(amountText or ""):gsub("%D", "")
    if digits == "" then
        digits = "100000"
    end
    local formatted = digits:reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^ ", "")
    return formatted
end

local function parseAmountNumber(amountText)
    local digits = tostring(amountText or ""):gsub("%D", "")
    local amount = tonumber(digits)
    if not amount or amount < 1 then
        return 100000
    end
    return amount
end

local function getDefaultChannel()
    if IsInRaid() then
        return "RAID"
    elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "INSTANCE_CHAT"
    elseif IsInGroup() then
        return "PARTY"
    end
    return "SAY"
end

local function getStatsBucketKey(channel)
    if channel == "RAID" then
        return "RAID"
    end
    return "PARTY"
end

local function getClassColoredName(playerName)
    if not playerName or playerName == "" then
        return playerName
    end

    local unit
    if UnitName("player") == playerName then
        unit = "player"
    elseif IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            if UnitName("raid" .. i) == playerName then
                unit = "raid" .. i
                break
            end
        end
    elseif IsInGroup() then
        for i = 1, GetNumGroupMembers() - 1 do
            if UnitName("party" .. i) == playerName then
                unit = "party" .. i
                break
            end
        end
    end

    if not unit then
        return playerName
    end

    local _, class = UnitClass(unit)
    local classColor = class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    if not classColor then
        return playerName
    end

    return "|c" .. classColor.colorStr .. playerName .. "|r"
end

local function getOrCreatePlayerStats(bucketKey, playerName)
    local bucket = playerStats[bucketKey]
    if not bucket[playerName] then
        bucket[playerName] = {
            won = 0,
            lost = 0,
            wins = 0,
            losses = 0
        }
    end
    return bucket[playerName]
end

local function buildStatsLists(statsTable)
    local winners = {}
    local losers = {}

    for playerName, stats in pairs(statsTable) do
        if stats.won > 0 or stats.wins > 0 then
            winners[#winners + 1] = {
                name = playerName,
                amount = stats.won,
                rounds = stats.wins
            }
        end

        if stats.lost > 0 or stats.losses > 0 then
            losers[#losers + 1] = {
                name = playerName,
                amount = stats.lost,
                rounds = stats.losses
            }
        end
    end

    table.sort(winners, function(a, b)
        if a.amount == b.amount then
            return a.name < b.name
        end
        return a.amount > b.amount
    end)

    table.sort(losers, function(a, b)
        if a.amount == b.amount then
            return a.name < b.name
        end
        return a.amount > b.amount
    end)

    return winners, losers
end

local function refreshPlayersListText()
    if #joinedPlayers == 0 then
        letsPlayersList:SetText("-")
    else
        local lines = {}
        for i, playerName in ipairs(joinedPlayers) do
            local rolledValue = joinedPlayersRolls[playerName]
            local coloredName = getClassColoredName(playerName)
            if rolledValue then
                lines[#lines + 1] = i .. ". " .. coloredName .. " - " .. rolledValue
            else
                lines[#lines + 1] = i .. ". " .. coloredName
            end
        end
        letsPlayersList:SetText(table.concat(lines, "\n"))
    end

    letsPlayersScrollChild:SetSize(letsPlayersScrollFrame:GetWidth(), math.max(letsPlayersList:GetStringHeight(), letsPlayersScrollFrame:GetHeight()))
end

local function saveHallStats()
    if not GambaTrackerDB then
        GambaTrackerDB = {}
    end
    if not GambaTrackerDB.stats then
        GambaTrackerDB.stats = {}
    end

    local raidSnapshot = {}
    for playerName, stats in pairs(playerStats.RAID or {}) do
        raidSnapshot[playerName] = {
            won = tonumber(stats.won) or 0,
            lost = tonumber(stats.lost) or 0,
            wins = tonumber(stats.wins) or 0,
            losses = tonumber(stats.losses) or 0
        }
    end

    local partySnapshot = {}
    for playerName, stats in pairs(playerStats.PARTY or {}) do
        partySnapshot[playerName] = {
            won = tonumber(stats.won) or 0,
            lost = tonumber(stats.lost) or 0,
            wins = tonumber(stats.wins) or 0,
            losses = tonumber(stats.losses) or 0
        }
    end

    GambaTrackerDB.stats.RAID = raidSnapshot
    GambaTrackerDB.stats.PARTY = partySnapshot
    playerStats.RAID = raidSnapshot
    playerStats.PARTY = partySnapshot
end

local function refreshHallStatsText()
    local raidWinners, raidLosers = buildStatsLists(playerStats.RAID)
    local partyWinners, partyLosers = buildStatsLists(playerStats.PARTY)

    local winnerLines = {}
    winnerLines[#winnerLines + 1] = "[Raid]"
    if #raidWinners == 0 then
        winnerLines[#winnerLines + 1] = "-"
    else
        for i, item in ipairs(raidWinners) do
            winnerLines[#winnerLines + 1] = i .. ". " .. getClassColoredName(item.name) .. " +" .. item.amount .. " (" .. item.rounds .. "x)"
        end
    end
    winnerLines[#winnerLines + 1] = ""
    winnerLines[#winnerLines + 1] = "[Party]"
    if #partyWinners == 0 then
        winnerLines[#winnerLines + 1] = "-"
    else
        for i, item in ipairs(partyWinners) do
            winnerLines[#winnerLines + 1] = i .. ". " .. getClassColoredName(item.name) .. " +" .. item.amount .. " (" .. item.rounds .. "x)"
        end
    end
    hallWinnersList:SetText(table.concat(winnerLines, "\n"))

    local loserLines = {}
    loserLines[#loserLines + 1] = "[Raid]"
    if #raidLosers == 0 then
        loserLines[#loserLines + 1] = "-"
    else
        for i, item in ipairs(raidLosers) do
            loserLines[#loserLines + 1] = i .. ". " .. getClassColoredName(item.name) .. " -" .. item.amount .. " (" .. item.rounds .. "x)"
        end
    end
    loserLines[#loserLines + 1] = ""
    loserLines[#loserLines + 1] = "[Party]"
    if #partyLosers == 0 then
        loserLines[#loserLines + 1] = "-"
    else
        for i, item in ipairs(partyLosers) do
            loserLines[#loserLines + 1] = i .. ". " .. getClassColoredName(item.name) .. " -" .. item.amount .. " (" .. item.rounds .. "x)"
        end
    end
    hallLosersList:SetText(table.concat(loserLines, "\n"))

    local today = date("%Y-%m-%d")
    if hallRecord.date ~= today then
        hallRecord.date = today
        hallRecord.players = {}
    end

    local championName, championAmount, championWon
    for playerName, entry in pairs(hallRecord.players or {}) do
        local net = (entry.won or 0) - (entry.lost or 0)
        local magnitude = math.abs(net)
        if magnitude > 0 and (not championAmount or magnitude > championAmount) then
            championAmount = magnitude
            championName = playerName
            championWon = net > 0
        end
    end

    if championName then
        local sign = championWon and "+" or "-"
        hallRecordText:SetText("Chlivak dne: " .. getClassColoredName(championName) .. " (" .. sign .. championAmount .. ")")
    else
        hallRecordText:SetText("Chlivak dne: -")
    end

    if hallAllTimeRecord.loser and hallAllTimeRecord.winner and (hallAllTimeRecord.amount or 0) > 0 then
        hallAllTimeRecordText:SetText("Absolutni rekord: " .. getClassColoredName(hallAllTimeRecord.loser) .. " dal " .. getClassColoredName(hallAllTimeRecord.winner) .. " " .. hallAllTimeRecord.amount .. " goldu")
    else
        hallAllTimeRecordText:SetText("Absolutni rekord: -")
    end

    local hallContentHeight = math.max(hallWinnersList:GetStringHeight(), hallLosersList:GetStringHeight(), hallScrollFrame:GetHeight())
    hallScrollChild:SetSize(hallScrollFrame:GetWidth(), hallContentHeight)
end

local function clearHallStats()
    playerStats.RAID = {}
    playerStats.PARTY = {}
    GambaTrackerDB.stats = {
        RAID = {},
        PARTY = {}
    }
    hallRecord.players = {}
    hallRecord.date = date("%Y-%m-%d")
    refreshHallStatsText()
end

StaticPopupDialogs["GAMBA_TRACKER_CLEAR_HALL"] = {
    text = "Do you really want to clear the Hall of Shame?",
    button1 = YES,
    button2 = NO,
    OnAccept = clearHallStats,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

local function recordRoundStats(loserName, winnerName, diff)
    if diff <= 0 then
        return
    end

    local bucketKey = getStatsBucketKey(currentGameChannel or getDefaultChannel())
    local loserStats = getOrCreatePlayerStats(bucketKey, loserName)
    local winnerStats = getOrCreatePlayerStats(bucketKey, winnerName)

    loserStats.lost = loserStats.lost + diff
    loserStats.losses = loserStats.losses + 1
    winnerStats.won = winnerStats.won + diff
    winnerStats.wins = winnerStats.wins + 1

    local today = date("%Y-%m-%d")
    if hallRecord.date ~= today then
        hallRecord.date = today
        hallRecord.players = {}
    end

    local loserEntry = hallRecord.players[loserName] or {won = 0, lost = 0}
    loserEntry.lost = (loserEntry.lost or 0) + diff
    hallRecord.players[loserName] = loserEntry

    local winnerEntry = hallRecord.players[winnerName] or {won = 0, lost = 0}
    winnerEntry.won = (winnerEntry.won or 0) + diff
    hallRecord.players[winnerName] = winnerEntry

    if diff > (hallAllTimeRecord.amount or 0) then
        hallAllTimeRecord.winner = winnerName
        hallAllTimeRecord.loser = loserName
        hallAllTimeRecord.amount = diff
    end

    saveHallStats()
    refreshHallStatsText()
end

local function exportHallStatsToChat()
    local raidWinners, raidLosers = buildStatsLists(playerStats.RAID)
    local partyWinners, partyLosers = buildStatsLists(playerStats.PARTY)
    local channel = currentGameChannel or getDefaultChannel()

    if #raidWinners == 0 and #raidLosers == 0 and #partyWinners == 0 and #partyLosers == 0 then
        SendChatMessage("Hall of Shame: zatim bez statistik.", channel)
        return
    end

    SendChatMessage("Hall of Shame statistika:", channel)

    SendChatMessage("RAID - Winners:", channel)
    if #raidWinners == 0 then
        SendChatMessage("-", channel)
    else
        for i, item in ipairs(raidWinners) do
            SendChatMessage(i .. ". " .. item.name .. " +" .. item.amount .. " (" .. item.rounds .. "x)", channel)
        end
    end

    SendChatMessage("RAID - Losers:", channel)
    if #raidLosers == 0 then
        SendChatMessage("-", channel)
    else
        for i, item in ipairs(raidLosers) do
            SendChatMessage(i .. ". " .. item.name .. " -" .. item.amount .. " (" .. item.rounds .. "x)", channel)
        end
    end

    SendChatMessage("PARTY - Winners:", channel)
    if #partyWinners == 0 then
        SendChatMessage("-", channel)
    else
        for i, item in ipairs(partyWinners) do
            SendChatMessage(i .. ". " .. item.name .. " +" .. item.amount .. " (" .. item.rounds .. "x)", channel)
        end
    end

    SendChatMessage("PARTY - Losers:", channel)
    if #partyLosers == 0 then
        SendChatMessage("-", channel)
    else
        for i, item in ipairs(partyLosers) do
            SendChatMessage(i .. ". " .. item.name .. " -" .. item.amount .. " (" .. item.rounds .. "x)", channel)
        end
    end
end

local function normalizePlayerName(sender)
    local senderText = tostring(sender or "")
    local shortName = string.match(senderText, "^[^-]+") or ""
    shortName = string.gsub(shortName, "^%s+", "")
    shortName = string.gsub(shortName, "%s+$", "")
    return shortName
end

local function resetRoundState()
    currentGameChannel = nil
    isSelfJoined = false
    isJoinOpen = false
    isRollingStarted = false
    roundResultAnnounced = false
    joinedPlayers = {}
    joinedPlayersLookup = {}
    joinedPlayersRolls = {}
    letsNumberInput:SetText("100000")
    refreshPlayersListText()
    if joinButton then
        joinButton:SetText("Join")
    end
end

StaticPopupDialogs["GAMBA_TRACKER_CONFIRM_RESET"] = {
    text = "Opravdu chces resetovat rozehrane kolo?",
    button1 = YES,
    button2 = NO,
    OnAccept = resetRoundState,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

local function allRegisteredPlayersHaveRoll()
    if #joinedPlayers == 0 then
        return true
    end

    for _, name in ipairs(joinedPlayers) do
        if not joinedPlayersRolls[name] then
            return false
        end
    end

    return true
end

local function addPlayerToList(playerName)
    if playerName == "" or joinedPlayersLookup[playerName] then
        return
    end
    joinedPlayersLookup[playerName] = true
    table.insert(joinedPlayers, playerName)
    roundResultAnnounced = false
    refreshPlayersListText()
end

local function removePlayerFromList(playerName)
    if playerName == "" or not joinedPlayersLookup[playerName] then
        return
    end

    joinedPlayersLookup[playerName] = nil
    joinedPlayersRolls[playerName] = nil
    for i, name in ipairs(joinedPlayers) do
        if name == playerName then
            table.remove(joinedPlayers, i)
            break
        end
    end
    roundResultAnnounced = false
    refreshPlayersListText()
end

local function handleJoinLeaveMessage(message, sender)
    local command = string.match(tostring(message or ""), "^%s*(.-)%s*$")
    if command ~= "1" and command ~= "-1" then
        return
    end

    if not isJoinOpen then
        return
    end

    local playerName = normalizePlayerName(sender)
    if command == "1" then
        addPlayerToList(playerName)
    else
        removePlayerFromList(playerName)
    end
end

local function handleSystemRollMessage(message)
    if not isRollingStarted then
        return
    end

    local msg = tostring(message or "")
    local rollerName, rollValue = string.match(msg, "^([^%s]+) rolls (%d+) %(%d+%-%d+%)$")
    if not rollerName or not rollValue then
        return
    end

    local playerName = normalizePlayerName(rollerName)
    if not joinedPlayersLookup[playerName] then
        return
    end

    if joinedPlayersRolls[playerName] then
        return
    end

    joinedPlayersRolls[playerName] = tonumber(rollValue)
    refreshPlayersListText()

    if roundResultAnnounced or #joinedPlayers == 0 then
        return
    end

    local minName
    local minRoll
    local maxName
    local maxRoll

    for _, name in ipairs(joinedPlayers) do
        local playerRoll = joinedPlayersRolls[name]
        if not playerRoll then
            return
        end

        if not minRoll or playerRoll < minRoll then
            minRoll = playerRoll
            minName = name
        end

        if not maxRoll or playerRoll > maxRoll then
            maxRoll = playerRoll
            maxName = name
        end
    end

    local diff = maxRoll - minRoll
    local channel = currentGameChannel or getDefaultChannel()
    SendChatMessage(string.format("Kostky rozhodly! %s dluzis %d goldu hraci %s. Zaplat a koukej se u toho usmivat :)", minName, diff, maxName), channel)
    recordRoundStats(minName, maxName, diff)
    roundResultAnnounced = true
end

local letsButtons = {}
local newGameButton
local joinButton
local lastCallButton
local startRollingButton
local rollMeButton
local resetButton

local buttonDefs = {
    {text = "New Game", x = 0, y = -40, w = 200},
    {text = "Join", x = 230, y = -40, w = 200},
    {text = "Last Call", x = 0, y = -78, w = 200},
    {text = "Start Rolling", x = 230, y = -78, w = 200},
    {text = "Roll Me", x = 0, y = -116, w = 200},
    {text = "Reset", x = 230, y = -116, w = 200}
}

for _, def in ipairs(buttonDefs) do
    local btn = CreateFrame("Button", nil, content, "BackdropTemplate")
    btn:SetSize(def.w, 30)
    btn:SetPoint("TOPLEFT", 14 + def.x, def.y)
    btn:SetText(def.text)
    btn:Hide()
    styleButton(btn)
    table.insert(letsButtons, btn)

    if def.text == "New Game" then
        newGameButton = btn
    elseif def.text == "Join" then
        joinButton = btn
    elseif def.text == "Last Call" then
        lastCallButton = btn
    elseif def.text == "Start Rolling" then
        startRollingButton = btn
    elseif def.text == "Roll Me" then
        rollMeButton = btn
    elseif def.text == "Reset" then
        resetButton = btn
    end
end

if newGameButton then
    newGameButton:SetScript("OnClick", function()
        if not allRegisteredPlayersHaveRoll() then
            if UIErrorsFrame then
                UIErrorsFrame:AddMessage("New Game nelze spustit: nekdo jeste nema roll.", 1, 0.2, 0.2)
            end
            return
        end

        local amount = formatAmountWithSpaces(letsNumberInput:GetText())
    local msg = string.format("Tak jo Chlivaci, zacina dalsi gamba! Hrajeme o %s goldu. Napis 1 do chatu a pridej se, nez to rozjedeme.", amount)

        local channel = getDefaultChannel()
        currentGameChannel = channel
        isSelfJoined = false
        isJoinOpen = true
        isRollingStarted = false
        roundResultAnnounced = false
        joinedPlayers = {}
        joinedPlayersLookup = {}
        joinedPlayersRolls = {}
        refreshPlayersListText()

        if joinButton then
            joinButton:SetText("Join")
        end

        SendChatMessage(msg, channel)
    end)
end

if joinButton then
    joinButton:SetScript("OnClick", function()
        local channel = currentGameChannel or getDefaultChannel()
        if not isJoinOpen then
            return
        end

        if not isSelfJoined then
            SendChatMessage("1", channel)
            isSelfJoined = true
            joinButton:SetText("Leave")
        else
            SendChatMessage("-1", channel)
            isSelfJoined = false
            joinButton:SetText("Join")
        end
    end)
end

if lastCallButton then
    lastCallButton:SetScript("OnClick", function()
        local channel = currentGameChannel or getDefaultChannel()
        SendChatMessage("Nebud srab a pridej se, je to posledni moznost!", channel)
    end)
end

if startRollingButton then
    startRollingButton:SetScript("OnClick", function()
        if #joinedPlayers < 2 then
            if UIErrorsFrame then
                UIErrorsFrame:AddMessage("Start Rolling nelze spustit: potreba alespon 2 hraci.", 1, 0.2, 0.2)
            end
            return
        end

        local channel = currentGameChannel or getDefaultChannel()
        isJoinOpen = false
        isRollingStarted = true
        SendChatMessage("Chlivaci, prihlasovani konci. Nastal cas hodit kostkou, vsichni rollujte!", channel)
    end)
end

if rollMeButton then
    rollMeButton:SetScript("OnClick", function()
        local amount = parseAmountNumber(letsNumberInput:GetText())
        RandomRoll(1, amount)
    end)
end

if resetButton then
    resetButton:SetScript("OnClick", function()
        if #joinedPlayers > 0 then
            StaticPopup_Show("GAMBA_TRACKER_CONFIRM_RESET")
        else
            resetRoundState()
        end
    end)
end

local hallExportButtonFrame = CreateFrame("Button", nil, content, "BackdropTemplate")
hallExportButtonFrame:SetSize(140, 26)
hallExportButtonFrame:SetPoint("TOPRIGHT", -18, -10)
hallExportButtonFrame:SetText("Export Stats")
hallExportButtonFrame:Hide()
styleButton(hallExportButtonFrame)
hallExportButtonFrame:SetScript("OnClick", function()
    exportHallStatsToChat()
end)

local hallClearButtonFrame = CreateFrame("Button", nil, content, "BackdropTemplate")
hallClearButtonFrame:SetSize(110, 26)
hallClearButtonFrame:SetPoint("TOPRIGHT", -170, -10)
hallClearButtonFrame:SetText("Clear")
hallClearButtonFrame:Hide()
styleButton(hallClearButtonFrame)
hallClearButtonFrame:SetScript("OnClick", function()
    StaticPopup_Show("GAMBA_TRACKER_CLEAR_HALL")
end)

local function applyTabStyles()
    if activeTab == "hall" then
        tab1:LockHighlight()
        tab1:GetFontString():SetTextColor(1, 0.9, 0.2, 1)
        tab2:UnlockHighlight()
        tab2:GetFontString():SetTextColor(0.9, 0.45, 0.2, 1)
    else
        tab1:UnlockHighlight()
        tab1:GetFontString():SetTextColor(0.9, 0.45, 0.2, 1)
        tab2:LockHighlight()
        tab2:GetFontString():SetTextColor(1, 0.9, 0.2, 1)
    end
end

local function render()
    if activeTab == "hall" then
        hallTitle:Show()
        hallWinnersTitle:Show()
        hallLosersTitle:Show()
        hallRecordText:Show()
        hallAllTimeRecordText:Show()
        hallScrollFrame:Show()
        hallExportButtonFrame:Show()
        hallClearButtonFrame:Show()

        letsTitle:Hide()
        letsNumberLabel:Hide()
        letsNumberInput:Hide()
        letsPlayersTitle:Hide()
        letsPlayersScrollFrame:Hide()
        for _, btn in ipairs(letsButtons) do
            btn:Hide()
        end
        applyTabStyles()
        return
    end

    hallTitle:Hide()
    hallWinnersTitle:Hide()
    hallLosersTitle:Hide()
    hallRecordText:Hide()
    hallAllTimeRecordText:Hide()
    hallScrollFrame:Hide()
    hallExportButtonFrame:Hide()
    hallClearButtonFrame:Hide()

    letsTitle:Show()
    letsNumberLabel:Show()
    letsNumberInput:Show()
    letsPlayersTitle:Show()
    letsPlayersScrollFrame:Show()
    for _, btn in ipairs(letsButtons) do
        btn:Show()
    end
    applyTabStyles()
end

local function setTab(tab)
    activeTab = tab
    render()
end

tab1:SetScript("OnClick", function() setTab("hall") end)
tab2:SetScript("OnClick", function() setTab("lets") end)

local function toggleFrame()
    frame:SetShown(not frame:IsShown())
    render()
end

local minimapButton
local function createMinimapButton()
    if minimapButton then
        return
    end

    if not Minimap then
        return
    end

    minimapButton = CreateFrame("Button", "GambaTrackerMinimapButton", Minimap)
    minimapButton:SetSize(32, 32)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetFrameLevel(8)
    minimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 14, -16)
    minimapButton:EnableMouse(true)
    minimapButton:RegisterForClicks("LeftButtonUp")
    minimapButton:SetScript("OnClick", function()
        toggleFrame()
    end)

    local tex = minimapButton:CreateTexture(nil, "ARTWORK")
    tex:SetAllPoints(minimapButton)
    tex:SetTexture("Interface\\Addons\\GambaTracker\\GambaTrackerIcon.tga")
    tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    local glow = minimapButton:CreateTexture(nil, "HIGHLIGHT")
    glow:SetAllPoints(minimapButton)
    glow:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    minimapButton:Show()
end

local addonFrame = CreateFrame("Frame")
addonFrame:RegisterEvent("PLAYER_LOGIN")
addonFrame:RegisterEvent("ADDON_LOADED")
addonFrame:RegisterEvent("CHAT_MSG_SAY")
addonFrame:RegisterEvent("CHAT_MSG_PARTY")
addonFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
addonFrame:RegisterEvent("CHAT_MSG_RAID")
addonFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")
addonFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
addonFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
addonFrame:RegisterEvent("CHAT_MSG_SYSTEM")
addonFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName ~= "GambaTracker" then
            return
        end

        ensureSavedStats()
        if not GambaTrackerDB.stats or not GambaTrackerDB.stats.RAID or not GambaTrackerDB.stats.PARTY then
            GambaTrackerDB.stats = {
                RAID = {},
                PARTY = {}
            }
        end
        playerStats.RAID = GambaTrackerDB.stats.RAID or {}
        playerStats.PARTY = GambaTrackerDB.stats.PARTY or {}
        createMinimapButton()
        refreshHallStatsText()
    elseif event == "PLAYER_LOGIN" then
        createMinimapButton()
    elseif event == "CHAT_MSG_SAY"
        or event == "CHAT_MSG_PARTY"
        or event == "CHAT_MSG_PARTY_LEADER"
        or event == "CHAT_MSG_RAID"
        or event == "CHAT_MSG_RAID_LEADER"
        or event == "CHAT_MSG_INSTANCE_CHAT"
        or event == "CHAT_MSG_INSTANCE_CHAT_LEADER" then
        local message, sender = ...
        handleJoinLeaveMessage(message, sender)
    elseif event == "CHAT_MSG_SYSTEM" then
        local message = ...
        handleSystemRollMessage(message)
    end
end)

createMinimapButton()
ensureSavedStats()
refreshHallStatsText()

-- catches the Chlivak dne midnight rollover even if the window stays open
C_Timer.NewTicker(60, refreshHallStatsText)

SLASH_GAMBA1 = "/gamba"
SlashCmdList["GAMBA"] = function()
    toggleFrame()
end

SLASH_GG1 = "/gg"
SlashCmdList["GG"] = function()
    toggleFrame()
end

refreshPlayersListText()
render()
