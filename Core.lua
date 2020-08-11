AdBlock = LibStub("AceAddon-3.0"):NewAddon("AdBlock", "AceConsole-3.0",  "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AdBlock")
local AB = select(2, ...)
AB.last_lineID = 0 -- used to track chat line IDs being processed by the filter

local options = {
    name = "Adblock",
    handler = AdBlock,
    type = 'group',
    args = {
        header = {
            name = L["AdBlock allows you to block spam and advertisement messages from your chat. \n\nFiltering ads on the LFG tool is unfortunately not possible, but Blizzard do suspend those players so don't forget to report them!"],
            type = "description",
            image = "Interface\\AddOns\\AdBlock\\Textures\\Logo",
            imageWidth = 64,
            imageHeight = 64,
            fontSize = "medium",
            order = 5
        },

        help = {
            name = "Help",
            guiHidden = true,
            desc = "Show this help",
            type = "execute",
            order = 0,
            func = "ShowHelp"
        },
        enable = {
            name = L["Enable Addon"],
            desc = L["Enables/Disables the addon"],
            type = "toggle",
            order = 1,
            set = "ToggleAddon",
            get = function(info) return AdBlock.db.profile.enabled end
        },
        minimap = {
            name = L["Show Minimap Button"],
            desc = L["Toggle minimap button visibility"],
            type = "toggle",
            order = 2,
            set = "ToggleMinimapButton",
            get = function(info) return not AdBlock.db.profile.minimap.hide end
        },
        spacer = {
            name = "",
            type = "description",
            order = 3
        },
        stats = {
            name = L["Blocking Stats"],
            desc = L["Show how many ads or spam were blocked thanks to AdBlock"],
            type = "execute",
            order = 4,
            func = "GetStats",
        },
        tutorial = {
            name = L["Tutorial"],
            desc = L["Show the introduction message once more"],
            type = "execute",
            order = 4,
            func = "ShowTutorial",
        },
        autoblock = {
            name = L["Auto-Blacklist"],
            desc = L["Automatically blacklist repeated offenders"],
            type = "toggle",
            order = 12,
            set = function(info, val) AdBlock:ToggleMode(info, val, "autoblock") end,
            get = function(info) return AdBlock.db.profile.autoblock end
        },
        Block_ads = {
            name = L["Block Ads"],
            desc = L["Block detected ads using Adblock heuristics (while not in proactive, ads/spam are blocked at their second occurence)"],
            type = "toggle",
            order = 11,
            set = function(info, val) AdBlock:ToggleMode(info, val, "proactive") end,
            get = function(info) return AdBlock.db.profile.proactive.enabled end
        },
        block_spam = {
            name = L["Block Spam"],
            desc = L["When enabled, block message sent more than once over a specific timeframe"],
            type = "toggle",
            order = 10,
            set = function(info, val) AdBlock:ToggleMode(info, val, "antispam") end,
            get = function(info) return AdBlock.db.profile.antispam.enabled end
        },
        blacklist = {
            name = L["Blacklist"],
            type = "group",
            order = 12,
            args = {
                header = {
                    name = L["Add players that you want to always block, only applies to the channels you filter. \n\nIf you ticked \"Auto-Blacklist\", people that repeatedly Spam or send ads (more than 10 times) will automatically get added in your blacklist."],
                    type = "description",
                    order = 0,
                    fontSize = "medium",
                },
                add = {
                    name = L["Add"],
                    desc = L["Add player to permanent blacklist, you'll no longer see any message from them on channel where Adblock is active"],
                    order = 1,
                    type = "input",
                    get = function(info, val) return "" end,
                    set = "AddToBlacklist",
                    pattern = "",
                    usage = L["Playername OR Playername-Realm"]
                },
                remove = {
                    name = L["Remove"],
                    desc = L["Remove player from permanent blacklist, player will still be blocked through normal Adblock Antispam/antiAds heuristics"],
                    order = 2,
                    type = "select",
                    values = "GetBlacklist",
                    confirm = function(info, val) return "Remove " .. val .. " ?" end,
                    sorting = "GetBlacklistSortedKeys",
                    get = function(info, val) return "" end,
                    set = "RemoveFromBlacklist",
                    style = "dropdown"
                },
                show = {
                    name = L["Show Blacklist"],
                    desc = L["Show current Blacklist"],
                    order = 3,
                    type = "execute",
                    func = "ShowBlacklist",
                },
                purge = {
                    name = L["Purge"],
                    desc = L["Empty the blacklist"],
                    order = 4,
                    type = "execute",
                    confirm = "PurgeBlacklistConfirmation",
                    func = "PurgeBlacklist"
                }
            }
        },
        whitelist = {
            name = L["Whitelist"],
            type = "group",
            order = 13,
            args = {
                header = {
                    name = L["Add players you want to never be flagged as Spam or Advertisement.\n\nNo need to add friends or guildies, they will automatically be whitelisted as part of the \"Pals\""],
                    type = "description",
                    order = 0,
                    fontSize = "medium",
                },
                add = {
                    name = L["Add"],
                    desc = L["Add players to whitelist, you'll never block any message from them"],
                    order = 1,
                    type = "input",
                    get = function(info, val) return "" end,
                    set = "AddToWhitelist",
                    pattern = "",
                    usage = "Playername OR Playername-Realm"
                },
                remove = {
                    name = L["Remove"],
                    desc = L["Remove player from the whitelist, user will now be impacted by Adblock Antispam/antiAds heuristics"],
                    order = 2,
                    type = "select",
                    values = "GetWhitelist",
                    confirm = function(info, val) return "Remove " .. val .. " ?" end,
                    sorting = "GetWhitelistSortedKeys",
                    get = function(info, val) return "" end,
                    set = "RemoveFromWhitelist",
                    style = "dropdown"
                },
                show = {
                    name = L["Show Whitelist"],
                    desc = L["Show current whitelist"],
                    order = 3,
                    type = "execute",
                    func = "ShowWhitelist",
                },
                purge = {
                    name = L["Purge"],
                    desc = L["Empty the Whitelist"],
                    order = 4,
                    type = "execute",
                    confirm = "PurgeWhitelistConfirmation",
                    func = "PurgeWhitelist"
                },
                sync_pals = {
                    name = L["Sync Pals"],
                    desc = L["Refresh the friends and guildies list so Adblock never activates on them, automatically refreshed every few minutes"],
                    order = 5,
                    type = "execute",
                    func = "SyncPals"
                },
                show_pals = {
                    name = L["Show Pals"],
                    desc = L["Show the current list of piles"],
                    order = 6,
                    type = "execute",
                    func = "ShowPals"
                }
            }
        },
        proactive = {
            name = L["Ad-blocking keywords"],
            type = "group",
            order = 14,
            args = {
                description = {
                    name = L["Adblocking works like this: \n\nIf a message contains one of the \"Selling Action Keywords\" |cFFFF0000AND|r one of the \"Selling Object Keywords\", then it will be flagged as advertisement and blocked if you ticked \"Block ads\".\n\n This allows to block ads like \"WTS lvling boost\" while keeping trade messages like \"WTS Sky-Golem\"."],
                    type = "description",
                    fontSize = "medium",
                    order = 1
                },
                reset = {
                    name = L["Restore defaults"],
                    desc = L["Revert back to the default configuration"],
                    type = "execute",
                    order = 2,
                    func = "RestoreHeuristicKeywords"
                },
                selling_actions = {
                    name = L["Selling Action keywords"],
                    desc = L["Keywords to detect as an intent to sell"],
                    type = "input",
                    multiline = true,
                    width = "full",
                    order = 3,
                    get = "GetActionKeywords",
                    set = "SetActionKeywords",
                    pattern = "([^,]+)",
                    usage = "keyword1,keyword2,keyword3"
                },
                selling_objects = {
                    name = L["Selling Object keywords"],
                    desc = L["Keywords to detect as an object/service being sold"],
                    type = "input",
                    multiline = true,
                    width = "full",
                    order = 4,
                    get = "GetObjectKeywords",
                    set = "SetObjectKeywords",
                    pattern = "([^,]+)",
                    usage = "keyword1,keyword2,keyword3"
                },
                advanced_cleaning = {
                    name = L["Advance message cleaning"],
                    desc = L["If this option is activated, AdBlock will perform some aggressive message cleaning, such as removing homograph and special characters before doing the keyword detection. While this can be very helpful to avoid classic keyword detection strategies from spammers, this can break keyword detection in non english language making heavy use of accents or non-latin alphabet. Try deactivating this options if your keywords are not matched as they should."],
                    order = 5,
                    type = "toggle",
                    set = function(info, val) AdBlock.db.profile.proactive.advanced_cleaning = val end,
                    get = function(info) return AdBlock.db.profile.proactive.advanced_cleaning end
                }
            }
            
        },
        spam = {
            name = L["Anti-Spam"],
            type = 'group',
            order = 15,
            args = {
                header = {
                    name = L["Anti-Spam works as follows:\n\nIf a message is sent multiple times within <threshold> seconds by the same person on the same channel, then it is flagged as Spam and is blocked if you ticked \"Block Spam\""],
                    type = "description",
                    fontSize = "medium",
                    order = 0
                },
                threshold = 
                {
                    name = L["Threshold"],
                    desc = L["Minimum time (in seconds) between two identical message to not be identified as spam."],
                    type = "range",
                    order = 2,
                    min = 5,
                    softMin = 30,
                    softMax = 900,
                    max = 3600,
                    bigStep = 30,
                    set = function(info, val) AdBlock.db.profile.antispam.threshold = val end,
                    get = function(info) return AdBlock.db.profile.antispam.threshold end
                }
            }
        },
        history = {
            name = L["History"],
            type = "group",
            order = 16,
            args = {
                enable = {
                    name = L["Keep block history"],
                    desc = L["When enabled, blocked message are logged for future review"],
                    type = "toggle",
                    order = 1,
                    set = function(info, val) AdBlock:ToggleMode(info, val, "history") end,
                    get = function(info) return AdBlock.db.profile.history.enabled end
                },
                show = {
                    name = L["Show"],
                    desc = L["Show blocked message history for current user"],
                    type = "execute",
                    order = 2,
                    func = "ShowHistory"
                },
                limit = {
                    name = L["Maximum history size"],
                    desc = L["How many blocked messages are kept in the history"],
                    type = "range",
                    order = 3,
                    min = 5,
                    softMin = 10,
                    softMax = 100,
                    max = 500,
                    bigStep = 10,
                    set = "ChangeHistorySize",
                    get = function(info) return AdBlock.db.profile.history.size end
                },
                purge = {
                    name = L["Purge"],
                    desc = L["Purge blocked message history for current user"],
                    type = "execute",
                    confirm = function(info) return L["Purge the blocked messages history? This cannot be undone."] end,
                    order = 4,
                    func = "PurgeHistory"
                }
            }
        },
        audit = {
            name = L["Audit Mode"],
            desc = L["Announce what would have blocked and why without blocking anything. Useful for testing."],
            type = "toggle",
            order = 16,
            set = function(info, val) AdBlock:ToggleMode(info, val, "audit") end,
            get = function(info) return AdBlock.db.profile.audit end
        },
        mayhem = {
            name = L["Mayhem"],
            desc = L["Activate Mayhem mode (experimental), messing with spammers through whisps, please use it with caution (and fun!)"],
            type = "toggle",
            order = 17,
            hidden = true,
            confirm = "ConfirmMayhem",
            set = function(info, val) AdBlock:ToggleMode(info, val, "mayhem") end,
            get = function(info) return AdBlock.db.profile.mayhem end
        },
        verbose = {
            name = L["Verbose"],
            desc = L["Print out infos such as when a message is blocked and why."],
            type = "toggle",
            order = 15,
            set = function(info, val) AdBlock:ToggleMode(info, val, "verbose") end,
            get = function(info) return AdBlock.db.profile.verbose end
        },
        debug = {
            name = L["Debug"],
            desc = L["Print out extra information. Only use for debugging purpose, this can be very noisy."],
            type = "toggle",
            hidden = true,
            order = 40,
            set = function(info, val) AdBlock:ToggleMode(info, val, "debug") end,
            get = function(info) return AdBlock.db.profile.debug end
        },
        scope = {
            name = L["Filter the following channels:"],
            desc = L["Which channels/message types to activate AdBlock on"],
            type = "multiselect",
            order = 40,
            values = {
                general = L["General chat (/1)"],
                trade = L["Trade chat (/2)"],
                defense = L["General Defense chat (/3)"],
                lfg = L["LookingForGroup chat"],
                world = L["WorldDefense chat"],
                guild = L["GuildRecruitment chat"],
                say = L["Normal messages (/say)"],
                yell = L["Yell messages (/yell)"],
                whisp = L["Whispers (/w)"]
            },
            set = "SetScope",
            get = "GetScope"
        }   
    }
}

