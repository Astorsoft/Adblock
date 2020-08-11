local L = LibStub("AceLocale-3.0"):NewLocale("AdBlock", "frFR")
if not L then return end


-- Generic/Shared

L["Add"] = "Ajouter"
L["Playername OR Playername-Realm"] = "Nomdujoueur OU Nomdujoueur-Royaume"
L["Remove"] = "Retirer"
L["Purge"] = "Purger"
L["Show"] = "Afficher"
L["[WARNING]"] = "[ATTENTION]"
L["User"] = "Utilisateur"
L["[ERROR]"] = "[ERREUR]"
L["[DEBUG]"] = "[DEBUG]"
L["[INFO]"] = "[INFO]"
L["[AUDIT]"] = "SIMULATION"
L["General"] = "Général"
L["Trade"] = "Commerce"
L["Defense"] = "Défense"
L["Say"] = "Dire"
L["Yell"] = "Crier"
L["Whisper"] = "Chuchoter"
L["Spamming"] = "Spam"
L["Advertising"] = "Publicité"
L["Refresh"] = "Raffraîchir"
L["Blacklisted"] = "Liste noire"
L["Manual"] = "Manuel"


-- function AdBlock:OnEnable
-- function AdBlock:OnDisable
L["Adblock is now disabled."] = "Addon désactivé"
L["Adblock is now enabled."] = "Addon activé"


-- UI

-- main panel
L["Enable Addon"] = "Activer"
L["AdBlock allows you to block spam and advertisement messages from your chat. \n\nFiltering ads on the LFG tool is unfortunately not possible, but Blizzard do suspend those players so don't forget to report them!"] = "AdBlock permet de filtrer le spam et les messages de pub pour du boost.\n\nFiltrer les pubs dans le LFG n'est malheureusement pas possible, mais il semblerait que Blizzard suspende les joueurs qui le font donc n'oubliez pas de les signaler!"
L["Enables/Disables the addon"] = "Active/Désactive l'addon"
L["Show Minimap Button"] = "Bouton minicarte"
L["Toggle minimap button visibility"] = "Bascule la visibilité du bouton de la minicarte"
L["Blocking Stats"] = "Statistiques de blocage"
L["Show how many ads or spam were blocked thanks to AdBlock"] = "Montre combien de pub/spam ont été bloqués grâce à AdBlock"
L["Tutorial"] = "Didacticiel"
L["Show the introduction message once more"] = "Affiche le message d'introduction à nouveau"
L["Auto-Blacklist"] = "Liste noire auto"
L["Automatically blacklist repeated offenders"] = "Ajoute automatiquement les spammeurs recurrents dans la liste noire"
L["Block Ads"] = "Anti-Pub"
L["Block detected ads using Adblock heuristics (while not in proactive, ads/spam are blocked at their second occurence)"] = "Bloque les messages publicitaires via le moteurs de mots clés d'AdBlock, si ce mode n'est pas activé, seules les annonces dupliquées sont bloquées"
L["Block Spam"] = "Anti-Spam"
L["When enabled, block message sent more than once over a specific timeframe"] = "Bloque les messages envoyées plusieurs fois dans la fenêtre de temps définie dans les options"
L["Blacklist"] = "Liste noire"
L["Whitelist"] = "Liste blanche"
L["Anti-Spam"] = "Anti-Spam"
L["History"] = "Historique"
L["Audit Mode"] = "Simuler"
L["Announce what would have blocked and why without blocking anything. Useful for testing."] = "Annonce ce que l'addon aurait bloqué et pourquoi sans bloquer quoi de ce soit"
L["Mayhem"] = "Chaos"
L["Activate Mayhem mode (experimental), messing with spammers through whisps, please use it with caution (and fun!)"] = "Active le mode Chaos (expérimental), ennuie les spammeurs de pubs en leurs envoyant des whispes inutiles, à utiliser avec précaution! (et humour ;) )"
L["Verbose"] = "Bavard"
L["Print out infos such as when a message is blocked and why."] = "L'addon affichera beaucoup de messages d'infos, par example expliquant quand un message est bloqué et pourquoi"
L["Debug"] = "Débogage"
L["Print out extra information. Only use for debugging purpose, this can be very noisy."] = "Affiches des informations techniques, uniquement intéressant dans une optique de débogage, cela peut être très verbeux!"
L["Filter the following channels:"] = "Filtrer les canaux suivants"
L["Which channels/message types to activate AdBlock on"] = "Sur quels canaux de discussion voulez vous AdBlock actif"
L["General chat (/1)"] = "Canal Général (/1)"
L["Trade chat (/2)"] = "Canal Commerce (/2)"
L["General Defense chat (/3)"] = "Canal DéfenseLocale (/3)"
L["LookingForGroup chat"] = "Canal RechercheDeGroup"
L["WorldDefense chat"] = "Canal DéfenseGlobale"
L["GuildRecruitment chat"] = "Canal RecrutementDeGuilde"
L["Normal messages (/say)"] = "Dire (/s)"
L["Yell messages (/yell)"] = "Crier (/y)"
L["Whispers (/w)"] = "Chuchoter (/w)"
L["Ad-blocking keywords"] = "Mots clés pour l'Anti-Pub"



