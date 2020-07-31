local blocklist = {"boosting community", "wts gold"}
local lastLineID = 0
local sessionBlockCounter = 0
local blockDuration = 60 * 5 -- block duplicate messages for 5 minutes
local whoTimer = 0
local tempBlocklist = {}

local function ResetTimer(timer)
	timer = 0
end

local function SetTimer(timer)
	timer = 1
	C_Timer.After(5, ResetTimer(timer))
end

-- GLOBALS:  ADBLOCK_LOG, ADBLOCK_COUNTER, ADBLOCK_BLACKLIST, ADBLOCK_OPTIONS

local AdblockInitFrame = CreateFrame("FRAME"); -- Need a frame to respond to events
AdblockInitFrame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
AdblockInitFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

function AdblockInitFrame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" then
        -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
        if ADBLOCK_LOG == nil then
            ADBLOCK_LOG = {}; -- This is the first time this addon is loaded; initialize the count to 0.
        end
        
        if ADBLOCK_BLACKLIST == nil then
            ADBLOCK_BLACKLIST = {}
        end
        
        if ADBLOCK_COUNTER == nil then
            ADBLOCK_COUNTER = 0
        end
        
        if ADBLOCK_OPTIONS == nil then
            ADBLOCK_OPTIONS = {debug = false, verbose = false, autoBlock = false}
        end
        
        -- cleaning maintenance
        local currTick = GetTime()
        for k, v in pairs(ADBLOCK_LOG) do
            if (currTick - ADBLOCK_LOG[k]) > (3600 * 24) then
                table.remove(ADBLOCK_LOG, k)
            end
        end
        
    end
    
    -- Stuff to do when user logs out
    if event == "PLAYER_LOGOUT" then
        
    end
    
end
AdblockInitFrame:SetScript("OnEvent", AdblockInitFrame.OnEvent);

function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

local function StringHash(text)
    local counter = 1
    local len = string.len(text)
    for i = 1, len, 3 do 
        counter = math.fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
        (string.byte(text,i)*16776193) +
        ((string.byte(text,i+1) or (len-i+256))*8372226) +
        ((string.byte(text,i+2) or (len-i+256))*3932164)
    end
    return math.fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end

local function round(num)
    return num + (2^52 + 2^51) - (2^52 + 2^51)
end

local function TradeSpamFilter(self, event, msg, author, _, channelName, _, _, channelID, _, _, _, lineID, ...)
    local player = Ambiguate(author, "none")
    local playerKey = string.lower(player)
    --local hours, minutes = GetGameTime()
    local currTick = round(GetTime())
    local oldTick
    local hash = StringHash(author .. ":" .. msg)
    local verbose = false
    local debug = false

    
    if ADBLOCK_OPTIONS and ADBLOCK_OPTIONS.debug then
        debug = ADBLOCK_OPTIONS.debug
    end
    if ADBLOCK_OPTIONS and ADBLOCK_OPTIONS.verbose then
        verbose = ADBLOCK_OPTIONS.verbose
    end
    
    -- Ignore messages coming from outside trade (2) or say/yell/whispe (0)
    if (channelID ~= 0 and channelID ~= 2) then 
        return false
    end
    
    -- Handling the same message firing off the event multiple times
    if lineID == lastLineID then 
        return true
    end
    lastLineID = lineID
    
    -- Test message
    if msg:find("adblock:tartanpion") then 
        if verbose then print("Blocked message from " .. player .. " for reason: Tartanpion") end
        sessionBlockCounter = sessionBlockCounter + 1
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        return true
    end
    
    -- user is part of blacklist and is automatically blocked
    if ADBLOCK_BLACKLIST[playerKey] then 
        if verbose then print("Blocked message from " .. player .. " for reason: Blacklisted") end
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        sessionBlockCounter = sessionBlockCounter + 1
        return true
    end
    
    
    oldTick = ADBLOCK_LOG[hash]
    if debug then print(">> hash: " .. hash .. " currTick = " .. currTick .. " prevTick: " .. (ADBLOCK_LOG[hash] or "first time")) end
    if debug and oldTick then print("Prevmsg: " .. oldTick .. " (Delta: " .. currTick - oldTick .. ")") end
    
    if oldTick and (currTick - oldTick <= blockDuration) then -- duplicate message from the last 5 minutes
        if verbose then print("Blocked message from " .. player .. " for reason: Spamming") end
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        sessionBlockCounter = sessionBlockCounter + 1
        ADBLOCK_LOG[hash] = currTick

        if tempBlocklist[playerKey] then tempBlocklist[playerKey] = tempBlocklist[playerKey] + 1 else tempBlocklist[playerKey] = 0 end
        if debug then print("Tempblocklist for " .. player .. ": " .. tempBlocklist[playerKey]) end
        if ADBLOCK_OPTIONS.autoBlock and tempBlocklist[playerKey] > 10 then -- this user is most likely a spammer with 10 identical messages at less than blockDuration from each other
            print("Adding player " .. player .. "in the permanent blocklist.")
            ADBLOCK_BLACKLIST[playerKey] = true
        end
        return true
    else
        ADBLOCK_LOG[hash] = currTick
        tempBlocklist[playerKey] = 0 -- Will reset counter for well-behaved players
        return false
    end
    
    
    --[[
    if msg:find("lol") then
        return false, gsub(msg, "lol", ""), author, ...
    end
    --]]
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", TradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", TradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", TradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", TradeSpamFilter)


SLASH_ADBLOCK1 = "/adblock"
SLASH_ADBLOCK2 = "/ab"