local defaults = {
    profile = {
      enabled = true,
      minimap = { hide = true},
      audit = false,
      debug = false,
      mayhem = false,
      autoblock = false,
      proactive = {
          enabled = true,
          selling_actions = {"sell", "wts", "gallywix", "discount", "sylvanas", "oblivion", "nova", "community", "free", "price"},
          selling_objects = {"boost", "m+", "mythic", "vision", "lvlup", "lvling", "levelup", "leveling", "aotc", " ce", "key", "curve", "cutting edge", "15+", "+15", "in time"},
          advanced_cleaning = true
      },
      antispam = {
          enabled = true,
          threshold = 300,
          last_seen = {}
      },
      history = {
          enabled = true,
          size = 50,
      },
      strikelist = {},
      blacklist = {},
      whitelist = {},
      verbose = false,
      scope = {
        general = true,
        trade = true,
        defense = true,
        lfg = true,
        world = true,
        guild = true,
        say = true,
        yell = true,
        whisp = false
      },
      session_counter = 0,
      global_counter = 0,
    },
    char = {
        pals = {},
        sync_timer = nil,
        history = {}
    },
    global = {
        tutorial = true,
    }
  }

function AdBlock:OnInitialize()
    -- Called when the addon is loaded
    self.db = LibStub("AceDB-3.0"):New("AdblockDB", defaults, true)
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    self.ui = LibStub("AceGUI-3.0")

    LibStub("AceConfig-3.0"):RegisterOptionsTable("AdBlock", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AdBlock", "AdBlock")
    self:RegisterChatCommand("adblock", "ChatCommand")
    self:RegisterChatCommand("ab", "ChatCommand")

    -- TODO: Add DB cleaning
    self:PrintInfo(L["Type /ab to access the config or /ab stats to see how many Ads and Spam Adblock spared you."])
    if self.db.profile.mayhem or self.db.profile.debug then
        options.args.mayhem.hidden = false
    end

    self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("AdBlock", {
        type = "data source",
        text = L["Left Click to Toggle addon"],
        icon = "Interface\\AddOns\\AdBlock\\Textures\\Logo",
        OnClick = function() InterfaceOptionsFrame_OpenToCategory(self.optionsFrame);InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) end
    })
    if not self.db.profile.enabled then self.ldb.icon = "Interface\\AddOns\\AdBlock\\Textures\\Logo-off" end
    self.icon = LibStub("LibDBIcon-1.0")
    self.icon:Register("AdBlock", self.ldb, self.db.profile.minimap)
    if self.db.profile.minimap.hide then self.icon:Hide("AdBlock") end

    self:SecureHook("Logout", "Logout")
    self:SecureHook("Quit", "Logout")

