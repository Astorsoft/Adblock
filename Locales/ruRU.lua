local L = LibStub("AceLocale-3.0"):NewLocale("AdBlock", "ruRU")
if not L then return end

-- Generic/Shared

L["Add"] = "Добавить"
L["Playername OR Playername-Realm"] = "Имя игрока или Имя игрока-игровоймир"
L["Remove"] = "Удалить"
L["Purge"] = "Очистить"
L["Show"] = "Показать"
L["[WARNING]"] = "[ВНИМАНИЕ]"
L["User"] = "Пользолватель"
L["[ERROR]"] = "ОШИБКА"
L["[DEBUG]"] = "ОТЛАДКА"
L["[INFO]"] = "ИНФО"
L["[AUDIT]"] = "ПРОВЕРКА"
L["General"] = "/1 Общий"
L["Trade"] = "/2 Торговля"
L["LocalDefense"] = "/3 Оборона"
L["WorldDefense"] = "WorldDefense"
L["LookingForGroup"] = "/4 Поискспутников"
L["GuildRecruitment"] = "GuildRecruitment"
L["Say"] = "Сказать"
L["Yell"] = "Крик"
L["Whisper"] = "Шепот"
L["Spamming"] = "Спам"
L["Advertising"] = "Реклама"
L["Refresh"] = "Обновить"
L["Blacklisted"] = "Внесены в черный список"
L["Manual"] = "Руководство"

-- function AdBlock:OnEnable
-- function AdBlock:OnDisable
L["AdBlock is now disabled."] = "AdBlock отключён."
L["AdBlock is now enabled."] = "ADblock запущен."

-- UI

-- main panel
L["Enable Addon"] = "Активировать модификацию"
L["AdBlock allows you to block spam and advertisement messages from your chat. \n\nFiltering ads on the LFG tool is unfortunately not possible, but Blizzard do suspend those players so don't forget to report them!"] = "AdBlock позволяет заблокировать нежелательный спам и рекламу во внутриигровых чатах. \n\nК сожалению, фильтрация рекламы в заранее созданных группах невозможна, но Blizzard активно блокирует игроков, использующих этот интерфейс для рекламы, поэтому не забывайте отправлять жалобы на них!"
L["Enables/Disables the addon"] = "Активация/Отключение модификации"
L["Show Minimap Button"] = "Показывать иконку на миникарте"
L["Toggle minimap button visibility"] = "Переключить видимость кнопки на миникарте"
L["Blocking Stats"] = "Статистика блокировок"
L["Show how many ads or spam were blocked thanks to AdBlock"] = "Показать сколько рекламы или спама было заблокировано благодаря AdBlock"
L["Tutorial"] = "Помощь"
L["Show the introduction message once more"] = "Показать вводное сообщение ещё раз"
L["Auto-Blacklist"] = "Автоматический чёрный список"
L["Automatically blacklist repeated offenders"] = "Автоматически заносить в чёрный список злостных спамеров"
L["Block Ads"] = "Блокировать рекламу"
L["Block detected ads using AdBlock heuristics (while not in proactive, ads/spam are blocked at their second occurence)"] = "Блокировать обнаруженную рекламу с помощью эпристики AdBlock (в неактивном режиме реклама/спам блокируются при их втором появлени)"
L["Block Spam"] = "Блокировать спам"
L["When enabled, block message sent more than once over a specific timeframe"] = "При активации модификация начинает блокировать сообщения, отправленные более одного раза за указанный отрезок времени"
L["Blacklist"] = "Чёрный список"
L["Whitelist"] = "Белый список"
L["Anti-Spam"] = "Анти-спам"
L["History"] = "История"
L["Audit Mode"] = "Режим проверки"
L["Announce what would have blocked and why without blocking anything. Useful for testing."] = "Модификация сообщит какое сообщение и почему должно было быть заблокировано, при этом не нарушая работу чата. Полезно для тестирования."
L["Mayhem"] = "Хаос"
L["Activate Mayhem mode (experimental), messing with spammers through whisps, please use it with caution (and fun!)"] = "Задействуйте режим Хаоса (экспериментальная функция!) и посмейтесь над спамерами! Используйте его осторожно (и получайте удовольствие)"
L["Verbose"] = "Отчёты"
L["Print out infos such as when a message is blocked and why."] = "Сообщать в чат, когда модификация заблокировала сообщение и почему."
L["Debug"] = "Отладка"
L["Print out extra information. Only use for debugging purpose, this can be very noisy."] = "Собирайте дополнительную информацию. Используйте только для отладки, функция спамит."
L["Filter the following channels:"] = "Отфильтровать следующие каналы:"
L["Which channels/message types to activate AdBlock on"] = "Какие каналы/типы сообщений фильтруются AdBlock"
L["General chat (/1)"] = "Общий чат (/1)"
L["Trade chat (/2)"] = "Торговля (/2)"
L["General Defense chat (/3)"] = "Оборона (/3)"
L["Normal messages (/say)"] = "Общение персонажей (/сказать)"
L["Yell messages (/yell)"] = "Крик персонажей (/крик)"
L["LookingForGroup chat"] = "Поиск спутников (/4)"
L["WorldDefense chat"] = "WorldDefence chat"
L["GuildRecruitment chat"] = "GuildRecruitment chat"
L["Whispers (/w)"] = "Шёпот игроков (/ш)"
L["Ad-blocking keywords"] = "Ключевые слова для блокирования"