-- Blacklist 
L["Add players that you want to always block, only applies to the channels you filter. \n\nIf you ticked \"Auto-Blacklist\", people that repeatedly Spam or send ads (more than 10 times) will automatically get added in your blacklist."] = "Ajouter des joueurs que vous voulez systématiquement bloquer, s'applique uniquement aux canaux filtrés.\n\nSi vous cochez \"Liste noire auto\", ceux qui spam ou envoient de la pub sans arrêt (plus de 10 fois) seront automatiquement ajoutés à votre liste noire"
L["Add player to permanent blacklist, you'll no longer see any message from them on channel where Adblock is active"] = "Ajoute un joueur à la liste noire, vous ne verrez plus de message de cette personne sur les canaux ou AdBlock est actif"
L["Remove player from permanent blacklist, player will still be blocked through normal Adblock Antispam/antiAds heuristics"] = "Retire un joueur de la liste noire, le joueur sera toujours bloqué par les mécanismes anti-spam et anti-pub"
L["Show Blacklist"] = "Voir liste noire"
L["Show current Blacklist"] = "Affiche la liste noire actuelle"
L["Empty the blacklist"] = "Vider la liste noire"


-- Whitelist
L["Add players you want to never be flagged as Spam or Advertisement.\n\nNo need to add friends or guildies, they will automatically be whitelisted as part of the \"Pals\""] = "Ajouter des joueurs que vous ne voulez jamais filtrer en tant que spam ou publicité.\n\nIl n'est pas nécessaire d'ajouter votre liste d'amis et les membres de votre guilde, ils seront automatiquement retirés des filtres grâce au mécanisme des \"Copains\n"
L["Add players to whitelist, you'll never block any message from them"] = "Ajoute un joueur à la liste blanche, vous ne bloquerez jamais leurs messages"
L["Remove player from the whitelist, user will now be impacted by Adblock Antispam/antiAds heuristics"] = "Retire un joueur de la liste blanche, ils seront à nouveaux touchés par les mécanismes d'anti-spam et anti-pub"
L["Show Whitelist"] = "Voir liste blanche"
L["Show current whitelist"] = "Affiche la liste blanche"
L["Empty the Whitelist"] = "Vider liste blanche"
L["Sync Pals"] = "Synchroniser les copains"
L["Refresh the friends and guildies list so Adblock never activates on them, automatically refreshed every few minutes"] = "Raffraîchit la liste des copains (contient les amis et membres de la guilde) pour qu'Adbloque ne filtre jamais leurs messages, se met à jour automatiquements toutes les 5 minutes"
L["Show Pals"] = "Voir les copains"
L["Show the current list of piles"] = "Affiche la liste des copains"

-- Proactive 
L["Adblocking works like this: \n\nIf a message contains one of the \"Selling Action Keywords\" |cFFFF0000AND|r one of the \"Selling Object Keywords\", then it will be flagged as advertisement and blocked if you ticked \"Block ads\".\n\n This allows to block ads like \"WTS lvling boost\" while keeping trade messages like \"WTS Sky-Golem\"."] = "L'anti-pub fonctionne ainsi: \n\nSi un message contient un des \"Mots-clés actions\" ET un des \"Mots-clés objets\", alors le message est vu comme une publicité et sera bloqué si vous avez coché \"Anti-pub\".\n\nCela permet de bloquer des annonces de type \"Vends boost mm+\" sans filtrer des messages de vente légitimes de type \"Vends Golem Célèste\"."
L["Restore defaults"] = "Réinitialiser par défaut"
L["Revert back to the default configuration"] = "Rétablit la configuration d'origine"
L["Selling Action keywords"] = "Mots-clés actions"
L["Keywords to detect as an intent to sell"] = "Mots-clés visant à détecter une intention de vendre quelque chose"
L["Selling Object keywords"] = "Mots-clés objets"
L["Keywords to detect as an object/service being sold"] = "Mots-clés visant à détecter le service/le bien en vente que l'on considère indésirable"
L["Advanced filtering"] = "Filtrage avancé"
L["If this option is activated, AdBlock will perform some aggressive message cleaning, such as removing homograph and special characters before doing the keyword detection. While this can be very helpful to avoid classic keyword detection strategies from spammers, this can break keyword detection in non english language making heavy use of accents or non-latin alphabet. Try deactivating this options if your keywords are not matched as they should."] = "Si cette option est activée, AdBlock procèdera à un assainissement aggréssif du message avant de lancer la recherche de mots clés, cela supprimera les caractères accentués et les homographes du message (par exemple é et è deviendront e). Bien que ce genre de nettoyage permet de lutter contre les techniques de contournements du filtrage par les spammeurs, cela peut rendre la détection de certains mots impossible dans les langues avec des accents comme le français ou les langues en alphabet non latin comme le russe. Essayez de désactiver cette option si vos mots clés ne sont pas détectés comme ils le devraient."

