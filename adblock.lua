local blocklist_selling_actions = {"boost", "boosting", "selling", "sell", "wts", "gallywix", "discount", "sylvanas", "oblivion"}
local blocklist_selling_objects = {"m+", "mythic+", "vision", "mythic +", "aotc", "ce", "key", "curve", "cutting edge", "15+", "+15", "in time"}
local lastLineID = 0
local sessionBlockCounter = 0
local blockDuration = 60 * 5 -- block duplicate messages for 5 minutes
-- local whoTimer = 0
local tempBlocklist = {}

-- local function ResetTimer(timer)
-- 	timer = 0
-- end

-- local function SetTimer(timer)
-- 	timer = 1
-- 	C_Timer.After(5, ResetTimer(timer))
-- end

-- GLOBALS:  ADBLOCK_LOG, ADBLOCK_COUNTER, ADBLOCK_BLACKLIST, ADBLOCK_OPTIONS

local AdblockInitFrame = CreateFrame("FRAME"); -- Need a frame to respond to events
AdblockInitFrame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
AdblockInitFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

-- Copied with pride from Addon Badboy, kuddos to Funkydude!
local homographs = {
	--Symbol & weird space removal
	["[%*%-<>%(%)\"!%?=`'_%+#%%%^&;:~{}%[%]]"]="",
	["¨"]="", ["”"]="", ["“"]="", ["▄"]="", ["▀"]="", ["█"]="", ["▓"]="", ["▲"]="", ["◄"]="", ["►"]="", ["▼"]="", ["♣"]="",
	["░"]="", ["♥"]="", ["♫"]="", ["●"]="", ["■"]="", ["☼"]="", ["¤"]="", ["☺"]="", ["↑"]="", ["«"]="", ["»"]="", ["♦"]="",
	["▌"]="", ["▒"]="", ["□"]="", ["¬"]="", ["√"]="", ["²"]="", ["´"]="", ["☻"]="", ["★"]="", ["☆"]="", ["◙"]="", ["◘"]="",
	["¦"]="", ["|"]="", [";"]="", ["΅"]="", ["™"]="", ["。"]="", ["◆"]="", ["◇"]="", ["♠"]="", ["△"]="", ["¯"]="",
	["《"]="", ["》"]="", ["（"]="", ["）"]="", ["～"]="", ["—"]="", ["！"]="", ["："]="", ["·"]="", ["˙"]="", ["…"]="", ["　"]="",
	["▎"]="", ["▍"]="", ["▂"]="", ["▅"]="", ["▆"]="", ["＋"]="", ["‘"]="", ["’"]="", ["【"]="", ["】"]="", ["│"]="",

	--This is the replacement table. It serves to deobfuscate words by replacing letters with their English "equivalents".
	["а"]="a", ["à"]="a", ["á"]="a", ["ä"]="a", ["â"]="a", ["ã"]="a", ["å"]="a", -- First letter is Russian "\208\176". Convert > \97.
	["Ą"]="a", ["ą"]="a", ["Ā"]="a", ["ā"]="a", ["Ă"]="a", ["ă"]="a", -- Convert > \97. Note: Ą, Ā, Ă fail with strlower, include both.
	["с"]="c", ["ç"]="c", ["Ć"]="c", ["ć"]="c", ["Č"]="c", ["č"]="c", ["Ĉ"]="c", ["ĉ"]="c", ["Ċ"]="c", ["ċ"]="c", --First letter is Russian "\209\129". Convert > \99. Note: Ć, Č, Ĉ, Ċ fail with strlower, include both.
	["Ď"]="d", ["ď"]="d", ["Đ"]="d", ["đ"]="d", --Convert > \100. Note: Ď, Đ fail with strlower, include both.
	["е"]="e", ["è"]="e", ["é"]="e", ["ë"]="e", ["ё"]="e", ["ê"]="e", --First letter is Russian "\208\181". Convert > \101. 
	["Ę"]="e", ["ę"]="e", ["Ė"]="e", ["ė"]="e", ["Ě"]="e", ["ě"]="e", ["Ē"]="e", ["ē"]="e", ["Έ"]="e", ["έ"]="e", ["Ĕ"]="e", ["ĕ"]="e", ["Ε"]="e", ["ε"]="e", --Note: Ę, Ė, Ě, Ē, Έ, Ĕ, Ε fail with strlower, include both.
	["Ğ"]="g", ["ğ"]="g", ["Ĝ"]="g", ["ĝ"]="g", ["Ģ"]="g", ["ģ"]="g", ["Ġ"]="g", ["ġ"]="g", -- Convert > \103. Note: Ğ, Ĝ, Ģ, Ġ fail with strlower, include both.
	["Ĥ"]="h", ["ĥ"]="h", -- Convert > \104. Note: Ĥ fail with strlower, include both.
	["ì"]="i", ["í"]="i", ["ï"]="i", ["î"]="i", ["İ"]="i", ["ı"]="i", -- Convert > \105.
	["Ϊ"]="i", ["ϊ"]="i", ["Ι"]="i", ["ι"]="i", ["Ί"]="i", ["ί"]="i", ["Ĭ"]="i", ["ĭ"]="i", ["Ї"]="i", ["ї"]="i", --Convert > \105. -- Note: Ϊ, Ι, Ί, Ĭ, Ї fail with strlower, include both.
	["Į"]="i", ["į"]="i", ["Ĩ"]="i", ["ĩ"]="i", ["Ī"]="i", ["ī"]="i", ["Ｉ"]="i", ["ｉ"]="i", --Convert > \105. -- Note: Į, Ĩ, Ī, Ｉ fail with strlower, include both.
	["Ĵ"]="j", ["ĵ"]="j", -- Convert > \106. -- Note: Ĵ fail with strlower, include both.
	["к"]="k", ["Ķ"]="k", ["ķ"]="k", -- First letter is Russian "\208\186". Convert > \107. -- Note: Ķ fail with strlower, include both.
	["Ł"]="l", ["ł"]="l", ["Ĺ"]="l", ["ĺ"]="l", ["Ľ"]="l", ["ľ"]="l", -- Convert > \107. -- Note: Ł, Ĺ, Ľ fail with strlower, include both.
	["Μ"]="m", ["м"]="m", -- First letter is capital Greek μ "\206\156". Convert > \109
	["η"]="n", ["ή"]="n", ["ñ"]="n", ["Ν"]="n", -- First letter is small Greek eta η "\206\183". Convert > \110. 
	["Ń"]="n", ["ń"]="n", ["Ņ"]="n", ["ņ"]="n", ["Ň"]="n", ["ň"]="n", ["Ŋ"]="n", ["ŋ"]="n", --Convert > \110. Note: Ń, Ņ, Ň, Ŋ fail with strlower, include both.
	["о"]="o", ["ò"]="o", ["ó"]="o", ["ö"]="o", ["ô"]="o", ["õ"]="o", ["ø"]="o", ["σ"]="o", --First letter is Russian "\208\190". Convert > \111.
	["Ō"]="o", ["ō"]="o", ["Ǿ"]="o", ["ǿ"]="o", ["Ő"]="o", ["ő"]="o", ["Θ"]="o", ["θ"]="o", ["Ŏ"]="o", ["ŏ"]="o", ["Ｏ"]="o", ["ｏ"]="o", --Note: Ō, Ǿ, Ő, Θ, Ŏ, Ｏ fail with strlower, include both.
	["р"]="p", ["þ"]="p", ["φ"]="p", ["Ρ"]="p", ["ρ"]="p", --First letter is Russian "\209\128". Convert > \112. --Note: Ρ fail with strlower, include both.
	["Ｑ"]="q", ["ｑ"]="q", --Note: Ｑ fail with strlower, include both.
	["г"]="r", ["я"]="r", ["Ř"]="r", ["ř"]="r", ["Ŕ"]="r", ["ŕ"]="r", ["Ŗ"]="r", ["ŗ"]="r", --Convert > \114. -- Note: Ř, Ŕ, Ŗ fail with strlower, include both.
	["Ş"]="s", ["ş"]="s", ["Š"]="s", ["š"]="s", ["Ś"]="s", ["ś"]="s", ["Ŝ"]="s", ["ŝ"]="s", ["Ѕ"]="s", ["ѕ"]="s", --Convert > \115. -- Note: Ş, Š, Ś, Ŝ, Ѕ fail with strlower, include both.
	["т"]="t", ["Ŧ"]="t", ["ŧ"]="t", ["Τ"]="t", ["τ"]="t", ["Ţ"]="t", ["ţ"]="t", ["Ť"]="t", ["ť"]="t", --Convert > \116. -- Note: Ŧ, Τ, Ţ, Ť fail with strlower, include both.
	["ù"]="u", ["ú"]="u", ["ü"]="u", ["û"]="u", --Convert > \117.
	["Ų"]="u", ["ų"]="u", ["Ŭ"]="u", ["ŭ"]="u", ["Ů"]="u", ["ů"]="u", ["Ű"]="u", ["ű"]="u", ["Ū"]="u", ["ū"]="u", --Convert > \117. -- Note: Ų, Ŭ, Ů, Ű, Ū fail with strlower, include both.
	["ω"]="w", ["ώ"]="w", ["Ẃ"]="w", ["ẃ"]="w", ["Ẁ"]="w", ["ẁ"]="w", ["Ŵ"]="w", ["ŵ"]="w", ["Ẅ"]="w", ["ẅ"]="w", ["Ｗ"]="w", ["ｗ"]="w", -- First letter is small Greek omega Ώ "\207\142". Convert > \119. -- Note: Ẃ, Ẁ, Ŵ, Ẅ, Ｗ fail with strlower, include both.
	["у"]="y", ["ý"]="y", ["Ÿ"]="y", ["ÿ"]="y", -- First letter is Russian "\209\131". Convert > \121. -- Note: Ÿ fail with strlower, include both.
	["０"]="0", ["１"]="1", ["２"]="2", ["３"]="3", ["４"]="4", ["５"]="5", ["６"]="6", ["７"]="7", ["８"]="8", ["９"]="9",
	["•"]=".", ["·"]=".", ["，"]=",", ["º"]="o", ["®"]="r", ["○"]="o", ["†"]="t",
}