end


function AdBlock:ToggleMinimapButton(info, val)
    self.db.profile.minimap.hide = not val 
        
    if val then 
        self.icon:Show("AdBlock") 
        if self.db.profile.verbose then self:Print("Showing minimap button") end
    else 
        self.icon:Hide("AdBlock") 
        if self.db.profile.verbose then self:Print("Hiding minimap button") end

    end
end
function AdBlock:SyncPals()
    self.db.char.pals = {}
    local player
    local nb_friends = C_FriendList.GetNumFriends()
    if nb_friends then
        for i = 1, nb_friends do
            player = AB.GetFullName(C_FriendList.GetFriendInfoByIndex(i).name)  
            self.db.char.pals[player] = {name = player, origin = "a friend"}
            self:PrintDebug("Adding friend " .. AB.C(player, "teal"))
        end
    end
    if IsInGuild() then
        nb_friends = GetNumGuildMembers()
        if nb_friends then
            for i = 1, nb_friends do
                player = AB.GetFullName(GetGuildRosterInfo(i))
                self.db.char.pals[player] = {name = player, origin = "a guildie"}
                self:PrintDebug("Adding guildie " .. AB.C(player, "teal"))
            end
        end
    end
    player, _ = AB.GetFullName(UnitName("player"))
    self.db.char.pals[player] = {name = player, origin = "yourself"}
    self:PrintDebug("Adding current player " .. AB.C(player, "teal"))
end

function AdBlock:ConfirmMayhem(info, val)
   if val then 
        PlaySoundFile(552486, "Master");  -- 552486	sound/creature/illidan/black_illidan_05.ogg I can feel your hatred ;)
        return "Are you sure you want to activate Mayhem mode?" 
    else 
        return false 
    end
end