SlashCmdList["ADBLOCK"] = function(msg, editbox)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    if ADBLOCK_OPTIONS.debug then print("cmd: " .. (cmd or "RIEN")) end
    if ADBLOCK_OPTIONS.debug then print("args: " .. (args or "RIEN")) end
    if msg == "" then
        print("Adblock has blocked " .. sessionBlockCounter .. " messages this session, " .. ADBLOCK_COUNTER .. " in total!")
    elseif cmd == "help" then
        print("Adblock v0.1:")
        print("  - /adblock help: shows this help message")
        print("  - /adblock purge log: purge the spam log entirely")
        print("  - /adblock purge blocklist: purge the blocklist entirely")
        print("  - /adblock debug: Toggle debug messages")
        print("  - /adblock verbose: Toggle verbosity")
        print("  - /adblock autoblock: Toggle automating permanent block of repeated offenders")
        print("  - /adblock show blacklist: Show current blacklist")
        print("  - /adblock block PLAYER_NAME: Block all future messages from PLAYER_NAME")
        print("  - /adblock unblock PLAYER_NAME: Remove PLAYER_NAME from blocklist")
    elseif cmd == "purge" then
        if args == "log" then
            print("Adblock: Purging spamlog")
            ADBLOCK_LOG = {}
        elseif args == "blocklist" then
            print("Adblock: Purging blocklist")
            ADBLOCK_BLACKLIST = {}
        else
            print("  - /adblock purge log: purge the spam log entirely")
            print("  - /adblock purge blocklist: purge the blocklist entirely")
        end
    elseif cmd == "debug" and ADBLOCK_OPTIONS then
        if ADBLOCK_OPTIONS.debug then
            print("Adblock: Turning off debug mode")
            ADBLOCK_OPTIONS.debug = false
        else
            print("Adblock: Turning on debug mode")
            ADBLOCK_OPTIONS.debug = true
        end
    elseif cmd == "verbose" and ADBLOCK_OPTIONS then
        if ADBLOCK_OPTIONS.verbose then
            print("Adblock: Turning off verbose mode")
            ADBLOCK_OPTIONS.verbose = false
        else
            print("Adblock: Turning on verbose mode")
            ADBLOCK_OPTIONS.verbose = true
        end
    elseif cmd == "block" then
        if args and args ~= "" then
            local player_to_block = string.lower(Ambiguate(args, "none"))
            if ADBLOCK_BLACKLIST[player_to_block] then
                print("Adblock: Player " .. player_to_block .. " is already blocked!")
            else
                print("Adblock: Adding player " .. player_to_block .. " to the block list.")
                ADBLOCK_BLACKLIST[player_to_block] = true
            end
        else 
            print("USAGE: /adblock block PLAYER_NAME: Block all future messages from PLAYER_NAME")
        end
    elseif cmd == "unblock" and args ~= "" then
        if args and args ~= "" then
            local player_to_block = string.lower(Ambiguate(args, "none"))
            if ADBLOCK_BLACKLIST[player_to_block] then
                print("Adblock: Removing player " .. player_to_block .. " to the block list.")
                table.remove(player_to_block)
            else
                print("Adblock: Player " .. player_to_block .. " was not in the blocklist!")
            end
        else 
            print("  - /adblock unblock PLAYER_NAME: Remove PLAYER_NAME from blocklist")
        end
    elseif cmd == "autoblock" then
        if ADBLOCK_OPTIONS.autoBlock then
            print("Turning off automatic Blacklisting")
            ADBLOCK_OPTIONS.autoBlock = false
        else
            print("Turning on automatic Blacklisting, bye bye spammers!")
            ADBLOCK_OPTIONS.autoBlock = true
        end
    elseif cmd == "show" then
        if args and args == "blacklist" then
            local alphalist = {}
            for k, v in pairs(ADBLOCK_BLACKLIST) do table.insert(alphalist, k) end
            table.sort(alphalist)
            print("Adblock: List of currently blacklisted users")
            for k, v in pairs(alphalist) do
                print(capitalize(v))
            end
            print(#alphalist .. " players blocked in total.")
        else
            print("  - /adblock show blacklist: Show current blacklist")
        end
    end
end
    
    
    
    --[[
    local function OldTradeSpamFilter(self, event, msg, author, _, channelName, _, _, channelID, _, _, _, lineID, ...)
        local lower = string.lower(msg)
        local player = Ambiguate(author, "none")
        local level = UnitLevel(player)
        local _, classname, classindex = UnitClass(player)
        local _, race = UnitRace(player)
        local alliedRaces =  { "VoidElf", "LightforgedDraenei", "HighmountainTauren", "Nightborne"}
        
        
        if (channelID ~= 0 and channelID ~= 2) then -- neither simple message nor trade
            return false
        end
        
        if lineID == lastLineID then
            return true
        end
        lastLineID = lineID
        
        if msg:find("tartanpion") then
            print("Blocked tartanpion from" .. player .. " (" .. classname .. " level " .. level .. ") for reason: Tartanpion")
            return true
        end
        
        
        
        if level == 1 or (level == 58 and classindex == 6) or (level == 98 and classindex == 12) then
            print("Blocked " .. player .. " (" ..  level .. ") for reason: Fresh toon")
            return true
        end
        
        if level == 20 then
            for i=1, #alliedRaces do
                if race == alliedRaces[i] then
                    print("Blocked " .. player .. " (" ..  level .. ") for reason: Fresh toon")
                end
            end
        end
        
        
        
        if msg:find("lol") then
            return false, gsub(msg, "lol", ""), author, ...
        end
        
    end
    --]]
    