function AdblockInitFrame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" then
        -- Our saved variables are ready at this point. If there are none, variables will set to defaults.
        if ADBLOCK_LOG == nil then
            ADBLOCK_LOG = {};
        end
        
        if ADBLOCK_BLACKLIST == nil then
            ADBLOCK_BLACKLIST = {}
        end
        
        if ADBLOCK_COUNTER == nil then
            ADBLOCK_COUNTER = 0
        end
        
        if ADBLOCK_OPTIONS == nil then
            ADBLOCK_OPTIONS = {debug = false, verbose = false, autoBlock = false, proactive = false}
        end
        
        -- cleaning maintenance so the blocklog does not explode over time, removing messages older than 24 hours
        local currTick = GetTime()
        for k, v in pairs(ADBLOCK_LOG) do
            if (currTick - ADBLOCK_LOG[k]) > (3600 * 24) then
                table.remove(ADBLOCK_LOG, k)
            end
        end
    end

   -- Stuff to do when user logs out
   -- if event == "PLAYER_LOGOUT" then
   -- end
end
AdblockInitFrame:SetScript("OnEvent", AdblockInitFrame.OnEvent);

local function capitalize(str)
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

local function tempBlock(playerKey)
    if tempBlocklist[playerKey] then tempBlocklist[playerKey] = tempBlocklist[playerKey] + 1 else tempBlocklist[playerKey] = 0 end
    if debug then print("Tempblocklist for " .. playerKey .. ": " .. tempBlocklist[playerKey]) end
    if ADBLOCK_OPTIONS.autoBlock and tempBlocklist[playerKey] > 10 then -- this user is most likely a spammer with 10 identical messages at less than blockDuration from each other
        print("Adding player " .. playerKey .. " in the permanent blocklist.")
        ADBLOCK_BLACKLIST[playerKey] = true
    end