local adblock_events = {"CHAT_MSG_SAY", "CHAT_MSG_CHANNEL", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER"}

function AdBlock:OnEnable()
    -- Called when the addon is enabled
    if self.db.profile.enabled then
        self:SyncPals()
        self.db.char.sync_timer = self:ScheduleRepeatingTimer("SyncPals", 300)
        
        for e = 1, #adblock_events do
            local event = adblock_events[e]
            local frames = {GetFramesRegisteredForEvent(event)}
            for i = 1, #frames do
                local frame = frames[i]
                frame:UnregisterEvent(event)
            end
            self:RegisterEvent(event, "ChatFilterLogic")
            for i = 1, #frames do
                local frame = frames[i]
                frame:RegisterEvent(event)
            end
        end
        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", AB.ChatFilter)
        self:PrintInfo(L["Adblock is now enabled."])
        if not self.db.profile.minimap.hide then
            self.ldb.icon = "Interface\\AddOns\\AdBlock\\Textures\\Logo"
            self.icon:Refresh("AdBlock", ldb)
        end
    end
end


function AdBlock:OnDisable()
    -- Called when the addon is disabled
    for i = 1, #adblock_events do
        local event = adblock_events[i]
        self:UnregisterEvent(event, "ChatFilterLogic")
    end
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", AB.ChatFilter)
    if self.db.char.sync_timer then
        self:CancelTimer(self.db.char.sync_timer)
        self.db.char.sync_timer = nil
    end
    if not self.db.profile.minimap.hide then
        self.ldb.icon = "Interface\\AddOns\\AdBlock\\Textures\\Logo-off"
        self.icon:Refresh("AdBlock", ldb)
    end
    self:PrintInfo(L["Adblock is now disabled."])
end

function AdBlock:ShowHelp()
    LibStub("AceConfigCmd-3.0"):HandleCommand("ab", "AdBlock", "")
end

function AdBlock:Logout(...)
    self.db.profile.global_counter = self.db.profile.global_counter + self.db.profile.session_counter
    self.db.profile.session_counter = 0
    if self.db.char.sync_timer then
        self:CancelTimer(self.db.char.sync_timer)
        self.db.char.sync_timer = nil
    end
end

function AdBlock:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) -- Why twice? Because BlizzBugsSuck! https://www.wowinterface.com/forums/showthread.php?t=54599
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("ab", "AdBlock", input)
    end
end

function AdBlock:ToggleMode(info, val, mode)
    if mode == "antispam" then
        AdBlock.db.profile.antispam.enabled = val
    elseif mode == "proactive" then
        AdBlock.db.profile.proactive.enabled = val
    elseif mode == "debug" then
        if val then options.args.mayhem.hidden = false else options.args.mayhem.hidden = true end
        AdBlock.db.profile[mode] = val;
    else
        AdBlock.db.profile[mode] = val;
    end

    if mode == "mayhem" then
        if val then 
            PlaySoundFile(558780, "Master")  -- 	558780 sound/creature/ragnaros/vo_fl_ragnaros_purge_01.ogg By FIRE BE PURGED
            AdBlock:Print(AB.C(L["ACTIVATING MAYHEM MODE! LET'S FIGHT FIRE WITH FIRE"], "red"))
        else 
            PlaySoundFile(552520, "Master")  -- 	552520	sound/creature/illidan/black_illidan_14.ogg Is this it?
            AdBlock:Print(AB.C(L["Deactivating project mayhem, probably a good idea."]))
        end
    end

    if self.db.profile.verbose or mode == "verbose" then
        if val then
            AdBlock:Print(AB.capitalize(mode) .. " " .. L["mode activated."])
        else
            AdBlock:Print(AB.capitalize(mode) ..  " "  .. L["mode deactivated."])
        end
    end
end

function AdBlock:ToggleAddon(info, val)
    AdBlock.db.profile.enabled = val;
    if val then
        self:OnEnable()
    else
        self:OnDisable()
    end
end

function AdBlock:GetStats()
    self:Print(AB.C(self.db.profile.session_counter, "orange") .. " " .. L["messages blocked this session"] .. ", " .. AB.C(self.db.profile.global_counter, "orange") .. " " .. L["in total!"])
end

function AdBlock:SetScope(info, keyname, state)
    AdBlock.db.profile.scope[keyname] = state
    
    if self.db.profile.verbose then
        if state then
            AdBlock:Print(L["Adblock activated for"] .. " " .. keyname)
        else
            AdBlock:Print(L["Adblock disabled for"] .. " " .. keyname)
        end
    end
end

function AdBlock:GetScope(info, keyname)
    return AdBlock.db.profile.scope[keyname]
end

function AdBlock:GetActionKeywords(info)
    return table.concat(self.db.profile.proactive.selling_actions, ",")
end

function AdBlock:SetActionKeywords(info, val)
    self.db.profile.proactive.selling_actions = {}
    for keyword in val:gmatch('[^,]+') do
        table.insert(self.db.profile.proactive.selling_actions, keyword)
    end
end


function AdBlock:GetObjectKeywords(info)
    return table.concat(self.db.profile.proactive.selling_objects, ",")
end

function AdBlock:SetObjectKeywords(info, val)
    self.db.profile.proactive.selling_objects = {}
    for keyword in val:gmatch('[^,]+') do
        table.insert(self.db.profile.proactive.selling_objects, keyword)
    end
end

function AdBlock:GetBlacklist(info)
    local blacklisted_users = {}
    for k, v in pairs(self.db.profile.blacklist) do
        blacklisted_users[k] = k
    end
    return blacklisted_users
end

function AdBlock:GetBlacklistSortedKeys(info)
    local blacklisted_users = {}
    for k, v in pairs(self.db.profile.blacklist) do
        table.insert(blacklisted_users, k)
    end
    return table.sort(blacklisted_users)
end