-- Blacklist 
L["Add players that you want to always block, only applies to the channels you filter. \n\nIf you ticked \"Auto-Blacklist\", people that repeatedly Spam or send ads (more than 10 times) will automatically get added in your blacklist."] = "Добавление игроков, которых вы хотите блокировать всегда. Применяется только к фильтруемым каналам. \n\nЕсли вы активировали \"Автоматический чёрный список\", люди, которые многократно рассылают спам или отправляют рекламу (более 10 раз), автоматически будут добавлены в этот чёрный список."
L["Add player to permanent blacklist, you'll no longer see any message from them on channel where AdBlock is active"] = "Добавьте игрока в чёрный список и вы больше не увидите никаких сообщений от него на каналах фильтруемых AdBlock"
L["Remove player from permanent blacklist, player will still be blocked through normal AdBlock Antispam/antiAds heuristics"] = "Удалить игрока из чёрного списка, сообщения игрока всё равно могут блокироваться алгоритмами Антиспама/Антирекламы."
L["Show Blacklist"] = "Показать чёрный список"
L["Show current Blacklist"] = "Показать текущий чёрный список"
L["Empty the blacklist"] = "Очистить чёрный список"


-- Whitelist
L["Add players you want to never be flagged as Spam or Advertisement.\n\nNo need to add friends or guildies, they will automatically be whitelisted as part of the \"Pals\""] = "Добавьте игроков, сообщения от которых не должны блокироваться при помощи AdBlock. \n\nНет необходимости добавлять друзей или согильдийцев - AdBlock автоматически вносит их в список \"Товарищей\"."
L["Add players to whitelist, you'll never block any message from them"] = "Добавьте игроков в белый список, чтобы больше не блокировать их сообщения"
L["Remove player from the whitelist, user will now be impacted by AdBlock Antispam/antiAds heuristics"] = "Удалить игрока из Белого списка, тогда на него снова будут распространяться алгоритмы фильтрации Антиспам/Антиреклама"
L["Show Whitelist"] = "Показать Белый список"
L["Show current whitelist"] = "Показать текущий Белый список"
L["Empty the Whitelist"] = "Очистить белый список"
L["Sync Pals"] = "Синхронизировать товарищей"
L["Refresh the friends and guildies list so AdBlock never activates on them, automatically refreshed every few minutes"] = "Обновить список друзей и согильдийцев, чтобы AdBlock никогда не фильтровал их сообщения, автоматически обновляется каждые несколько минут"
L["Show Pals"] = "Показать товарищей"
L["Show the current list of piles"] = "Показать текущий список товарищей"