end

local function tradeSpamFilter(self, event, msg, author, _, channelName, _, _, channelID, _, _, _, lineID, ...)
     -- Ignore messages coming from outside trade (2) or say/yell/whispe (0)
     if (channelID ~= 0 and channelID ~= 2) then 
        return false
    end
    
    -- Handling the same message firing off the event multiple times
    if lineID == lastLineID then 
        return true
    end
    lastLineID = lineID -- todo: check for side effects with multiple chats

    if #msg <= 10 then -- not counting very short message which can be casual smileys/reactions like "lol"
        return false
    end

    -- now managing the heavy duty cases
 
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
    
    -- Test message
    if msg:find("adblock:tartanpion") then 
        if verbose then print("Blocked message from " .. author .. " for reason: Tartanpion") end
        if debug then print("|cffFF0000".. msg .."|r ") end
        sessionBlockCounter = sessionBlockCounter + 1
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        return true
    end

    
    -- user is part of blacklist and is automatically blocked
    if ADBLOCK_BLACKLIST[author] then 
        if verbose then print("Blocked message from " .. author .. " for reason: Blacklisted") end
        if debug then print("|cffFF0000".. msg .."|r ") end
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        sessionBlockCounter = sessionBlockCounter + 1
        return true
    end

    msg = string.gsub(msg, "|c[^%[]+%[([^%]]+)%]|h|r", "%1") -- Speed up processing messages with links by removing them (credit to Funkydude)
    msg = string.lower(msg)
    for k,v in next, homographs do -- canonizing message
		msg = string.gsub(msg, k, v)
	end
    



    -- if message contains obvious selling advertisement it will be automatically blocked regardless of it had been seen or not before
    if ADBLOCK_OPTIONS.proactive then 
        for i, selling_action in ipairs(blocklist_selling_actions) do
            if msg:find(selling_action) then
                for j, selling_object in ipairs(blocklist_selling_objects) do
                    if msg:find(selling_object) then -- very likely to be a advertisement message, proactively blocking it
                        if debug then print("Matching action:" .. selling_action .. " Matching object: " .. selling_object) end
                        if debug then print("|cffFF0000".. msg .."|r ") end
                        if verbose then print("Proactive adblock triggered for player " .. author) end
                        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
                        sessionBlockCounter = sessionBlockCounter + 1
                        tempBlock(author) -- Automatic blocking management
                        return true
                    end
                end
            end
        end
    end
    

    
    
    oldTick = ADBLOCK_LOG[hash]
    if debug then print(">> hash: " .. hash .. " currTick = " .. currTick .. " prevTick: " .. (ADBLOCK_LOG[hash] or "first time")) end
    if debug and oldTick then print("Prevmsg: " .. oldTick .. " (Delta: " .. currTick - oldTick .. ")") end
    
    if oldTick and (currTick - oldTick <= blockDuration) then -- duplicate message from the last 5 minutes
        if verbose then print("Blocked message from " .. author .. " for reason: Spamming") end
        ADBLOCK_COUNTER = ADBLOCK_COUNTER + 1
        sessionBlockCounter = sessionBlockCounter + 1
        ADBLOCK_LOG[hash] = currTick

        tempBlock(author) -- Automatic blocking management
        if debug then print("|cffFF0000".. msg .."|r ") end
        return true
    else
        ADBLOCK_LOG[hash] = currTick
        tempBlocklist[author] = 0 -- Will reset counter for well-behaved players
        return false
    end
    
    
    --[[
    if msg:find("lol") then
        return false, gsub(msg, "lol", ""), author, ...
    end
    --]]
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", tradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", tradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", tradeSpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", tradeSpamFilter)