function AdBlock:ShowBlacklist(info)
    local count = 0
    local bl_text = ""
    local blacklisted_users = {}
    for k, v in pairs(self.db.profile.blacklist) do
        table.insert(blacklisted_users, k)
    end
    table.sort(blacklisted_users)
    for k, v in pairs(blacklisted_users) do
        player = self.db.profile.blacklist[v]
        bl_text = bl_text .. AB.C(player.name, "red") .. " (" .. player.origin .. ")\n"
        count = count + 1
    end

    if info.uiType == "cmd" then
        self:Print(L["Blacklist"]..":")
        print(bl_text)
        
        if count then
            self:Print(AB.C(count, "teal") .. " " .. L["players found."])
        else
            self:Print(L["List is empty!"])
        end
    else -- GUI
        AB.blacklist_frame = self.ui:Create("Frame")
        AB.blacklist_frame:SetTitle(L["AdBlock - Blacklisted users"])
        AB.blacklist_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.blacklist_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText(L["Refresh"])
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(bl_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel(L["Blacklisted users:"] .. " " .. count)
        list_widget:SetFullHeight(true)
        list_widget:DisableButton(true)
        list_widget:SetNumLines(27)
        list_widget:SetFocus()
        AB.blacklist_frame:AddChild(list_widget)

        button:SetCallback("OnClick", function(widget) AdBlock.ui:Release(AB.blacklist_frame); AdBlock:ShowBlacklist({uiType = "dialog"}) end)
        AB.blacklist_frame:AddChild(button)
    end
    
end

function AdBlock:PurgeBlacklist(info)
    self.db.profile.blacklist = {}
end

function AdBlock:PurgeBlacklistConfirmation(info)
    if next(self.db.profile.blacklist) then -- trick to check if the blacklist contains at least one value
        return AB.C(L["[WARNING]"], "orange") .. " " .. L["Are you sure you want to purge the blacklist? This cannot be undone."]
    else
        return false
    end
end

function AdBlock:AddToBlacklist(info, val)
    local player = AB.GetFullName(val)
    
    if self.db.profile.blacklist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " " .. L["is already in the blacklist."])
    elseif self.db.profile.whitelist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " " .. L["is already in the whitelist, remove it from the whistelist first."])
    else
        self.db.profile.blacklist[player] = { name = player, origin = L["Manual"]}
    end 
end

function AdBlock:RemoveFromBlacklist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.blacklist[player] then
        self.db.profile.blacklist[player] = nil
    else
        self:PrintError(L["User"] .. " " .. AB.C(player, "teal") .. " " .. L["not found in the blacklist"])
    end
end

function AdBlock:GetWhitelist(info)
    local whitelisted_users = {}
    for k, v in pairs(self.db.profile.whitelist) do
        whitelisted_users[k] = k
    end
    return whitelisted_users
end

function AdBlock:GetWhitelistSortedKeys(info)
    local whitelisted_users = {}
    for k, v in pairs(self.db.profile.whitelist) do
        table.insert(whitelisted_users, k)
    end
    return table.sort(whitelisted_users)
end