-- Proactive 
L["AdBlocking works like this: \n\nIf a message contains one of the \"Selling Action Keywords\" |cFFFF0000AND|r one of the \"Selling Object Keywords\", then it will be flagged as advertisement and blocked if you ticked \"Block ads\".\n\n This allows to block ads like \"WTS lvling boost\" while keeping trade messages like \"WTS Sky-Golem\"."] = "Блокировка рекламы работает следующим образом: \n\nЕсли сообщение содержит одно из \"Ключевых слов намерения продажи\" |cFFFF0000AND|r и одно из \"Ключевых слов объекта продажи\", то оно будет помечено как реклама и заблокировано, если вы активировали функцию \"Блокировать рекламу\".\n\n Это позволяет блокировать рекламу вроде \"Продам [На кромке лезвия]\" сохраняя при этом такие торговые сообщения как \"Продам гараж\"."
L["Restore defaults"] = "Восстановить значения по умолчанию"
L["Revert back to the default configuration"] = "Вернуться к конфигурации по умолчанию"
L["Selling Action keywords"] = "Ключевые слова намерения продажи"
L["Keywords to detect as an intent to sell"] = "Слова для определения намерения продать"
L["Selling Object keywords"] = "Ключевые слова объекта продажи"
L["Keywords to detect as an object/service being sold"] = "Слова для определения предмета торговли"
L["Advanced filtering"] = "Расширенная фильтрация"
L["If this option is activated, AdBlock will perform some aggressive message cleaning, such as removing homograph and special characters before doing the keyword detection. While this can be very helpful to avoid classic keyword detection strategies from spammers, this can break keyword detection in non english language making heavy use of accents or non-latin alphabet. Try deactivating this options if your keywords are not matched as they should."] = "Если эта опция активирована, AdBlock будет выполнять более агрессивную очистку сообщений, такую как удаление омографа и специальных символов перед обнаружением ключевых слов. Хотя это может быть полезно для предотвращения классических стратегий обнаружения ключевых слов от спамеров на английском языке, это может нарушить обнаружение ключевых слов для других языков с использованием акцентов или символов нелатинского алфавита. Попробуйте отключить эту функцию, если ваши ключевые слова не работают должным образом."

-- Anti Spam
L["Anti-Spam works as follows:\n\nIf a message is sent multiple times within <threshold> seconds by the same person on the same channel, then it is flagged as Spam and is blocked if you ticked \"Block Spam\""] = "Анти-спам работает следующим образом:\n\nЕсли сообщение отправлено несколько раз в течении <предела> секунд одним и тем же человеком на одном и том же канале, оно помечается как спам и блокируется, если вы отметили \"Блокировать спам\""
L["Threshold"] = "Предел"
L["Minimum time (in seconds) between two identical message to not be identified as spam."] = "Минимальное время (в секундах) между двумя одинаковыми сообщениями не идентифицируемыми как спам."


-- History
L["Keep block history"] = "Сохранять историю блокировок"
L["When enabled, blocked message are logged for future review"] = "Когда активно, заблокированные сообщения сохраняются для дальнейшего просмотра."
L["Show blocked message history for current user"] = "Показать историю заблокированных сообщений для текущего персонажа"
L["Maximum history size"] = "Максимальный размер истории блокировок"
L["How many blocked messages are kept in the history"] = "Количество заблокированных сообщений, которые хранятся в истории."
L["Purge blocked message history for current user"] = "Запросить историю заблокированных сообщений для текущего персонажа."
L["Purge the blocked messages history? This cannot be undone."] = "Очистить историю? Это действие необратимо удалит всю историю заблокированных сообщений."


