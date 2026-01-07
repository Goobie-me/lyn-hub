---@diagnostic disable: lowercase-global

-- You can access globals using GLOBAL variable, don't ask why.

steamid64 = "SteamID64"

-- 用作大多数命令的默认"原因"，例如封禁、踢出、禁言等
unspecified = "未指定"

player_role_expired = "您的角色 {red %role%} 已过期。"

-- 所有目标、您、您自己、所有人、未知、控制台都会在前面加上白色的"*"
-- 这是为了更容易将它们与同名的玩家区分开来。
targets = {
    -- 这将在 {P} 内部使用
    you = {
        title = "您",
        color = "#FFD700"
    },

    yourself = "您自己", -- 颜色将与"You"相同

    himself = "他自己", -- 颜色将与其角色颜色相同

    -- 当目标是"*"时，这将在 {T} 内部使用
    -- 当它在聊天中打印所有人时，并不是字面意义上的所有人，而是玩家可以目标的所有人。
    everyone = {
        title = "所有人",
        color = "#9900FF"
    },

    -- 如果 {P} 不是玩家/控制台/字符串，将使用此选项
    unknown = {
        title = "未知",
        color = "#505050"
    },

    -- 如果 {P} 是控制台，将使用此选项，其他需要引用控制台名称的函数也会使用
    console = {
        title = "控制台",
        color = "#2E8889"
    }
}

themes = {
    Blur = "模糊",
    Dark = "暗色",
    Light = "亮色",
}

banning = {
    immunity_error =
    "您无法修改此玩家的封禁，因为它是由免疫等级比您高的人发出的。",

    unban_immunity_error =
    "您无法解封此玩家，因为他们的封禁是由免疫等级比您高的人发出的。",
    unban_no_active_ban = "该用户当前未被封禁。",

    -- %reason% - 玩家被封禁的原因。
    -- %banned_at% - 玩家被封禁的日期和时间。格式为 %d-%b-%Y %I:%M %p (例如：01-Jan-1970 12:00 AM)
    -- %expires_at% - 玩家将被解封的日期和时间。格式为 %d-%b-%Y %I:%M %p (例如：01-Jan-1970 12:00 AM)
    -- %ends_in% - 玩家解封前的剩余时间。格式为 "1 小时 10 分钟 5 秒"
    -- %admin_name% - 封禁玩家的管理员名称。
    -- %admin_steamid64% - 封禁玩家的管理员的 SteamID64。
    message = [[
您已被从此服务器封禁。

- 封禁者：%admin_name% (%admin_steamid64%)
- 原因：%reason%
- 封禁日期：%banned_at%
- 解封日期：%expires_at%
- 剩余时间：%ends_in%

如果您认为此封禁是错误发出的，请联系服务器工作人员。
]]
}

menu = {
    tabs = {
        commands = {
            title = "命令",
        },
        players = {
            title = "玩家",
            player = "玩家",
            playtime = "游戏时间",
            first_join = "首次加入",
            last_join = "最后加入",
            name = "名称",
            role = "角色",
            copy_name = "复制名称",
            copy_steamid = "复制 SteamID",
            copy_steamid64 = "复制 SteamID64",
            remove_role = "移除角色",
            add_role = "添加角色",
            hide_bots = "隐藏机器人",
        },
        bans = {
            title = "封禁",
            player = "玩家",
            banned_by = "封禁者",
            expires_in = "过期时间",
            expires_at = "过期于",
            reason = "原因",
            ban_date = "封禁日期",
            copy_steamid = "复制 SteamID",
            copy_steamid64 = "复制 SteamID64",
            copy_admin_steamid64 = "复制管理员的 SteamID64",
            copy_reason = "复制原因",
        },
        roles = {
            title = "角色",
        },
        config = {
            title = "配置",
            tabs = {
                general = "常规",
                adverts = "广告",
                physgun = "物理枪",
                updates = "更新",
            }
        }
    },
    search = "搜索...",
}

extra = {
    no_tool_permission = "您没有权限使用 {red %tool%} 工具",
}