-- Anti Spam
L["Anti-Spam works as follows:\n\nIf a message is sent multiple times within <threshold> seconds by the same person on the same channel, then it is flagged as Spam and is blocked if you ticked \"Block Spam\""] = "L'anti-spam fonctionne ainsi:\n\nSi un message est envoyé à l'identique plusieurs fois en moins de <seuil> secondes par la même personne, alors il sera marqué comme spam et bloqué si vous avez coché \"Anti-Spam\""
L["Threshold"] = "Seuil"
L["Minimum time (in seconds) between two identical message to not be identified as spam."] = "Temps minimum (en secondes) entre deux messages identiques pour ne pas être identifié comme spam."


-- History
L["Keep block history"] = "Garder un historique"
L["When enabled, blocked message are logged for future review"] = "Quand coché, les messages bloqués par AdBlock seront conservés pour une revue ultérieure"
L["Show blocked message history for current user"] = "Affiche l'historique des messages bloqués sur le personnage actuel"
L["Maximum history size"] = "Taille d'historique maximum"
L["How many blocked messages are kept in the history"] = "Combiens de messages sont gardés dans l'historique"
L["Purge blocked message history for current user"] = "Purge l'historique des messages bloqués sur le personnage actuel"
L["Purge the blocked messages history? This cannot be undone."] = "Purger l'historique? Cette action ne peut être annulée"

-- function AdBlock:OnInitialize
L["Type /ab to access the config or /ab stats to see how many Ads and Spam Adblock spared you."] = "Tape /ab pour accéder au menu de configuration ou /ab stats pour voir combien de pub/spam AdBlock t'a épargné!"
L["Left Click to Toggle addon"] = "Clic gauche pour Activer/Désactiver l'addon"


-- function AdBlock:ToggleMode
L["ACTIVATING MAYHEM MODE! LET'S FIGHT FIRE WITH FIRE"] = "ACTIVATION DU MODE CHAOS! COMBATTONS LE FEU PAR LE FEU!"
L["Deactivating project mayhem, probably a good idea."] = "Désactivation du projet Chaos, c'est probablement plus sage..."
L["mode activated."] = " activé"
L["mode deactivated."] = " désactivé"

-- function AdBlock:GetStats
L["messages blocked this session,"] = "messages bloqués cette session"
L["in total!"] = "au total!"


-- function AdBlock:SetScope
L["Adblock activated for"] = "AdBlock activé pour"
L["Adblock disabled for"] = "AdBlock désactivé pour"


-- function AdBlock:ShowBlacklist
-- function AdBlock:ShowWhitelist
-- function AdBlock:ShowPals
L["players found."] = "joueurs trouvés"
L["AdBlock - Blacklisted users"] = "AdBlock - Joueurs en liste noire"
L["List is empty!"] = "La liste est vide!"
L["Blacklisted users:"] = "Liste noire:"
L["AdBlock - Whitelisted users"] = "AdBlock - Joueurs en liste blanche"
L["Whitelisted users:"] = "Liste blanche:"
L["Pals in total:"] = "Copains au total:"
L["AdBlock - List of pals (friends and guildies)"] = "AdBlock - Liste des copains (amis et guildies)"


-- function AdBlock:PurgeBlacklistConfirmation
L["Are you sure you want to purge the blacklist? This cannot be undone."] = "Êtes vous sûr de vouloir purger la liste noire? Cela ne peut être annulé."


-- function AdBlock:AddToBlacklist
L["is already in the blacklist."] = "est déjà dans la liste noire"
L["is already in the whitelist, remove it from the whistelist first."] = "est déjà dans la liste blanche, retirez le d'abord de la liste blanche"


-- function AdBlock:RemoveFromBlacklist
L["not found in the blacklist"] = "introuvable dans la liste noire"


-- function AdBlock:PurgeWhitelistConfirmation
L["Are you sure you want to purge the whitelist? This cannot be undone."] = "Êtes vous sûr de vouloir purger la liste blanche? Cela ne peut être annulé."


