local L = LibStub("AceLocale-3.0"):NewLocale("AdBlock", "enUS", true)

-- Generic/Shared

L["Add"] = true
L["Playername OR Playername-Realm"] = true
L["Remove"] = true
L["Purge"] = true
L["Show"] = true
L["[WARNING]"] = true
L["User"] = true
L["[ERROR]"] = true
L["[DEBUG]"] = true
L["[INFO]"] = true
L["[AUDIT]"] = true
L["General"] = true
L["Trade"] = true
L["Defense"] = true
L["Say"] = true
L["Yell"] = true
L["Whisper"] = true
L["Spamming"] = true
L["Advertising"] = true
L["Refresh"] = true
L["Blacklisted"] = true
L["Manual"] = true

-- function AdBlock:OnEnable
-- function AdBlock:OnDisable
L["Adblock is now disabled."] = true
L["Adblock is now enabled."] = true

-- UI

-- main panel
L["Enable Addon"] = true
L["AdBlock allows you to block spam and advertisement messages from your chat. \n\nFiltering ads on the LFG tool is unfortunately not possible, but Blizzard do suspend those players so don't forget to report them!"] = true
L["Enables/Disables the addon"] = true
L["Show Minimap Button"] = true
L["Toggle minimap button visibility"] = true
L["Blocking Stats"] = true
L["Show how many ads or spam were blocked thanks to AdBlock"] = true
L["Tutorial"] = true
L["Show the introduction message once more"] = true
L["Auto-Blacklist"] = true
L["Automatically blacklist repeated offenders"] = true
L["Block Ads"] = true
L["Block detected ads using Adblock heuristics (while not in proactive, ads/spam are blocked at their second occurence)"] = true
L["Block Spam"] = true
L["When enabled, block message sent more than once over a specific timeframe"] = true
L["Blacklist"] = true
L["Whitelist"] = true
L["Anti-Spam"] = true
L["History"] = true
L["Audit Mode"] = true
L["Announce what would have blocked and why without blocking anything. Useful for testing."] = true
L["Mayhem"] = true
L["Activate Mayhem mode (experimental), messing with spammers through whisps, please use it with caution (and fun!)"] = true
L["Verbose"] = true
L["Print out infos such as when a message is blocked and why."] = true
L["Debug"] = true
L["Print out extra information. Only use for debugging purpose, this can be very noisy."] = true
L["Filter the following channels:"] = true
L["Which channels/message types to activate AdBlock on"] = true
L["General chat (/1)"] = true
L["Trade chat (/2)"] = true
L["General Defense chat (/3)"] = true
L["Normal messages (/say)"] = true
L["Yell messages (/yell)"] = true
L["Whispers (/w)"] = true
L["Ad-blocking keywords"] = true

-- Blacklist 
L["Add players that you want to always block, only applies to the channels you filter. \n\nIf you ticked \"Auto-Blacklist\", people that repeatedly Spam or send ads (more than 10 times) will automatically get added in your blacklist."] = true
L["Add player to permanent blacklist, you'll no longer see any message from them on channel where Adblock is active"] = true
L["Remove player from permanent blacklist, player will still be blocked through normal Adblock Antispam/antiAds heuristics"] = true
L["Show Blacklist"] = true
L["Show current Blacklist"] = true
L["Empty the blacklist"] = true


-- Whitelist
L["Add players you want to never be flagged as Spam or Advertisement.\n\nNo need to add friends or guildies, they will automatically be whitelisted as part of the \"Pals\""] = true
L["Add players to whitelist, you'll never block any message from them"] = true
L["Remove player from the whitelist, user will now be impacted by Adblock Antispam/antiAds heuristics"] = true
L["Show Whitelist"] = true
L["Show current whitelist"] = true
L["Empty the Whitelist"] = true
L["Sync Pals"] = true
L["Refresh the friends and guildies list so Adblock never activates on them, automatically refreshed every few minutes"] = true
L["Show Pals"] = true
L["Show the current list of piles"] = true

-- Proactive 
L["Adblocking works like this: \n\nIf a message contains one of the \"Selling Action Keywords\" |cFFFF0000AND|r one of the \"Selling Object Keywords\", then it will be flagged as advertisement and blocked if you ticked \"Block ads\".\n\n This allows to block ads like \"WTS lvling boost\" while keeping trade messages like \"WTS Sky-Golem\"."] = true
L["Restore defaults"] = true
L["Revert back to the default configuration"] = true
L["Selling Action keywords"] = true
L["Keywords to detect as an intent to sell"] = true
L["Selling Object keywords"] = true
L["Keywords to detect as an object/service being sold"] = true