commands_core = {
    cant_use_as_console = "您必须是玩家才能使用 {red %command%} 命令。",
    no_permission = "您没有权限使用 {red %command%} 命令。",

    -- 当数据库查询失败等情况下可能发生。
    failed_to_run = "运行命令失败。请检查服务器控制台以获取更多信息。",

    exclusive_error = "无法在 {T} 上运行此命令 - {red %reason%} 当前处于活动状态",
    exclusive_error_targets = "独占活动 - 跳过 {T}",

    arguments = {
        -- 当玩家输入无效参数时发送。
        -- 例如："无效的 steamid！(784154572)"
        -- "无效的数字！(invalidsdsds)"
        invalid = "无效的 %argument%！输入：{red %input%}",

        -- %valid_inputs% - 参数的有效输入列表。不能在 {} 内部使用。
        -- %param_idx% - 参数在命令中的索引。
        -- %param_name% - 参数的提示/名称。
        -- %input% - 玩家提供的输入。
        restricted =
        "参数 {blue %param_name%} #{gold %param_idx%}，输入为 {red %input%}，被限制为：%valid_inputs%",

        cant_find_target = "找不到与 {red %target%} 匹配的玩家",
        target_not_authed = "您无法目标 {T}，因为他们尚未通过身份验证。",
        cant_target = "您无法目标 {T}。",
        cant_target_self = "您无法使用 {red %command%} 命令目标自己。",
        cant_target_multiple = "您无法使用 {red %command%} 命令目标多个玩家。",

        -- 当尝试使用实体 ID 目标玩家时触发，例如：
        -- !kick #1
        -- 当输入不是数字时发送无效 ID 消息。
        invalid_id = "无效的 ID（{red %input%}）！",

        player_id_not_found = "找不到 ID 为 {red %input%} 的玩家",

        player_steamid_not_found = "找不到 SteamID/SteamID64 为 {red %input%} 的玩家",

        -- 当命令只接受单个目标但找到多个匹配项时发送。
        multiple_players_found = "找到多个玩家：{T}",

        -- 当有玩家但无法目标其中任何一个时使用。（更高角色、尚未验证等）
        no_valid_targets = "未找到有效目标。",

        role_does_not_exist = "角色 {red %role%} 不存在。",
    },

    -- 提示翻译会自动使用，不像命令名称那样需要在前面加 #。
    hints = {
        duration = "持续时间",
        number = "数字",
        player = "玩家",
        reason = "原因",
        steamid64 = "steamid64",
        string = "字符串",

        amount = "数量",
        role = "角色",
        immunity = "免疫等级",
        display_name = "显示名称",
        color = "颜色",
        message = "消息",
        extends = "继承",
        model = "模型",
        damage = "伤害",
        permission = "权限",
        map = "地图",
        gamemode = "游戏模式",
        command = "命令",
        ["weapon/entity"] = "武器/实体",
        shipment = "货物",
    },
}