SLASH_ADBLOCK1 = "/adblock"
SLASH_ADBLOCK2 = "/ab"

SlashCmdList["ADBLOCK"] = function(msg, editbox)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    if ADBLOCK_OPTIONS.debug then print("cmd: " .. (cmd or "RIEN")) end
    if ADBLOCK_OPTIONS.debug then print("args: " .. (args or "RIEN")) end
    if msg == "" then
        print("Adblock has blocked " .. sessionBlockCounter .. " messages this session, " .. ADBLOCK_COUNTER .. " in total!")
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
    elseif cmd == "proactive" and ADBLOCK_OPTIONS then
        if ADBLOCK_OPTIONS.proactive then
            print("Adblock: Turning off proactive adblock mode")
            ADBLOCK_OPTIONS.proactive = false
        else
            print("Adblock: Turning on proactive adblock mode")
            ADBLOCK_OPTIONS.proactive = true
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
            local player_to_block = capitalize(args)
            if not string.find(player_to_block, "-") then player_to_block = player_to_block .. "-" .. GetRealmName() end
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
            local player_to_block = capitalize(args)
            if not string.find(player_to_block, "-") then player_to_block = player_to_block .. "-" .. GetRealmName() end
            if ADBLOCK_BLACKLIST[player_to_block] then
                print("Adblock: Removing player " .. player_to_block .. " to the block list.")
                ADBLOCK_BLACKLIST[player_to_block] = nil
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
    else
        print("Adblock v0.1:")
        print("  - /adblock help: shows this help message")
        print("  - /adblock purge log: purge the spam log entirely")
        print("  - /adblock purge blocklist: purge the blocklist entirely")
        print("  - /adblock debug: Toggle debug messages")
        print("  - /adblock verbose: Toggle verbosity")
        print("  - /adblock autoblock: Toggle automating permanent block of repeated offenders")
        print("  - /adblock proactive: Toggle proactively blocking message looking like advertisement")
        print("  - /adblock show blacklist: Show current blacklist")
        print("  - /adblock block PLAYER_NAME: Block all future messages from PLAYER_NAME")
        print("  - /adblock unblock PLAYER_NAME: Remove PLAYER_NAME from blocklist")
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
    