-- function AdBlock:OnInitialize
L["Type /ab to access the config or /ab stats to see how many Ads and Spam AdBlock spared you."] = "Введите /ab, чтобы получить доступ к конфигурации или /ab stats, чтобы узнать, сколько рекламы и спама AdBlock для вас заблокировал."
L["Left Click to Toggle addon"] = "ЛКМ для переключения модификации"


-- function AdBlock:ToggleMode
L["ACTIVATING MAYHEM MODE! LET'S FIGHT FIRE WITH FIRE"] = "АКТИВАЦИЯ РЕЖИМА ХАОСА! ВСЁ СГОРИТ В ОГНЕ"
L["Deactivating project mayhem, probably a good idea."] = "Деактивировать проектный хаос, пожалуй, хорошая идея."
L["mode activated."] = "Мод активирован"
L["mode deactivated."] = "Мод деактивирован"

-- function AdBlock:GetStats
L["messages blocked this session"] = "Сообщения, заблокированные за текущий сеанс"
L["in total!"] = "всего:"


-- function AdBlock:SetScope
L["AdBlock activated for"] = "AdBlock активирован для"
L["AdBlock disabled for"] = "AdBlock деактивирован для"


-- function AdBlock:ShowBlacklist
-- function AdBlock:ShowWhitelist
-- function AdBlock:ShowPals
L["players found."] = "игроков найдено."
L["AdBlock - Blacklisted users"] = "AdBlock - заблокированные пользователи"
L["List is empty!"] = "Список пуст!"
L["Blacklisted users:"] = "Заблокированные пользователи:"
L["AdBlock - Whitelisted users"] = "AdBlock - игнорируемые пользователи"
L["Whitelisted users:"] = "Игнорируемые пользователи:"
L["Pals in total:"] = "Всего приятелей:"
L["AdBlock - List of pals (friends and guildies)"] = "AdBlock - Список приятелей (друзей и согильдийцев)"


-- function AdBlock:PurgeBlacklistConfirmation
L["Are you sure you want to purge the blacklist? This cannot be undone."] = "Все персонажи будут безвозвратно удалены из списка заблокированных, вы уверены?"


-- function AdBlock:AddToBlacklist
L["is already in the blacklist."] = "уже в списке заблокированных."
L["is already in the whitelist, remove it from the whistelist first."] = "уже в списке игнорируемых, сначала удалите его из списка игнорируемых."


-- function AdBlock:RemoveFromBlacklist
L["not found in the blacklist"] = "не найден в списке заблокированных"


-- function AdBlock:PurgeWhitelistConfirmation
L["Are you sure you want to purge the whitelist? This cannot be undone."] = "Все персонажи будут безвозвратно удалены из списка игнорируемых, вы уверены?"


-- function AdBlock:AddToWhitelist
L["is already in the Whitelist"] = "уже в списке игнорируемых"
L["is already in the blacklist, remove it from the blacklist first."] = "уже в списке заблокированных, сначала удалите его из списка заблокированных."
L["added in the whitelist"] = "добавлен в список игнорируемых"
L["not found in the whitelist"] = "не найден в списке игнорируемых"

-- function AdBlock:AddStrikes
L["Adding 1 strike to"] = "Добавить 1 страйк к"
L["strikes total"] = "всего страйков"
L["Adding player"] = "Добавить персонажа"
L["in the permanent blocklist after 10 strikes."] = "в список заблокированных после 10 страйков."


--function AdBlock:GetHistoryText
--function AdBlock:ShowHistory
--function AdBlock:AddToHistory
--function AdBlock:PurgeHistory
L["Entry"] = "Вход"
L["blocked for reason:"] = "Заблокировано по причине:"
L["AdBlock - Blocked Messages History"] = "AdBlock - история заблокированных сообщений"
L["blocked messages"] = "заблокировано сообщений"
L["Adding entry"] = "Добавление записи"
L["in history log"] = "в журнале истории"
L["History purged"] = "История очищена"


