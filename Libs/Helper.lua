local AB = select(2, ...)

-- Copied with pride from Addon Badboy, kuddos to Funkydude!
AB.homographs = {
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

function AB.capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function AB.stringHash(text)
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


function AB.round(num)
    return num + (2^52 + 2^51) - (2^52 + 2^51)
end

AB.COLOR_CODES = {
    red = "FF0000",
    green = "00FF00",
    blue = "0000FF",
    teal = "00FFFF",
    yellow = "FFFF00",
    orange = "FF8000",
    purple = "9933FF",
    pink = "FF00FF",
    grey = "C0C0C0",
    white = "FFFFFF",
    black = "000000"
}

function AB.C(text, color)
    color = color or "white"
    return "|cFF" .. AB.COLOR_CODES[color] .. text .. "|r"
end

function AB.Highlight(msg, highlights, prevcolor)
    for i, keyword in ipairs(highlights) do
        msg = msg:gsub(keyword, "|cFFFF0000%1|r")
    end
    if prevcolor then
        msg = msg:gsub("|r", "|cFF" .. AB.COLOR_CODES[prevcolor])
    end
    return msg
end


function AB.GetFullName(name)
    local player = AB.capitalize(name)
    if not string.find(player, "-") then player = player .. "-" .. GetRealmName() end -- add realm if it's not already done
    return player:gsub(" ", "")
end


function AB.ChatFilter(self, event, msg, author, _, channelName, _, _, channelID, _, _, _, lineID, ...)
    -- Handling the same message firing off the event multiple times
    if lineID == AB.last_lineID then 
        return true
    end
    AB.last_lineID  = lineID -- todo: check for side effects with multiple chats
    

    -- Ignore messages coming from outside General (1) trade (2), defense (3) or say/yell/whispe (0)
    if (channelID > 3) then 
        return false
    end

    -- Ignore messages from channels the user specifically filtered out
    if (channelID == 1 and not AdBlock.db.profile.scope.general) or (channelID == 3 and not AdBlock.db.profile.scope.trade) or (channelID == 1 and not AdBlock.db.profile.scope.defense) then
        return false
    end 

    -- Ignore messages from say/yell/whisp if the user especially filtered them out
    if (event == "CHAT_MSG_SAY" and not AdBlock.db.profile.scope.say) or (event == "CHAT_MSG_YELL" and not AdBlock.db.profile.scope.yell) or (event == "CHAT_MSG_WHISPER" and not AdBlock.db.profile.scope.whisp) then
        return false
    end

    if #msg <= 10 then -- not counting very short message which can be casual smileys/reactions like "lol"
        return false
    end

    local player = AB.GetFullName(author)
    -- user is part of whitelist and is automatically approved
    if AdBlock.db.profile.whitelist[player] then 
        AdBlock:PrintDebug("Ignoring message, player " .. AB.C(player, "teal") .. " is whitelisted")
        return false
    end

    -- friends and guildies are automatically approved as well
    for i, pal in ipairs(AdBlock.db.char.pals) do
        if player == pal then
            AdBlock:PrintDebug("Ignoring message, player " .. AB.C(player, "teal") .. " is a pal or yourself")
            return false
        end
    end
    
    local date = date()
    local hash = AB.stringHash(player .. ":" .. msg)

    -- user is part of blacklist and is automatically blocked
    if AdBlock.db.profile.blacklist[player] then
        if AdBlock.db.profile.audit then
            AdBlock:PrintAudit("I would have blocked message from " .. AB.C(player, "teal") .. " for reason: Blacklisted")
            return false
        else
            AdBlock:PrintInfo("Blocked message from " .. AB.C(player, "teal") .. " for reason: Blacklisted")
            AdBlock:PrintDebug(AB.C(msg, "grey"))
            AdBlock.db.profile.session_counter = AdBlock.db.profile.session_counter + 1
            AdBlock:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = "Blacklisted", channel = (channelID or event)})
            return true
        end
    end
    
    -- Test message
    if msg:find("adblock:test") then
        if AdBlock.db.profile.audit then
            AdBlock:PrintAudit("I would have blocked message from " .. AB.C(player, "teal") .. " for reason: " ..AB.C("Adblock Test String", "pink"))
            return false
        else
            AdBlock:PrintInfo("Blocked message from " .. AB.C(author, "teal") .. " for reason: " .. AB.C("Adblock Test String", "pink"))
            local debug_msg = AB.Highlight(msg, {"adblock:test"}, "grey")
            AdBlock:PrintDebug(AB.C(debug_msg, "grey"))
            AdBlock.db.profile.session_counter = AdBlock.db.profile.session_counter + 1
            AdBlock:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = "Test", channel = (channelID or event)})
            return true
        end
    end

    -- now managing the heavy duty cases
    
    --local hours, minutes = GetGameTime()
    --local month, day, year = select(2, C_DateAndTime.CalendarGetDate()) -- ignoring weekday
    

    local curr_tick = AB.round(GetTime())

    if AdBlock.db.profile.antispam.enabled then 
        local old_tick = AdBlock.db.profile.antispam.last_seen[hash]
        if old_tick then 
            AdBlock:PrintDebug("Hash: " .. AB.C(hash, "teal") .. " currTick = " .. AB.C(curr_tick, "teal") .. "prevTick = " .. AB.C(old_tick, "teal"))
            if (curr_tick - old_tick <= AdBlock.db.profile.antispam.threshold) then -- duplicate message in the "threshold" time window
                if AdBlock.db.profile.audit then
                    AdBlock:PrintAudit("I would have blocked message from " .. AB.C(player, "teal") .. " for reason: Spamming")
                    return false
                else
                    AdBlock:PrintInfo("Blocked message from " .. AB.C(player, "teal") .. " for reason: Spamming")
                    AdBlock.db.profile.antispam.last_seen[hash] = curr_tick -- updading last_seen so the threshold is a rolling time window
                    AdBlock:AddStrikes(player)
                    AdBlock.db.profile.session_counter = AdBlock.db.profile.session_counter + 1
                    AdBlock:PrintDebug(AB.C(msg, "grey"))
                    AdBlock:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = "Spamming", channel = (channelID or event)})
                    return true
                end
            else
                AdBlock:PrintDebug("Hash: " .. AB.C(hash, "teal") .. " currTick = " .. AB.C(curr_tick, "teal") .. "prevTick = " ..  AB.C("First time", "pink"))
                AdBlock.db.profile.antispam.last_seen[hash] = curr_tick
                if AdBlock.db.profile.strikelist[player] then AdBlock.db.profile.strikelist[player] = 0 end -- reseting counter for well-behaved players
                return false
            end
        else
            AdBlock.db.profile.antispam.last_seen[hash] = curr_tick
        end
    end
    
    
    -- if message contains obvious selling advertisement it will be automatically blocked regardless of it had been seen or not before
    if AdBlock.db.profile.proactive.enabled then -- AdBlock Heuristic part
        cleaned_msg = string.gsub(msg, "|c[^%[]+%[([^%]]+)%]|h|r", "%1") -- Speed up processing messages with links by removing them (credit to Funkydude)
        cleaned_msg = string.lower(cleaned_msg)
        for k,v in next, AB.homographs do -- canonizing message
            cleaned_msg = string.gsub(cleaned_msg, k, v)
        end

        if AdBlock:Heuristics(cleaned_msg) then
            if AdBlock.db.profile.audit then
                AdBlock:PrintAudit("I would have blocked message from " .. AB.C(player, "teal") .. " for reason: Advertising")
                return false
            else
                AdBlock:PrintInfo("Blocked message from " .. AB.C(player, "teal") .. " for reason: Advertising")
                AdBlock:AddStrikes(player)
                AdBlock.db.profile.session_counter = AdBlock.db.profile.session_counter + 1
                AdBlock:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = "Advertising", channel = (channelID or event)})
                return true
            end
        end
    end
end