-- Anti Spam
L["Anti-Spam works as follows:\n\nIf a message is sent multiple times within <threshold> seconds by the same person on the same channel, then it is flagged as Spam and is blocked if you ticked \"Block Spam\""] = true
L["Threshold"] = true
L["Minimum time (in seconds) between two identical message to not be identified as spam."] = true


-- History
L["Keep block history"] = true
L["When enabled, blocked message are logged for future review"] = true
L["Show blocked message history for current user"] = true
L["Maximum history size"] = true
L["How many blocked messages are kept in the history"] = true
L["Purge blocked message history for current user"] = true
L["Purge the blocked messages history? This cannot be undone."] = true


-- function AdBlock:OnInitialize
L["Type /ab to access the config or /ab stats to see how many Ads and Spam Adblock spared you."] = true
L["Left Click to Toggle addon"] = true


-- function AdBlock:ToggleMode
L["ACTIVATING MAYHEM MODE! LET'S FIGHT FIRE WITH FIRE"] = true
L["Deactivating project mayhem, probably a good idea."] = true
L["mode activated."] = true
L["mode deactivated."] = true

-- function AdBlock:GetStats
L["messages blocked this session"] = true
L["in total!"] = true


-- function AdBlock:SetScope
L["Adblock activated for"] = true
L["Adblock disabled for"] = true


-- function AdBlock:ShowBlacklist
-- function AdBlock:ShowWhitelist
-- function AdBlock:ShowPals
L["players found."] = true
L["AdBlock - Blacklisted users"] = true
L["List is empty!"] = true
L["Blacklisted users:"] = true
L["AdBlock - Whitelisted users"] = true
L["Whitelisted users:"] = true
L["Pals in total:"] = true
L["AdBlock - List of pals (friends and guildies)"] = true


-- function AdBlock:PurgeBlacklistConfirmation
L["Are you sure you want to purge the blacklist? This cannot be undone."] = true


-- function AdBlock:AddToBlacklist
L["is already in the blacklist."] = true
L["is already in the whitelist, remove it from the whistelist first."] = true


-- function AdBlock:RemoveFromBlacklist
L["not found in the blacklist"] = true


-- function AdBlock:PurgeWhitelistConfirmation
L["Are you sure you want to purge the whitelist? This cannot be undone."] = true


-- function AdBlock:AddToWhitelist
L["is already in the Whitelist"] = true
L["is already in the blacklist, remove it from the blacklist first."] = true
L["added in the whitelist"] = true
L["not found in the whitelist"] = true

-- function AdBlock:AddStrikes
L["Adding 1 strike to"] = true
L["strikes total"] = true
L["Adding player"] = true
L["in the permanent blocklist after 10 strikes."] = true


--function AdBlock:GetHistoryText
--function AdBlock:ShowHistory
--function AdBlock:AddToHistory
--function AdBlock:PurgeHistory
L["Entry"] = true
L["blocked for reason:"] = true
L["AdBlock - Blocked Messages History"] = true
L["blocked messages"] = true
L["Adding entry"] = true
L["in history log"] = true
L["History purged"] = true


--function AdBlock:ShowTutorial(info)
L["Welcome to AdBlock!"] = true
L["AdBlock tutorial"] = true
L["World of Warcraft is turning like the rest of the internet, full of Boosting messages in chat, whispers, LFG tool, etc. As Blizzard is not doing anything about it, let's filter the clutter ourselves!"] = true
L["Current features:"] = true
L["Block Spam: Automatically block messages sent more than once from the same user within defined timeframe (default to 5 min) in General Chat/Trade/Say/Yell/Whisper"] = true
L["Block Ads aka Proactive mode: Aggressively blocks obvious boosting messages from the first occurence"] = true
L["Blacklist users to be permanently filtered out of your chat"] = true
L["Whitelist users to always be allowed (automatically done for friends and guildies)"] = true
L["Audit mode: Try out AdBlock to see what it would block without actually blocking anything"] = true
L["Autoblock mode: adds to the permanent blocklist repeating offenders"] = true
L["Show how many messages were blocked this session/overall"] = true
L["Recommended usage:"] = true
L["Type in /s \"adblock:test\" to make sure the addon works"] = true
L["Type /ab  or click on the button below and start fine-tuning the AdBlock to your taste"] = true
L["If you're a bit scared of blocking important stuff:"] = true
L["Activate \"Audit\" to make sure it would not block messages you would like to keep"] = true
L["Later, remove Audit and switch to Verbose to see when messages are being blocked"] = true
L["You can see blocked message history at any time in the settings or via /ab history show"] = true
L["Finally, you can activate Auto-Blacklist to permanently mute players that repeatedly trigger Adblock"] = true
L["Ok, show me the options!"] = true



--function AdBlock:ChatFilterLogic
L["Blocked message from"] = true
L["I would have blocked message from"] = true
L["for reason:"] = true
L["Keywords:"] = true