--function AdBlock:ShowTutorial(info)
L["Welcome to AdBlock!"] = "Приветствую пользователя AdBlock!"
L["AdBlock tutorial"] = "Инструкция к AdBlock"
L["World of Warcraft is turning like the rest of the internet, full of Boosting messages in chat, whispers, LFG tool, etc. As Blizzard is not doing anything about it, let's filter the clutter ourselves!"] = "World of WarCraft меняется. Как и весь Интернет - игра переполнена спамом буквально во всех каналах чата. Поскольку Blizzard не занимается этой проблемой, доблестные энтузиасты из преданного игрового сообщества взялись собственноручно бороться с этой бедой!"
L["Current features:"] = "Текущие возможности:"
L["Block Spam: Automatically block messages sent more than once from the same user within defined timeframe (default to 5 min) in General Chat/Trade/Say/Yell/Whisper"] = "Блокировка спама: автоматическая блокировка сообщений, отправленных более одного раза от одного и того же пользователя в течении определённого периода времени (по умолчанию 5 минут) в общем чате/торговле/разговоре/крике/шепоте"
L["Block Ads aka Proactive mode: Aggressively blocks obvious boosting messages from the first occurence"] = "Блокировка рекламы в проактивном режиме: агрессивно блокирует очевидные рекламные сообщения с первого их появления (к сожалению, недоступно на русском языке из-за сложностей работы компьютеров с Кириллицей)"
L["Blacklist users to be permanently filtered out of your chat"] = "Список заблокированных пользователей, которые навсегда будут отфильтрованы из вашего чата"
L["Whitelist users to always be allowed (automatically done for friends and guildies)"] = "Добавление персонажей в список игнорирования, чтобы все их сообщения всегда можно было увидеть (автоматически активировано для друзей и согильдийцев)"
L["Audit mode: Try out AdBlock to see what it would block without actually blocking anything"] = "Режим проверки: тест AdBlock, позволяющий получить информацию о блокируемых сообщений избегая самой блокировки"
L["Autoblock mode: adds to the permanent blocklist repeating offenders"] = "Автоблок-мод: автоматическое добавление в список заблокированных злостных любителей спама"
L["Show how many messages were blocked this session/overall"] = "Отображение статистики заблокированных сообщений за сессию/в целом"
L["Recommended usage:"] = "Рекомендуемое использование:"
L["Type in /s \"adblock:test\" to make sure the addon works"] = "Введите \"/с adblock:test\", чтобы убедиться, что модификация работает"
L["Type /ab  or click on the button below and start fine-tuning the AdBlock to your taste"] = "Введите /ab или нажмите кнопки ниже и начните настраивать AdBlock на свой вкус"
L["If you're a bit scared of blocking important stuff:"] = "Если вы боитесь пропустить важные сообщения:"
L["Activate \"Audit\" to make sure it would not block messages you would like to keep"] = "Активируйте режим проверки, чтобы убедиться, что AdBlock не блокирует важные для вас сообщения"
L["Later, remove Audit and switch to Verbose to see when messages are being blocked"] = "Позже отключите режим проверки и активируйте \"Отчёты\", чтобы получать уведомления о блокировке сообщений в чате"
L["You can see blocked message history at any time in the settings or via /ab history show"] = "Вы можете проверить историю заблокированных сообщений в любое время в настройках модификации или через команду /ab history show"
L["Finally, you can activate Auto-Blacklist to permanently mute players that repeatedly trigger AdBlock"] = "Наконец, вы можете активировать автоматический список заблокированных, чтобы начать игнорировать игроков, которые постоянно провоцируют AdBlock"
L["Ok, show me the options!"] = "Окей, покажи мне настройки!"



--function AdBlock:ChatFilterLogic
L["Blocked message from"] = "Заблокированное сообщение от"
L["I would have blocked message from"] = "AdBlock заблокировал бы сообщение от"
L["for reason:"] = "по причине:"
L["Keywords:"] = "ключевые слова:"
