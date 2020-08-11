local AB = select(2, ...)

-- Copied with pride from Addon Badboy, kuddos to Funkydude!
AB.symbols = {
    --Symbol & weird space removal
    ["[%*%-<>%(%)\"!%?=`'_%#%%%^&;:~{}%[%]]"]="",
    ["¨"]="", ["”"]="", ["“"]="", ["▄"]="", ["▀"]="", ["█"]="", ["▓"]="", ["▲"]="", ["◄"]="", ["►"]="", ["▼"]="", ["♣"]="",
    ["░"]="", ["♥"]="", ["♫"]="", ["●"]="", ["■"]="", ["☼"]="", ["¤"]="", ["☺"]="", ["↑"]="", ["«"]="", ["»"]="", ["♦"]="",
    ["▌"]="", ["▒"]="", ["□"]="", ["¬"]="", ["√"]="", ["²"]="", ["´"]="", ["☻"]="", ["★"]="", ["☆"]="", ["◙"]="", ["◘"]="",
    ["¦"]="", ["|"]="", [";"]="", ["΅"]="", ["™"]="", ["。"]="", ["◆"]="", ["◇"]="", ["♠"]="", ["△"]="", ["¯"]="",
    ["《"]="", ["》"]="", ["（"]="", ["）"]="", ["～"]="", ["—"]="", ["！"]="", ["："]="", ["·"]="", ["˙"]="", ["…"]="", ["　"]="",
    ["▎"]="", ["▍"]="", ["▂"]="", ["▅"]="", ["▆"]="", ["‘"]="", ["’"]="", ["【"]="", ["】"]="", ["│"]="", ["•"]=".", ["·"]=".", ["，"]=",", ["º"]="o", ["®"]="r",
}
AB.homographs = {    
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
    ["○"]="o", ["†"]="t",
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
        msg = msg:gsub(AB.EscapePatterns(keyword), "|cFFFF0000%1|r")
    end
    if prevcolor then
        msg = msg:gsub("|r", "|cFF" .. AB.COLOR_CODES[prevcolor])
    end
    return msg
end


function AB.EscapePatterns(text)
    local quotepattern = '(['..("%^$().[]*+-?"):gsub("(.)", "%%%1")..'])'
    
     return text:gsub(quotepattern, "%%%1")
end

function AB.GetFullName(name)
    local player = AB.capitalize(name)
    if not string.find(player, "-") then player = player .. "-" .. GetRealmName() end -- add realm if it's not already done
    return player:gsub(" ", "")
end

AB.success_sounds = {
    631204,	-- sound/creature/hiddenmaster/vo_hidden_master_success_01.ogg 	34e13434acf42408	6.0.1.18125 (Beta)	ogg		
    631206,	-- sound/creature/hiddenmaster/vo_hidden_master_success_02.ogg 	6752173e1df86e1a	6.0.1.18125 (Beta)	ogg		
    631208,	-- sound/creature/hiddenmaster/vo_hidden_master_success_03.ogg 	38cf37c1a0581aff	6.0.1.18125 (Beta)	ogg		
    631210,	-- sound/creature/hiddenmaster/vo_hidden_master_success_04.ogg 	
    631212,	-- sound/creature/hiddenmaster/vo_hidden_master_success_05.ogg 
    631214,	-- sound/creature/hiddenmaster/vo_hidden_master_success_06.ogg
}


AB.blocked_lineID = 0
function AB.ChatFilter(_,_,_,_,_,_,_,_,_,_,_,_,lineID, ...)
    if AB.blocked_lineID ~= lineID then
		return false
    else
        return true
    end
end