-- function AdBlock:AddToWhitelist
L["is already in the Whitelist"] = "est déjà dans la liste blanche"
L["is already in the blacklist, remove it from the blacklist first."] = "est déjà dans la liste noire, retirez le d'abord de la liste noire"
L["added in the whitelist"] = "ajouté dans la liste blanche"
L["not found in the whitelist"] = "introuvable dans la liste blanche"

-- function AdBlock:AddStrikes
L["Adding 1 strike to"] = "Ajoute un blâme à"
L["strikes total"] = "blâmes au total"
L["Adding player"] = "Ajout du joueur"
L["in the permanent blocklist after 10 strikes."] = "dans la liste noire après 10 blâmes"


--function AdBlock:GetHistoryText
--function AdBlock:ShowHistory
--function AdBlock:AddToHistory
--function AdBlock:PurgeHistory
L["Entry"] = "Entrée"
L["blocked for reason:"] = "bloqué pour la raison:"
L["AdBlock - Blocked Messages History"] = "AdBlock - Historique des messages bloqués"
L["blocked messages"] = "messages bloqués"
L["Adding entry"] = "Ajout de l'entrée"
L["in history log"] = "dans l'historique"
L["History purged"] = "Historique purgé"


--function AdBlock:ShowTutorial(info)
L["Welcome to AdBlock!"] = "Bienvenue sur AdBlock!"
L["AdBlock tutorial"] = "Didacticiel AdBlock"
L["World of Warcraft is turning like the rest of the internet, full of Boosting messages in chat, whispers, LFG tool, etc. As Blizzard is not doing anything about it, let's filter the clutter ourselves!"] = "World of Warcraft tourne comme le reste d'Internet, envahit de publicité pour du boost dans le chat, l'outil recherche de groupe, etc. Vu que Blizzard ne fait pas grand chose y mettre fin, filtrons ces nuisances nous même!"
L["Current features:"] = "Fonctionalités"
L["Block Spam: Automatically block messages sent more than once from the same user within defined timeframe (default to 5 min) in General Chat/Trade/Say/Yell/Whisper"] = "Anti-Spam: Bloque les messages envoyés plus d'une fois par une même personne en peu de temps (par défaut 5 minutes) dans Général/Commerce/Défense/Dire/Crier/Chuchoter"
L["Block Ads aka Proactive mode: Aggressively blocks obvious boosting messages from the first occurence"] = "Anti-Pub, aussi appelé mode proactif: Bloque les publicités pour du boost dès leur première occurence"
L["Blacklist users to be permanently filtered out of your chat"] = "Liste noire d'utilisateurs à bloquer systématiquement"
L["Whitelist users to always be allowed (automatically done for friends and guildies)"] = "Liste blanche d'utilisateurs à ne jamais filtrer"
L["Audit mode: Try out AdBlock to see what it would block without actually blocking anything"] = "Mode Simulation: Essayez AdBlock en vérifiant ce qu'il bloquerait sans le faire réelement"
L["Autoblock mode: adds to the permanent blocklist repeating offenders"] = "Ajout automatique des spammeurs récalcitrant dans la liste noire"
 L["Show how many messages were blocked this session/overall"] =  "Affiche combiens de messages indésirables ont été bloqués cette session/en tout"
L["Recommended usage:"] =  "Usage recommendé:"
L["Type in /s \"adblock:test\" to make sure the addon works"] = "Taper /s \"adblock:test\" pour vous assurer que l'addon fonctionne"
L["Type /ab  or click on the button below and start fine-tuning the AdBlock to your taste"] =  "Taper /ab ou cliquer sur le bouton ci-dessous et commencez à personnaliser AdBlock selon vos envies"
L["If you're a bit scared of blocking important stuff:"] = "Si vous avez peur de bloquer des messages importants:"
L["Activate \"Audit\" to make sure it would not block messages you would like to keep"] = "Activer \"Simuler\" pour voir ce qui serait bloqué sans le faire réelement"
L["Later, remove Audit and switch to Verbose to see when messages are being blocked"] = "Plus tard, passez de Simuler à \"Bavard\" pour savoir quand un message est bloqué"
L["You can see blocked message history at any time in the settings or via /ab history show"] = "Vous pouvez accéder à l'historique des messages à tout moment dans les options ou via /ab history show"
L["Finally, you can activate Auto-Blacklist to permanently mute players that repeatedly trigger Adblock"] = "Enfin, vous pouvez activer \"Liste noire auto\" pour ignorer de façon permanente les spammeurs récalcitrants"
L["Ok, show me the options!"] = "OK, montre moi les options!"


--function AdBlock:ChatFilterLogic
L["Blocked message from"] = "Message bloqué de"
L["I would have blocked message from"] = "J'aurais bloqué le message de"
L["for reason:"] = "pour la raison:"
L["Keywords:"] = "Mots-clés:"