commands = {
    help = {
        help = "显示可用命令列表或获取特定命令的帮助。",
        no_command = "找不到名为 {red %command%} 的命令",
    },

    menu = {
        help = "打开管理模组菜单。",
    },

    -- 聊天

    pm = {
        help = "向玩家发送私信。",

        to = "{gold 私信} 至 {T}：{green %message%}",
        from = "{gold 私信} 来自 {P}：{green %message%}",
    },

    asay = {
        help = "发送消息到管理员聊天。",

        notify = "[{lightred 管理员}] {P}：{green %message%}",
        notify_no_access = "{P} 至 {lightred 管理员}：{red %message%}",
    },

    speakas = {
        help = "以其他玩家的身份发送消息。",
    },

    mute = {
        help = "禁言玩家。",
        notify = "{P} 禁言了 {T}，持续 {D}，原因：{red %reason%}",

        notify_muted = "您已被禁言，持续 {D}，原因：{red %reason%}"
    },

    unmute = {
        help = "解除玩家禁言。",
        notify = "{P} 解除了 {T} 的禁言",
    },

    gag = {
        help = "禁音玩家。",
        notify = "{P} 禁音了 {T}，持续 {D}，原因：{red %reason%}",
    },

    ungag = {
        help = "解除玩家禁音。",
        notify = "{P} 解除了 {T} 的禁音",
    },

    -- 趣味命令

    hp = {
        help = "设置玩家的生命值。",
        notify = "{P} 将 {T} 的生命值设置为 {green %amount%}",
    },

    armor = {
        help = "设置玩家的护甲值。",
        notify = "{P} 将 {T} 的护甲值设置为 {green %amount%}",
    },

    give = {
        help = "给予玩家武器或实体。",
        notify = "{P} 给予了 {T} {green %class%}",
    },

    slap = {
        help = "拍打玩家，使其受到伤害。",

        notify = "{P} 拍打了 {T}",
        notify_damage = "{P} 拍打了 {T}，造成 {green %damage%} 伤害",
    },

    slay = {
        help = "杀死玩家，使其立即死亡。",
        notify = "{P} 杀死了 {T}",
    },

    ignite = {
        help = "点燃玩家，使其着火。",
        notify = "{P} 点燃了 {T}，持续 {D} 秒",
    },

    unignite = {
        help = "熄灭玩家，移除火焰效果。",
        notify = "{P} 熄灭了 {T}",
    },

    god = {
        help = "为玩家启用上帝模式。",
        notify = "{P} 为 {T} 启用了上帝模式",
    },

    ungod = {
        help = "为玩家禁用上帝模式。",
        notify = "{P} 为 {T} 禁用了上帝模式",
    },

    buddha = {
        help = "使玩家在生命值为 1 时无敌。",
        notify = "{P} 为 {T} 启用了佛模式",
    },

    unbuddha = {
        help = "为玩家禁用佛模式。",
        notify = "{P} 为 {T} 禁用了佛模式",
    },

    freeze = {
        help = "冻结玩家。",
        notify = "{P} 冻结了 {T}",
    },

    unfreeze = {
        help = "解冻玩家。",
        notify = "{P} 解冻了 {T}",
    },

    cloak = {
        help = "隐身玩家，使其不可见。",
        notify = "{P} 隐身了 {T}",
    },

    uncloak = {
        help = "取消玩家隐身，使其再次可见。",
        notify = "{P} 取消了 {T} 的隐身",
    },

    jail = {
        help = "监禁玩家。",
        notify = "{P} 监禁了 {T}，持续 {D}，原因：{red %reason%}",
    },

    unjail = {
        help = "释放玩家。",
        notify = "{P} 释放了 {T}",
    },

    strip = {
        help = "剥夺玩家的武器。",
        notify = "{P} 剥夺了 {T} 的武器",
    },

    setmodel = {
        help = "设置玩家的模型。",
        notify = "{P} 将 {T} 的模型设置为 {green %model%}",
    },

    giveammo = {
        help = "给予玩家弹药。",
        notify = "{P} 给予了 {T} {green %amount%} 弹药",
    },

    scale = {
        help = "将玩家缩放到特定大小。",
        notify = "{P} 将 {T} 缩放至 {green %amount%}",
    },

    freezeprops = {
        help = "冻结世界中的道具。",
        notify = "{P} 冻结了所有道具",
    },

    respawn = {
        help = "重生玩家。",
        notify = "{P} 重生了 {T}",
    },

    -- 传送

    bring = {
        help = "将玩家传送至自己身边。",
        notify = "{P} 带来了 {T}",
    },

    ["goto"] = {
        help = "传送至玩家身边。",
        notify = "{P} 传送至 {T} 身边",
        no_space = "{T} 身边没有空间可传送！",
    },

    ["return"] = {
        help = "返回使用'goto'或'bring'之前的位置。",
        notify = "{P} 将 {T} 返回至先前位置",
        no_previous_location = "未找到 {P} 的先前位置",
    },

    -- 用户管理命令

    playeraddrole = {
        help = "为玩家添加角色。",
        notify = "{P} 为 {T} 添加了角色 {green %role%}，持续 {D}",
    },

    playeraddroleid = {
        help = "通过 SteamID/SteamID64 为玩家添加角色。",
        notify = "{P} 为 {red %target_steamid64%} 添加了角色 {green %role%}，持续 {D}",
    },

    playerremoverole = {
        help = "移除玩家的角色。",
        notify = "{P} 移除了 {T} 的角色 {red %role%}",
    },

    playerremoveroleid = {
        help = "通过 SteamID/SteamID64 移除玩家的角色。",
        notify = "{P} 移除了 {red %target_steamid64%} 的角色 {red %role%}",
    },

    playerextendrole = {
        help = "延长玩家角色的有效期。",
        notify = "{P} 将 {T} 的 {green %role%} 角色延长了 {D}",
    },

    playerextendroleid = {
        help = "通过 SteamID/SteamID64 延长玩家角色的有效期。",
        notify = "{P} 将 {red %target_steamid64%} 的 {green %role%} 角色延长了 {D}",
    },

    createrole = {
        help = "创建新角色。",
        notify = "{P} 创建了新角色：{green %role%}",
    },

    deleterole = {
        help = "删除角色。",
        notify = "{P} 删除了角色：{red %role%}",
    },

    renamerole = {
        help = "重命名角色。",
        notify = "{P} 将角色 {red %old_role%} 重命名为 {green %new_role%}",
    },

    setroleimmunity = {
        help = "更改角色的免疫等级。",
        notify = "{P} 将 {green %role%} 的免疫等级更改为 {green %immunity%}",
    },

    setroledisplayname = {
        help = "更改角色的显示名称。",
        notify = "{P} 将 {green %role%} 的显示名称更改为 {green %display_name%}",
    },

    setrolecolor = {
        help = "更改角色的颜色。",
        notify = "{P} 将 {green %role%} 的颜色更改为 {green %color%}",
    },

    setroleextends = {
        help = "设置或清除此角色继承的角色。",

        notify_set = "{P} 设置 {green %role%} 继承 {green %extends%}",
        notify_removed = "{P} 移除了 {green %role%} 的继承",
    },

    roleaddpermission = {
        help = "为角色添加权限。",
        notify = "{P} 为角色 {green %role%} 添加了权限 {green %permission%}",
    },

    roleremovepermission = {
        help = "移除角色的权限。",
        notify = "{P} 从角色 {green %role%} 移除了权限 {red %permission%}",
    },

    roledeletepermission = {
        help = "删除角色的权限。与移除不同，它会删除覆盖，以便应用继承。",
        notify = "{P} 从角色 {green %role%} 删除了权限 {red %permission%}",
    },

    -- 实用命令

    map = {
        help = "更改当前地图和/或游戏模式。",

        notify = "{P} 已发起地图更改，将在 {D} 后执行。",
        notify_gamemode =
        "{P} 已发起地图更改，将在 {D} 后执行，游戏模式设置为 {green %gamemode%}。",
    },

    maprestart = {
        help = "重启当前地图。",
        notify =
        "{P} 已发起地图重启，将在 {D} 后执行。"
    },

    stopmaprestart = {
        help = "停止当前的地图重启。",
        notify = "{P} 已停止地图重启",
        no_restart = "没有正在进行的地图重启"
    },

    mapreset = {
        help = "重置当前地图。",
        notify = "{P} 执行了地图重置"
    },

    kick = {
        help = "将玩家踢出服务器。",
        notify = "{P} 踢出了 {T}，原因：{red %reason%}",
    },

    kickm = {
        help = "将多个玩家踢出服务器。",
        notify = "{P} 踢出了 {T}，原因：{red %reason%}",
    },

    ban = {
        help = "封禁玩家。",
        notify = "{P} 封禁了 {T}，持续 {D}，原因：{red %reason%}",
    },

    banid = {
        help = "通过 SteamID/SteamID64 封禁玩家。",
        notify = "{P} 封禁了 {red %target_steamid64%}，持续 {D}，原因：{red %reason%}",
    },

    unban = {
        help = "解封玩家。",
        notify = "{P} 解封了 {red %target_steamid64%}",
    },

    noclip = {
        help = "切换玩家的穿墙模式。",
        notify = "{P} 切换了 {T} 的穿墙模式",
    },

    cleardecals = {
        help = "为所有玩家清除布娃娃和贴花。",
        notify = "{P} 为所有玩家清除了布娃娃和贴花。",
    },

    stopsound = {
        help = "停止所有玩家的所有声音。",
        notify = "{P} 停止了所有声音",
    },

    exit_vehicle = {
        help = "强制玩家离开载具。",

        not_in_vehicle_self = "您不在载具中！",
        not_in_vehicle_target = "{T} 不在载具中！",

        notify = "{P} 强制 {T} 离开载具",
    },

    bot = {
        help = "向服务器添加机器人。",
        notify = "{P} 向服务器添加了 {green %amount%} 个机器人",
    },

    time = {
        help = "检查玩家的游戏时间。",
        your = "您的游戏时间：{D}",
        target = "{T} 的游戏时间：{D}",
    },

    -- DarkRP

    arrest = {
        help = "逮捕玩家。",
        notify = "{P} 永久逮捕了 {T}",
        notify_duration = "{P} 逮捕了 {T}，时长 {D}",
    },

    unarrest = {
        help = "释放玩家。",
        notify = "{P} 释放了 {T}",
    },

    setmoney = {
        help = "设置玩家金钱。",
        notify = "{P} 将 {T} 的金钱设为 {green %amount%}",
    },

    addmoney = {
        help = "给玩家添加金钱。",
        notify = "{P} 给 {T} 添加了 {green %amount%}",
    },

    selldoor = {
        help = "出售你正在看的门/载具。",
        notify = "{P} 为 {T} 出售了一扇门/载具",
        invalid = "无效的门",
        no_owner = "这扇门没有主人",
    },

    sellall = {
        help = "出售玩家拥有的所有门/载具。",
        notify = "{P} 为 {T} 出售了所有门/载具",
    },

    darkrpsetjailpos = {
        help = "重置所有监狱位置并在你的位置设置新位置。",
        notify = "{P} 设置了新的 DarkRP 监狱位置",
    },

    darkrpaddjailpos = {
        help = "在你的当前位置添加监狱位置。",
        notify = "{P} 添加了新的 DarkRP 监狱位置",
    },

    setjob = {
        help = "更改玩家职业。",
        notify = "{P} 将 {T} 的职业设为 {green %job%}",
    },

    shipment = {
        help = "生成一个货物。",
        notify = "{P} 生成了 {green %shipment%} 货物",
    },

    forcename = {
        help = "强制更改玩家名称。",
        notify = "{P} 将 {T} 的名称设为 {green %name%}",
        taken = "名称已被使用 ({red %name%})",
    },
}