function AdBlock:ShowWhitelist(info)
    local count = 0
    local wl_text = ""
    local whitelisted_users = {}
    for k, v in pairs(self.db.profile.whitelist) do
        table.insert(whitelisted_users, k)
    end
    table.sort(whitelisted_users)
    for k, v in pairs(whitelisted_users) do
        player = self.db.profile.whitelist[v]
        wl_text = wl_text .. AB.C(player.name, "green") .. " (" .. player.origin .. ")\n"
        count = count + 1
    end

    if info.uiType == "cmd" then
        self:Print(L["Whitelist:"])
        print(wl_text)
        
        if count then
            self:Print(AB.C(count, "teal") .. " ".. L["player(s) found."])
        else
            self:Print(L["List is empty!"])
        end
    else -- GUI
        AB.whitelist_frame = self.ui:Create("Frame")
        AB.whitelist_frame:SetTitle(L["AdBlock - Whitelisted users"])
        AB.whitelist_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.whitelist_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText(L["Refresh"])
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(wl_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel(L["Whitelisted users:"] .." " .. count)
        list_widget:SetFullHeight(true)
        list_widget:DisableButton(true)
        list_widget:SetNumLines(27)
        list_widget:SetFocus()
        AB.whitelist_frame:AddChild(list_widget)

        button:SetCallback("OnClick", function(widget) AdBlock.ui:Release(AB.whitelist_frame); AdBlock:ShowWhitelist({uiType = "dialog"}) end)
        AB.whitelist_frame:AddChild(button)
    end
    
end

function AdBlock:ShowPals(info)
    local count = 0
    local pals_text = ""
    local pals_users = {}
    for k, v in pairs(self.db.char.pals) do
        table.insert(pals_users, k)
    end
    table.sort(pals_users)
    for k, v in pairs(pals_users) do
        player = self.db.char.pals[v]
        pals_text = pals_text .. AB.C(player.name, "teal") .. " (" .. player.origin .. ")\n"
        count = count + 1
    end

    if info.uiType == "cmd" then
        self:Print("Pals list:")
        print(pals_text)
        
        if count then
            self:Print(AB.C(count, "teal") .. " " .. L["player(s) found."])
        else
            self:Print(L["List is empty!"])
        end
    else -- GUI
        AB.pals_frame = self.ui:Create("Frame")
        AB.pals_frame:SetTitle(L["AdBlock - List of pals (friends and guildies)"])
        AB.pals_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.pals_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText(L["Refresh"])
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(pals_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel(L["Pals in total:"] .. " " .. count)
        list_widget:SetFullHeight(true)
        list_widget:DisableButton(true)
        list_widget:SetNumLines(27)
        list_widget:SetFocus()
        AB.pals_frame:AddChild(list_widget)

        button:SetCallback("OnClick", function(widget) AdBlock.ui:Release(AB.pals_frame); AdBlock:SyncPals(); AdBlock:ShowPals({uiType = "dialog"}) end)
        AB.pals_frame:AddChild(button)
    end


end

function AdBlock:PurgeWhitelist(info)
    self.db.profile.whitelist = {}
end

function AdBlock:PurgeWhitelistConfirmation(info)
    if next(self.db.profile.whitelist) then -- trick to check if the blacklist contains at least one value
        return AB.C(L["[WARNING]"], "orange") .. " " .. L["Are you sure you want to purge the whitelist? This cannot be undone."]
    else
        return false
    end
end

function AdBlock:AddToWhitelist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.whitelist[player] then
        self:PrintError(L["User"] .. " ".. AB.C(player, "teal") .. " " .. L["is already in the Whitelist"])
    elseif self.db.profile.blacklist[player] then
        self:PrintError(L["User"] .. " " .. AB.C(player, "teal") .. " " .. L["is already in the blacklist, remove it from the blacklist first."])
    else
        self:PrintInfo(L["User"] .. " " .. AB.C(player, "teal") .. " " .. L["added in the whitelist"])
        self.db.profile.whitelist[player] = { name = player, origin = "manual"}
    end 
end

function AdBlock:RemoveFromWhitelist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.whitelist[player] then
        self.db.profile.whitelist[player] = nil
    else
        self:PrintError(L["User"] .. " " .. AB.C(player, "teal") .. " " .. L["not found in the whitelist"])
    end
end

function AdBlock:PrintError(text)
    self:Print(AB.C(L["[ERROR]"] , "red") ..  " " .. (text or "<<NIL>>"))
end

function AdBlock:PrintWarning(text)
    self:Print(AB.C(L["[WARNING]"], "orange") .. " " ..  (text or "<<NIL>>"))
end

function AdBlock:PrintInfo(text)
    if self.db.profile.verbose then
        self:Print(AB.C(L["[INFO]"], "grey") .. " " .. (text or "<<NIL>>"))
    end
end

function AdBlock:PrintAudit(text)
    if self.db.profile.audit then
        self:Print(AB.C(L["[AUDIT]"], "green") ..  " " .. (text or "<<NIL>>"))
    end
end

function AdBlock:PrintDebug(text)
    if self.db.profile.debug then
        self:Print(AB.C(L["[DEBUG]"], "orange") .. " " .. (text or "<<NIL>>"))
    end
end

function AdBlock:Heuristics(msg)
    for i, selling_action in ipairs(self.db.profile.proactive.selling_actions) do
        if msg:find(selling_action) then
            for j, selling_object in ipairs(self.db.profile.proactive.selling_objects) do
                if msg:find(selling_object) then -- very likely to be a advertisement message, proactively blocking it
                    local debug_msg = AB.Highlight(msg, {selling_action, selling_object}, "grey")
                    self:PrintDebug(AB.C(debug_msg, "grey"))
                    return true, {action = selling_action, object = selling_object}
                end
            end
        end
    end
    return false
end

function AdBlock:AddStrikes(player) 
    if self.db.profile.strikelist[player] then 
        self.db.profile.strikelist[player] = self.db.profile.strikelist[player] + 1 
    else 
        self.db.profile.strikelist[player] = 1 
    end
    
    self:PrintDebug(L["Adding 1 strike to"] .. " ".. AB.C(player, "teal") .. " (" .. self.db.profile.strikelist[player] .. " " .. L["strikes total"] .. ")")
    if self.db.profile.autoblock and self.db.profile.strikelist[player] > 10 then -- this user is most likely a spammer with 10 identical messages at less than blockDuration from each other
        self:PrintInfo(L["Adding player"] .. " " .. AB.C(player, "teal") .. " " .. L["in the permanent blocklist after 10 strikes."])
        self.db.profile.blacklist[player] = { name = player, origin = "autoblock" }
    end
end


function AdBlock:GetHistoryText()
    local history_text = ""
    for index = 1, #self.db.char.history do
        local v = self.db.char.history[index]
        history_text = history_text .. AB.C("---------- " .. L["Entry"] .. " " .. index .. " ".. L["blocked for reason:"] .. " " .. v.reason .. "\n", "red")
        history_text = history_text .. "[" ..  AB.C(v.channel, "yellow") .. "] [" .. AB.C(v.last_seen, "orange") .. "] [" .. AB.C(v.author, "teal") .. "]:"
        history_text = history_text .. AB.C(v.msg, "white") .. "\n\n"
    end
    return history_text
end

function AdBlock:ShowHistory(info)
-- buffer[1] contains the newest item
-- buffer[#buffer] contains the oldest item.
-- To iterate in insertion order:

    if info.uiType == "cmd" then

        for index = #self.db.char.history, 1, -1 do
            local v = self.db.char.history[index]
            self:Print("---------- " .. L["Entry "] .. index .. " ".. L["blocked for reason:"] .. v.reason)
            print("[" ..  AB.C(v.channel, "yellow") .. "] [" .. AB.C(v.last_seen, "orange") .. "] [" .. AB.C(v.author, "teal") .. "]:")
            print(AB.C(v.msg, "white"))
        end
    else
        AB.history_frame = self.ui:Create("Frame")
        AB.history_frame:SetTitle(L["AdBlock - Blocked Messages History"])
        AB.history_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.history_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText(L["Refresh"])
        button:SetWidth(200)
        local history_widget = self.ui:Create("MultiLineEditBox")
        local history_text = self:GetHistoryText()

        history_widget:SetText(history_text)
        history_widget:SetRelativeWidth(1)
        history_widget:SetLabel("Last " .. self.db.profile.history.size .. " " .. L["blocked messages"])
        history_widget:SetFullHeight(true)
        history_widget:DisableButton(true)
        history_widget:SetNumLines(27)
        history_widget:SetFocus()
        AB.history_frame:AddChild(history_widget)

        button:SetCallback("OnClick", function(widget) AdBlock.ui:Release(AB.history_frame); AdBlock:ShowHistory({uiType = "dialog"}) end)
        AB.history_frame:AddChild(button)
    end
end

function AdBlock:AddToHistory(entry)
    if self.db.profile.history.enabled then
        if entry.channel == 1 then entry.channel = L["General"] end
        if entry.channel == 2 then entry.channel = L["Trade"] end
        if entry.channel == 3 then entry.channel = L["Defense"] end
        if entry.channel == "CHAT_MSG_SAY" then entry.channel = L["Say"] end
        if entry.channel == "CHAT_MSG_YELL" then entry.channel = L["Yell"] end
        if entry.channel == "CHAT_MSG_WHISPER" then entry.channel = L["Whisper"] end

        table.insert(self.db.char.history, 1, entry)
        self.db.char.history[self.db.profile.history.size + 1] = nil
        self:PrintDebug(L["Adding entry"] .. " " .. AB.C(entry.hash, "teal") .. " " .. L["in history log"])
    end
end

function AdBlock:PurgeHistory(info)
    self:PrintInfo(L["History purged"])
    self.db.char.history = {}
end

function AdBlock:ShowTutorial(info)
    self.db.global.tutorial = false
    local frame = self.ui:Create("Frame")
    frame:SetTitle(L["Welcome to AdBlock!"])
    frame:SetStatusText(L["AdBlock tutorial"])
    frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
    frame:SetLayout("List")

    local intro = self.ui:Create("Label")
    intro:SetText(L["World of Warcraft is turning like the rest of the internet, full of Boosting messages in chat, whispers, LFG tool, etc. As Blizzard is not doing anything about it, let's filter the clutter ourselves!"] .. "\n\n")
    intro:SetRelativeWidth(1)
    intro:SetFont("Fonts\\FRIZQT__.TTF", 12)

    frame:AddChild(intro)
    local features_header = self.ui:Create("Label")
    features_header:SetText(L["Current features:"] .. "\n")
    features_header:SetFont("Fonts\\FRIZQT__.TTF", 14, THICKOUTLINE)

    features_header:SetRelativeWidth(1)
    frame:AddChild(features_header)
    local features = self.ui:Create("Label")
    features:SetText("   * " .. L["Block Spam: Automatically block messages sent more than once from the same user within defined timeframe (default to 5 min) in General Chat/Trade/Say/Yell/Whisper"] .. "\n   * " .. L["Block Ads aka Proactive mode: Aggressively blocks obvious boosting messages from the first occurence"] .. "\n   * " .. L["Blacklist users to be permanently filtered out of your chat"] .. "\n   * " .. L["Whitelist users to always be allowed (automatically done for friends and guildies)"] .. "\n   * " .. L["Audit mode: Try out AdBlock to see what it would block without actually blocking anything"] .. "\n   * " .. L["Autoblock mode: adds to the permanent blocklist repeating offenders"] .. "\n   * " .. L["Show how many messages were blocked this session/overall"])
    features:SetFont("Fonts\\FRIZQT__.TTF", 12)
    features:SetRelativeWidth(1)
    frame:AddChild(features)

    local usage_header = self.ui:Create("Label")
    usage_header:SetText(L["Recommended usage:"] .. "\n")
    usage_header:SetFont("Fonts\\FRIZQT__.TTF", 14, THICKOUTLINE)
    usage_header:SetRelativeWidth(1)
    frame:AddChild(usage_header)
    local usage = self.ui:Create("Label")
    usage:SetText("   * " .. L["Type in /s \"adblock:test\" to make sure the addon works"] .. "\n   * " .. L["Type /ab  or click on the button below and start fine-tuning the AdBlock to your taste"] .. "\n   * " .. L["If you're a bit scared of blocking important stuff:"] .. "\n     * " .. L["Activate \"Audit\" to make sure it would not block messages you would like to keep"] .. "\n     * " .. L["Later, remove Audit and switch to Verbose to see when messages are being blocked"] .. "\n     * " .. L["You can see blocked message history at any time in the settings or via /ab history show"] .. "\n   * " .. L["Finally, you can activate Auto-Blacklist to permanently mute players that repeatedly trigger Adblock"] .. "\n\n")
    usage:SetFont("Fonts\\FRIZQT__.TTF", 12)

    usage:SetRelativeWidth(1)
    frame:AddChild(usage)

    local button = self.ui:Create("Button")
    button:SetText(L["Ok, show me the options!"])
    button:SetRelativeWidth(1)
    button:SetCallback("OnClick", function()  InterfaceOptionsFrame_OpenToCategory(self.optionsFrame); InterfaceOptionsFrame_OpenToCategory(self.optionsFrame); AdBlock.ui:Release(frame)  end)
    frame:AddChild(button)
end




function AdBlock:RestoreHeuristicKeywords()
    self.db.profile.proactive.selling_actions = defaults.profile.proactive.selling_actions
    self.db.profile.proactive.selling_objects = defaults.profile.proactive.selling_objects
end

function AdBlock:ChangeHistorySize(info, val)
    local prev_size = AdBlock.db.profile.history.size
    self.db.profile.history.size = val
    if prev_size > val then
        for i = val, prev_size do
            self.db.char.history[i] = nil
        end
    end
end

function AdBlock:ChatFilterLogic(event, msg, author, lang, channelName, current_player, author_status, channelID, channel_num, channel_name, arg1, lineID, guid, arg2, arg3, ...)
    AB.last_lineID  = lineID -- todo: check for side effects with multiple chats

    if IsEncounterInProgress() then -- Very unlikely you'll get spam in the middle of a raid fight, and let's keep our CPU for the mechanics
        return false
    end

    -- Ignore messages from channels the user specifically filtered out
    -- https://wow.tools/dbc/?dbc=chatchannels&build=1.13.5.35395#page=1 thanks Spaten
    if (channelID == 1 and not self.db.profile.scope.general) or (channelID == 2 and not self.db.profile.scope.trade) or (channelID == 22 and not self.db.profile.scope.defense) or (channelID == 23 and not self.db.profile.scope.world) or (channelID == 24 and not self.db.profile.scope.lfg) or (channelID == 25 and not self.db.profile.scope.guild) then        
        return false
    end 

    -- Ignore messages from say/yell/whisp if the user especially filtered them out
    if (event == "CHAT_MSG_SAY" and not self.db.profile.scope.say) or (event == "CHAT_MSG_YELL" and not self.db.profile.scope.yell) or (event == "CHAT_MSG_WHISPER" and not self.db.profile.scope.whisp) then
        return false
    end

    if #msg <= 10 then -- not counting very short message which can be casual smileys/reactions like "lol"
        return false
    end



    -- Not filtering Raid members, party members, DEVS and Game Masters
    if UnitInRaid(author) or UnitInParty(author) or author_status == "GM" or author_status == "DEV" then
		return false
	end


    local player = AB.GetFullName(author)
    -- user is part of whitelist and is automatically approved
    if self.db.profile.whitelist[player] then 
        self:PrintDebug("Ignoring message, player " .. AB.C(player, "teal") .. " is whitelisted")
        return false
    end

    local date = date()
    local hash = AB.stringHash(player .. ":" .. msg)

        -- Test message
    if msg:find("adblock:test") then
        if self.db.profile.audit then
            self:PrintAudit("I would have blocked message from " .. AB.C(player, "teal") .. " for reason: " ..AB.C("Adblock Test String", "pink"))
            return false
        else
            self:PrintInfo("Blocked message from " .. AB.C(author, "teal") .. " for reason: " .. AB.C("Adblock Test String", "pink"))
            local debug_msg = AB.Highlight(msg, {"adblock:test"}, "grey")
            self:PrintDebug(AB.C(debug_msg, "grey"))
            self.db.profile.session_counter = self.db.profile.session_counter + 1
            self:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = "Test", channel = (channelID or event)})
            if author == current_player then -- test message send by yourself
                PlaySoundFile(AB.success_sounds[math.random(#AB.success_sounds)], "Master")
            end
            AB.blocked_lineID = lineID
            return true
        end
    end

    -- special case for BnetFriends not showing up in the friendlist
    if event == "CHAT_MSG_WHISPER" then
        local _, bnet_friend = BNGetGameAccountInfoByGUID(guid) 
        if bnet_friend then
            return false
        end
    end

    -- friends and guildies are automatically approved as well
    if self.db.char.pals[player] then 
        self:PrintDebug("Ignoring message, player " .. AB.C(player, "teal") .. " is " .. self.db.char.pals[player].origin)
        return false
    end


    -- user is part of blacklist and is automatically blocked
    if self.db.profile.blacklist[player] then
        if self.db.profile.audit then
            self:PrintAudit(L["I would have blocked message from"] .. " " .. AB.C(player, "teal") .. " " .. L["for reason:"] .. " " .. L["Blacklisted"])
            return false
        else
            self:PrintInfo(L["Blocked message from"] .. " " .. AB.C(player, "teal") .. " " .. L["for reason:"] .. " " .. L["Blacklisted"])
            self:PrintDebug(AB.C(msg, "grey"))
            self.db.profile.session_counter = self.db.profile.session_counter + 1
            self:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = L["Blacklisted"], channel = (channelID or event)})
            AB.blocked_lineID = lineID
            return true
        end
    end
    


    -- now managing the heavy duty cases
    
    --local hours, minutes = GetGameTime()
    --local month, day, year = select(2, C_DateAndTime.CalendarGetDate()) -- ignoring weekday
    

    local curr_tick = AB.round(GetTime())

    if self.db.profile.antispam.enabled then 
        local old_tick = self.db.profile.antispam.last_seen[hash]
        if old_tick then 
            self:PrintDebug("Hash=" .. AB.C(hash, "teal") .. " " .. "currTick=" .. AB.C(curr_tick, "teal") .. " " .. "prevTick=" .. AB.C(old_tick, "teal"))
            if (curr_tick - old_tick <= self.db.profile.antispam.threshold) then -- duplicate message in the "threshold" time window
                if self.db.profile.audit then
                    self:PrintAudit(L["I would have blocked message from"] .." " .. AB.C(player, "teal") .. " " .. L["for reason:"] .. " " .. L["Spamming"])
                    return false
                else
                    self:PrintInfo(L["Blocked message from"] .. " " .. AB.C(player, "teal") .. " " .. L["for reason:"] .. " " .. L["Spamming"])
                    self.db.profile.antispam.last_seen[hash] = curr_tick -- updading last_seen so the threshold is a rolling time window
                    self:AddStrikes(player)
                    self.db.profile.session_counter = self.db.profile.session_counter + 1
                    self:PrintDebug(AB.C(msg, "grey"))
                    self:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = L["Spamming"], channel = (channelID or event)})
                    AB.blocked_lineID = lineID
                    return true
                end
            else
                self.db.profile.antispam.last_seen[hash] = curr_tick
                if self.db.profile.strikelist[player] then self.db.profile.strikelist[player] = 0 end -- reseting counter for well-behaved players
            end
        else
            self:PrintDebug("Hash=" .. AB.C(hash, "teal") .. " " .. "currTick=" .. AB.C(curr_tick, "teal") .. " " .. "prevTick=" .. AB.C("First time", "pink"))
            self.db.profile.antispam.last_seen[hash] = curr_tick       
        end
    end
    
    
    -- if message contains obvious selling advertisement it will be automatically blocked regardless of it had been seen or not before
    if self.db.profile.proactive.enabled then -- AdBlock Heuristic part
        cleaned_msg = string.lower(msg)
        cleaned_msg = string.gsub(cleaned_msg, "|c[^%[]+%[([^%]]+)%]|h|r", "%1") -- Speed up processing messages with links by removing them (credit to Funkydude)
        
        for k,v in next, AB.symbols do -- removing junk
            cleaned_msg = string.gsub(cleaned_msg, k, v)
        end
        if self.db.profile.proactive.advanced_cleaning then
            for k,v in next, AB.homographs do -- canonizing message
                cleaned_msg = string.gsub(cleaned_msg, k, v)
            end
        end
        local is_ad, match = self:Heuristics(cleaned_msg)
        if is_ad then
            if self.db.profile.audit then
                self:PrintAudit(L["I would have blocked message from"] .. " " .. AB.C(player, "teal") .. L["for reason:"] .. " " .. L["Advertising"] .. " (" .. L["Keywords:"] .. " " .. AB.C(match.action, "yellow") .. ", " .. AB.C(match.object, "orange") .. ")")
                return false
            else
                self:PrintInfo(L["Blocked message from"] .. " " .. AB.C(player, "teal") .. " " .. L["for reason:"] .. " " .. L["Advertising"] .. " (" ..L["Keywords:"] .. " " .. AB.C(match.action, "yellow") .. ", " .. AB.C(match.object, "orange") .. ")")
                self:AddStrikes(player)
                self.db.profile.session_counter = self.db.profile.session_counter + 1
                self:AddToHistory({ hash = hash, msg = msg, author = player, last_seen = date, reason = L["Advertising"], channel = (channelID or event)})
                AB.blocked_lineID = lineID
                return true
            end
        end
    end
end