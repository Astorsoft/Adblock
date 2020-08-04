AdBlock = LibStub("AceAddon-3.0"):NewAddon("AdBlock", "AceConsole-3.0",  "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local AB = select(2, ...)

AB.last_lineID = 0 -- used to track chat line IDs being processed by the filter

local options = {
    name = "Adblock",
    handler = AdBlock,
    type = 'group',
    args = {
        header = {
            name = "AdBlock allows you to block spam and advertisement messages from your chat. \n\nFiltering ads the LFG tool is unfortunately not possible, but Blizzard do suspend those players so don't forget to report them!",
            type = "description",
            image = "Interface\\AddOns\\AdBlock\\Textures\\Logo",
            imageWidth = 96,
            imageHeight = 96,
            fontSize = "medium",
            order = 3
        },

        help = {
            name = "Help",
            guiHidden = true,
            desc = "Show this help",
            type = "execute",
            order = 1,
            func = "ShowHelp"
        },
        enable = {
            name = "Enable",
            desc = "Enables/Disables the addon",
            type = "toggle",
            order = 2,
            set = "ToggleAddon",
            get = function(info) return AdBlock.db.profile.enabled end
        },
        stats = {
            name = "Show AdBlock Stats",
            desc = "Show how many ads or spam were blocked thanks to AdBlock",
            type = "execute",
            order = 2,
            func = "GetStats",
        },
        tutorial = {
            name = "Show the tutorial again",
            desc = "Show the introduction message once more",
            type = "execute",
            order = 2,
            func = "ShowTutorial",
        },
        autoblock = {
            name = "Auto-Blacklist",
            desc = "Automatically blacklist repeated offenders",
            type = "toggle",
            order = 12,
            set = function(info, val) AdBlock:ToggleMode(info, val, "autoblock") end,
            get = function(info) return AdBlock.db.profile.autoblock end
        },
        Block_ads = {
            name = "Block Ads",
            desc = "Block detected ads using Adblock heuristics (while not in proactive, ads/spam are blocked at their second occurence)",
            type = "toggle",
            order = 11,
            set = function(info, val) AdBlock:ToggleMode(info, val, "proactive") end,
            get = function(info) return AdBlock.db.profile.proactive.enabled end
        },
        block_spam = {
            name = "Block Spam",
            desc = "When enabled, block message sent more than once over a specific timeframe",
            type = "toggle",
            order = 10,
            set = function(info, val) AdBlock:ToggleMode(info, val, "antispam") end,
            get = function(info) return AdBlock.db.profile.antispam.enabled end
        },
        blacklist = {
            name = "Blacklist",
            type = "group",
            order = 12,
            args = {
                header = {
                    name = "Add players that you want to always block, only applies to the channels you filter. \n\nIf you ticked \"Auto-Blacklist\", people that repeatedly Spam or send ads (more than 10 times) will automatically get added in your blacklist.",
                    type = "description",
                    order = 0,
                    fontSize = "medium",
                },
                add = {
                    name = "Add",
                    desc = "Add player to permanent blacklist, you'll no longer see any message from them on channel where Adblock is active",
                    order = 1,
                    type = "input",
                    get = function(info, val) return "" end,
                    set = "AddToBlacklist",
                    pattern = "",
                    usage = "Playername OR Playername-Realm"
                },
                remove = {
                    name = "Remove",
                    desc = "Remove player from permanent blacklist, player will still be blocked through normal Adblock Antispam/antiAds heuristics",
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
                    name = "Show Blacklist",
                    desc = "Show current Blacklist",
                    order = 3,
                    type = "execute",
                    func = "ShowBlacklist",
                },
                purge = {
                    name = "Purge",
                    desc = "Empty the blacklist",
                    order = 4,
                    type = "execute",
                    confirm = "PurgeBlacklistConfirmation",
                    func = "PurgeBlacklist"
                }
            }
        },
        whitelist = {
            name = "Whitelist",
            type = "group",
            order = 13,
            args = {
                header = {
                    name = "Add players you want to never be flagged as Spam or Advertisement.\n\nNo need to add friends or guildies, they will automatically be whitelisted as part of the \"Pals\"",
                    type = "description",
                    order = 0,
                    fontSize = "medium",
                },
                add = {
                    name = "Add",
                    desc = "Add players to whitelist, you'll never block any message from them",
                    order = 1,
                    type = "input",
                    get = function(info, val) return "" end,
                    set = "AddToWhitelist",
                    pattern = "",
                    usage = "Playername OR Playername-Realm"
                },
                remove = {
                    name = "Remove",
                    desc = "Remove player from the whitelist, user will now be impacted by Adblock Antispam/antiAds heuristics",
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
                    name = "Show Whitelist",
                    desc = "Show current whitelist",
                    order = 3,
                    type = "execute",
                    func = "ShowWhitelist",
                },
                purge = {
                    name = "Purge Whitelist",
                    desc = "Empty the Whitelist",
                    order = 4,
                    type = "execute",
                    confirm = "PurgeWhitelistConfirmation",
                    func = "PurgeWhitelist"
                },
                sync_pals = {
                    name = "Sync Pals",
                    desc = "Refresh the friends and guildies list so Adblock never activates on them, automatically refreshed every few minutes",
                    order = 5,
                    type = "execute",
                    func = "SyncPals"
                },
                show_pals = {
                    name = "Show Pals",
                    desc = "Show the current list of piles",
                    order = 6,
                    type = "execute",
                    func = "ShowPals"
                }
            }
        },
        proactive = {
            name = "Ad-blocking keywords",
            type = "group",
            order = 14,
            args = {
                description = {
                    name = "Adblocking works like this: \n\nIf a message contains one of the \"Selling Action Keywords\" |cFFFF0000AND|r one of the \"Selling Object Keywords\", then it will be flagged as advertisement and blocked if you ticked \"Block ads\".\n\n This allows to block ads like \"WTS lvling boost\" while keeping trade messages like \"WTS Sky-Golem\".",
                    type = "description",
                    fontSize = "medium",
                    order = 1
                },
                reset = {
                    name = "Restore defaults",
                    desc = "Revert back to the default configuration",
                    type = "execute",
                    order = 2,
                    func = "RestoreHeuristicKeywords"
                },
                selling_actions = {
                    name = "Selling Action keywords",
                    desc = "Keywords to detect as an intent to sell",
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
                    name = "Selling Object keywords",
                    desc = "Keywords to detect as an object/service being sold",
                    type = "input",
                    multiline = true,
                    width = "full",
                    order = 4,
                    get = "GetObjectKeywords",
                    set = "SetObjectKeywords",
                    pattern = "([^,]+)",
                    usage = "keyword1,keyword2,keyword3"
                }
            }
            
        },
        spam = {
            name = "Anti-Spam",
            type = 'group',
            order = 15,
            args = {
                header = {
                    name = "Anti-Spam works as follows:\n\nIf a message is sent multiple times within <threshold> seconds by the same person on the same channel, then it is flagged as Spam and is blocked if you ticked \"Block Spam\"",
                    type = "description",
                    fontSize = "medium",
                    order = 0
                },
                threshold = 
                {
                    name = "threshold",
                    desc = "Minimum time (in seconds) between two identical message to not be identified as spam.",
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
            name = "History",
            type = "group",
            order = 16,
            args = {
                enable = {
                    name = "Keep block history",
                    desc = "When enabled, blocked message are logged for future review",
                    type = "toggle",
                    order = 1,
                    set = function(info, val) AdBlock:ToggleMode(info, val, "history") end,
                    get = function(info) return AdBlock.db.profile.history.enabled end
                },
                show = {
                    name = "Show",
                    desc = "Show blocked message history for current user",
                    type = "execute",
                    order = 2,
                    func = "ShowHistory"
                },
                limit = {
                    name = "Maximum history size",
                    desc = "How many blocked messages are kept in the history",
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
                    name = "Purge",
                    desc = "Purge blocked message history for current user",
                    type = "execute",
                    confirm = function(info) return "Purge the blocked messages history? This cannot be undone." end,
                    order = 4,
                    func = "PurgeHistory"
                }
            }
        },
        audit = {
            name = "Audit",
            desc = "Announce what would have blocked and why without blocking anything. Useful for testing.",
            type = "toggle",
            order = 16,
            set = function(info, val) AdBlock:ToggleMode(info, val, "audit") end,
            get = function(info) return AdBlock.db.profile.audit end
        },
        verbose = {
            name = "Verbose",
            desc = "Print out infos such as when a message is blocked and why.",
            type = "toggle",
            order = 15,
            set = function(info, val) AdBlock:ToggleMode(info, val, "verbose") end,
            get = function(info) return AdBlock.db.profile.verbose end
        },
        debug = {
            name = "Debug",
            desc = "Print out extra information. Only use for debugging purpose, this can be very noisy.",
            type = "toggle",
            hidden = true,
            order = 40,
            set = function(info, val) AdBlock:ToggleMode(info, val, "debug") end,
            get = function(info) return AdBlock.db.profile.debug end
        },
        scope = {
            name = "Filter the following channels:",
            desc = "Which channels/message types to activate AdBlock on",
            type = "multiselect",
            order = 40,
            values = {
                general = "General chat (/1)",
                trade = "Trade chat (/2)",
                defense = "General Defense chat (/3)",
                say = "Normal messages (/say)",
                yell = "Yell messages (/yell)",
                whisp = "Whispers (/w)"
            },
            set = "SetScope",
            get = "GetScope"
        }   
    }
}

local defaults = {
    profile = {
      enabled = true,
      audit = false,
      debug = false,
      autoblock = false,
      proactive = {
          enabled = true,
          selling_actions = {"sell", "wts", "gallywix", "discount", "sylvanas", "oblivion", "nova", "community", "free", "price"},
          selling_objects = {"boost", "m+", "mythic", "vision", "lvlup", "lvling", "levelup", "leveling", "aotc", " ce", "key", "curve", "cutting edge", "15+", "+15", "in time"}
      },
      antispam = {
          enabled = true,
          spamThreshold = 300,
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
    self:PrintInfo("Type /ab to access the config or /ab stats to see how many Ads and Spam Adblock spared you.")

    if self.db.global.tutorial then
        self:ShowTutorial()
    end
    
end


function AdBlock:SyncPals()
    self.db.char.pals = {}
    local player
    local nb_friends = GetNumFriends()
    if nb_friends then
        for i = 1, nb_friends do
            player = AB.GetFullName(GetFriendInfo(i))  
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

function AdBlock:OnEnable()
    -- Called when the addon is enabled
    if self.db.profile.enabled then
        self:SyncPals()
        self.db.char.sync_timer = self:ScheduleRepeatingTimer("SyncPals", 300)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", AB.ChatFilter)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", AB.ChatFilter)
        self:PrintInfo("Adblock is now enabled.")  
        self:RegisterEvent("PLAYER_LOGOUT")
    end
end

function AdBlock:OnDisable()
    -- Called when the addon is disabled
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", AB.ChatFilter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", AB.ChatFilter)
    if self.db.char.sync_timer then
        self:CancelTimer(self.db.char.sync_timer)
        self.db.char.sync_timer = nil
    end
    self:PrintInfo("Adblock is now disabled.")
end

function AdBlock:ShowHelp()
    LibStub("AceConfigCmd-3.0"):HandleCommand("ab", "AdBlock", "")
end

function AdBlock:PLAYER_LOGOUT(...)
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
    else
        AdBlock.db.profile[mode] = val;
    end

    if self.db.profile.verbose or mode == "verbose" then
        if val then
            AdBlock:Print(AB.capitalize(mode) .. " mode activated.")
        else
            AdBlock:Print(AB.capitalize(mode) .. " mode deactivated.")
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
    self:Print(AB.C(self.db.profile.session_counter, "orange") .. " messages blocked this session, " .. AB.C(self.db.profile.global_counter, "orange") .. " in total!")
end

function AdBlock:SetScope(info, keyname, state)
    AdBlock.db.profile.scope[keyname] = state
    
    if self.db.profile.verbose then
        if state then
            AdBlock:Print("Adblock activated for " .. keyname)
        else
            AdBlock:Print("Adblock disabled for " .. keyname)
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
        self:Print("Blacklist:")
        print(bl_text)
        
        if count then
            self:Print(AB.C(count, "teal") .. " players found.")
        else
            self:Print("List is empty!")
        end
    else -- GUI
        AB.blacklist_frame = self.ui:Create("Frame")
        AB.blacklist_frame:SetTitle("AdBlock - Blacklisted users")
        AB.blacklist_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.blacklist_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText("Refresh")
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(bl_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel("Blacklisted users: " .. count)
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
        return AB.C("[WARNING] ", "orange") .. "Are you sure you want to purge the blacklist? This cannot be undone."
    else
        return false
    end
end

function AdBlock:AddToBlacklist(info, val)
    local player = AB.GetFullName(val)
    
    if self.db.profile.blacklist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " is already in the blacklist.")
    elseif self.db.profile.whitelist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " is already in the whitelist, remove it from the whistelist first.")
    else
        self.db.profile.blacklist[player] = { name = player, origin = "manual"}
    end 
end

function AdBlock:RemoveFromBlacklist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.blacklist[player] then
        self.db.profile.blacklist[player] = nil
    else
        self:PrintError("User " .. AB.C(player, "teal") .. " not found in the blacklist")
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
        self:Print("Whitelist:")
        print(wl_text)
        
        if count then
            self:Print(AB.C(count, "teal") .. " players found.")
        else
            self:Print("List is empty!")
        end
    else -- GUI
        AB.whitelist_frame = self.ui:Create("Frame")
        AB.whitelist_frame:SetTitle("AdBlock - Whitelisted users")
        AB.whitelist_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.whitelist_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText("Refresh")
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(wl_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel("Whitelisted users: " .. count)
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
            self:Print(AB.C(count, "teal") .. " players found.")
        else
            self:Print("List is empty!")
        end
    else -- GUI
        AB.pals_frame = self.ui:Create("Frame")
        AB.pals_frame:SetTitle("AdBlock - List of pals (friends and guildies)")
        AB.pals_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.pals_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText("Refresh")
        button:SetWidth(200)
        local list_widget = self.ui:Create("MultiLineEditBox")

        list_widget:SetText(pals_text)
        list_widget:SetRelativeWidth(1)
        list_widget:SetLabel("Pals in total: " .. count)
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
        return AB.C("[WARNING] ", "orange") .. "Are you sure you want to purge the whitelist? This cannot be undone."
    else
        return false
    end
end

function AdBlock:AddToWhitelist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.whitelist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " is already in the Whitelist")
    elseif self.db.profile.blacklist[player] then
        self:PrintError("User " .. AB.C(player, "teal") .. " is already in the blacklist, remove it from the blacklist first.")
    else
        self:PrintInfo("User " .. AB.C(player, "teal") .. " added in the whitelist")
        self.db.profile.whitelist[player] = { name = player, origin = "manual"}
    end 
end

function AdBlock:RemoveFromWhitelist(info, val)
    local player = AB.GetFullName(val)

    if self.db.profile.whitelist[player] then
        self.db.profile.whitelist[player] = nil
    else
        self:PrintError("User " .. AB.C(player, "teal") .. " not found in the whitelist")
    end
end

function AdBlock:PrintError(text)
    self:Print(AB.C("[ERROR] ", "red") .. text)
end

function AdBlock:PrintWarning(text)
    self:Print(AB.C("[WARNING] ", "orange") .. text)
end

function AdBlock:PrintInfo(text)
    if self.db.profile.verbose then
        self:Print(AB.C("[INFO] ", "grey") .. text)
    end
end

function AdBlock:PrintAudit(text)
    if self.db.profile.audit then
        self:Print(AB.C("[AUDIT] ", "green") .. text)
    end
end

function AdBlock:PrintDebug(text)
    if self.db.profile.debug then
        self:Print(AB.C("[DEBUG] ", "orange") .. text)
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
    
    self:PrintDebug("Adding 1 strike to " .. AB.C(player, "teal") .. " (" .. self.db.profile.strikelist[player] .. " strikes total)")
    if self.db.profile.autoblock and self.db.profile.strikelist[player] > 10 then -- this user is most likely a spammer with 10 identical messages at less than blockDuration from each other
        self:PrintInfo("Adding player " .. AB.C(player, "teal") .. " in the permanent blocklist after 10 strikes.")
        self.db.profile.blacklist[player] = { name = player, origin = "autoblock" }
    end
end


function AdBlock:GetHistoryText()
    local history_text = ""
    for index = 1, #self.db.char.history do
        local v = self.db.char.history[index]
        history_text = history_text .. AB.C("---------- " .. "Entry " .. index .. " blocked for reason: " .. v.reason .. "\n", "red")
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
            self:Print("---------- " .. "Entry " .. index .. " blocked for reason: " .. v.reason)
            print("[" ..  AB.C(v.channel, "yellow") .. "] [" .. AB.C(v.last_seen, "orange") .. "] [" .. AB.C(v.author, "teal") .. "]:")
            print(AB.C(v.msg, "white"))
        end
    else
        AB.history_frame = self.ui:Create("Frame")
        AB.history_frame:SetTitle("AdBlock - Blocked Messages History")
        AB.history_frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
        AB.history_frame:SetLayout("List")
        local button = self.ui:Create("Button")
        button:SetText("Refresh")
        button:SetWidth(200)
        local history_widget = self.ui:Create("MultiLineEditBox")
        local history_text = self:GetHistoryText()

        history_widget:SetText(history_text)
        history_widget:SetRelativeWidth(1)
        history_widget:SetLabel("Last " .. self.db.profile.history.size .. " blocked messages")
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
        if entry.channel == 1 then entry.channel = "General" end
        if entry.channel == 2 then entry.channel = "Trade" end
        if entry.channel == 3 then entry.channel = "Defense" end
        if entry.channel == "CHAT_MSG_SAY" then entry.channel = "Say" end
        if entry.channel == "CHAT_MSG_YELL" then entry.channel = "Yell" end
        if entry.channel == "CHAT_MSG_WHISPER" then entry.channel = "Whisper" end

        table.insert(self.db.char.history, 1, entry)
        self.db.char.history[self.db.profile.history.size + 1] = nil
        self:PrintDebug("Adding entry " .. AB.C(entry.hash, "teal") .. " in history log")
    end
end

function AdBlock:PurgeHistory(info)
    self.db.char.history = {}
end

function AdBlock:ShowTutorial(info)
    self.db.global.tutorial = false
    local frame = self.ui:Create("Frame")
    frame:SetTitle("Welcome to AdBlock!")
    frame:SetStatusText("AdBlock tutorial")
    frame:SetCallback("OnClose", function(widget) AdBlock.ui:Release(widget) end)
    frame:SetLayout("List")

    local intro = self.ui:Create("Label")
    intro:SetText([[
World of Warcraft is turning like the rest of the internet, full of Boosting messages in chat, whispers, LFG tool, etc. As Blizzard is not doing anything about it, let's filter the clutter ourselves!
        
        ]])
    intro:SetRelativeWidth(1)
    intro:SetFont("Fonts\\FRIZQT__.TTF", 12)

    frame:AddChild(intro)
    local features_header = self.ui:Create("Label")
    features_header:SetText("Current features:\n")
    features_header:SetFont("Fonts\\FRIZQT__.TTF", 14, THICKOUTLINE)

    features_header:SetRelativeWidth(1)
    frame:AddChild(features_header)
    local features = self.ui:Create("Label")
    features:SetText([[
    * Block Spam: Automatically block messages sent more than once from the same user within defined timeframe (default to 5 min) in General Chat/Trade/Say/Yell/Whisper
    * Block Ads aka Proactive mode: Aggressively blocks obvious boosting messages from the first occurence
    * Blacklist users to be permanently filtered out of your chat
    * Whitelist users to always be allowed (automatically done for friends and guildies)
    * Audit mode: Try out AdBlock to see what it would block without actually blocking anything
    * Autoblock mode: adds to the permanent blocklist repeating offenders
    * Show how many messages were blocked this session/overall
        
        ]])
    features:SetFont("Fonts\\FRIZQT__.TTF", 12)
    features:SetRelativeWidth(1)
    frame:AddChild(features)

    local usage_header = self.ui:Create("Label")
    usage_header:SetText("Recommended usage:\n")
    usage_header:SetFont("Fonts\\FRIZQT__.TTF", 14, THICKOUTLINE)
    usage_header:SetRelativeWidth(1)
    frame:AddChild(usage_header)
    local usage = self.ui:Create("Label")
    usage:SetText([[
    * Type /ab and start fine-tuning the AdBlock to your taste
    * Start in Audit to make sure it would not block messages you would like to keep
    * Remove Audit and switch to Verbose to see when messages are being blocked until you feel confident about the addon, you can see blocked message history at any time through /ab history show

You can go further and activate proactive mode (/ab proactive) so that obvious advertisement messages are also blocked directly from the first message, it is tuned to remove all the BOOST offers while keeping regular WTS or WTB request for items/mounts, guild announces etc. You can configure the keywords Adblock triggers on in the settings
    
Finally, you can activate auto-blacklist to Blacklist players that repeatedly trigger Adblock to be sure you'll never hear from them again
    
    ]])
    usage:SetFont("Fonts\\FRIZQT__.TTF", 12)

    usage:SetRelativeWidth(1)
    frame:AddChild(usage)

    local button = self.ui:Create("Button")
    button:SetText("Ok, show me the options!")
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