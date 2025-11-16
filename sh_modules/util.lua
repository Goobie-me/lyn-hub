local Lyn = Lyn
local Command = Lyn.Command
local TimeUtils = Lyn.GoobieCore.TimeUtils
local Net = Lyn.GoobieCore.Net
local Parser = Lyn.GoobieCore.Parser

local player = player
local ipairs = ipairs

Command.SetCategory("Utility")

Command("map")
    :Aliases("changemap", "setmap")
    :Permission("map")

    :Param("map")
    :Param("string", {
        hint = "gamemode",
        optional = true
    })
    :Param("duration", {
        default = 10,
    })
    :Execute(function(ply, map, gamemode, duration)
        if gamemode then
            RunConsoleCommand("gamemode", gamemode)
            LYN_NOTIFY("*", "#lyn.commands.map.notify_gamemode", {
                P = ply,
                D = duration,
            })
        else
            LYN_NOTIFY("*", "#lyn.commands.map.notify", {
                P = ply,
                D = duration,
            })
        end

        if #player.GetHumans() == 0 then
            RunConsoleCommand("changelevel", map)
        else
            timer.Create("Lyn.Command.MapRestart", duration, 1, function()
                RunConsoleCommand("changelevel", map)
            end)
        end
    end)
    :Add()

Command("maprestart")
    :Aliases("restartmap", "restartlevel", "levelrestart")
    :Permission("maprestart")

    :Param("duration", {
        default = 10,
    })

    :Execute(function(ply, duration)
        if #player.GetHumans() == 0 then
            game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n")
        else
            timer.Create("Lyn.Command.MapRestart", duration, 1, function()
                RunConsoleCommand("changelevel", game.GetMap())
            end)
        end

        LYN_NOTIFY("*", "#lyn.commands.maprestart.notify", {
            P = ply,
            D = duration,
        })
    end)
    :Add()

Command("stopmaprestart")
    :Aliases("stoprestart", "cancelrestart", "cancelmaprestart", "abortrestart")
    :Permission("maprestart")

    :Execute(function(ply)
        if not timer.Exists("Lyn.Command.MapRestart") then
            Lyn.Player.Chat.Send(ply, "#lyn.commands.stopmaprestart.no_restart")
            return
        end

        timer.Remove("Lyn.Command.MapRestart")
        LYN_NOTIFY("*", "#lyn.commands.stopmaprestart.notify", {
            P = ply,
        })
    end)
    :Add()

Command("mapreset")
    :Aliases("resetmap", "mapclear", "clearmap")
    :Permission("mapreset")

    :Execute(function(ply)
        game.CleanUpMap(false, nil, function() end)
        LYN_NOTIFY("*", "#lyn.commands.mapreset.notify", {
            P = ply,
        })
    end)
    :Add()

Command("kick")
    :Aliases("kickplayer", "playerkick")
    :Permission("kick", "admin")

    :Param("player", { single_target = true })
    :Param("string", { hint = "reason", optional = true })
    :GetRestArgs()
    :Execute(function(ply, targets, reason)
        if not reason then
            reason = Lyn.I18n.t("#lyn.unspecified")
        end

        targets[1]:Kick(reason)

        LYN_NOTIFY("*", "#lyn.commands.kick.notify", {
            P = ply,
            T = targets,
            reason = reason,
        })
    end)
    :Add()

Command("kickm")
    :Aliases("kickmulti", "kickmultiple", "kickmany")
    :Permission("kickm")

    :Param("player")
    :Param("string", { hint = "reason", optional = true })
    :GetRestArgs()
    :Execute(function(ply, targets, reason)
        if not reason then
            reason = Lyn.I18n.t("#lyn.unspecified")
        end

        for _, target in ipairs(targets) do
            target:Kick(reason)
        end

        LYN_NOTIFY("*", "#lyn.commands.kickm.notify", {
            P = ply,
            T = targets,
            reason = reason,
        })
    end)
    :Add()

Command("ban")
    :Aliases("banplayer", "playerban", "addban")
    :Permission("ban", "admin")

    :Param("player", { single_target = true })
    :Param("duration", { default = 0 })
    :Param("string", { hint = "reason", optional = true })
    :GetRestArgs()
    :Execute(function(ply, targets, duration, reason)
        if not reason then
            reason = Lyn.I18n.t("#lyn.unspecified")
        end

        Lyn.Player.Ban(targets[1], duration, reason, ply:SteamID64(), function(err)
            if err then -- db error
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end
            LYN_NOTIFY("*", "#lyn.commands.ban.notify", {
                P = ply,
                T = targets,
                D = duration,
                reason = reason,
            })
        end)
    end)
    :Add()

Command("banid")
    :Aliases("banid64", "bansteamid", "bansteamid64", "addbanid", "addbanid64", "addbansteamid", "addbansteamid64")
    :Permission("banid", "admin")

    :Param("steamid64")
    :Param("duration", { default = 0 })
    :Param("string", { hint = "reason", optional = true })
    :GetRestArgs()
    :Execute(function(ply, promise, duration, reason)
        if not reason then
            reason = Lyn.I18n.t("#lyn.unspecified")
        end

        local steamid64 = promise.steamid64
        local caller_steamid64 = ply:SteamID64()
        promise:Handle(function()
            Lyn.Player.BanSteamID64(steamid64, duration, reason, caller_steamid64, function(err2, immunity_error)
                if err2 then -- db error
                    Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                elseif immunity_error then
                    Lyn.Player.Chat.Send(ply, "#lyn.banning.immunity_error")
                else
                    LYN_NOTIFY("*", "#lyn.commands.banid.notify", {
                        P = ply,
                        target_steamid64 = steamid64,
                        D = duration,
                        reason = reason,
                    })
                end
            end)
        end)
    end)
    :Add()

Command("unban")
    :Aliases("unbanid", "unbanid64", "unbansteamid", "unbansteamid64", "removeban", "removebanid", "removebanid64",
        "removebansteamid", "removebansteamid64")
    :Permission("unban", "admin")

    :Param("steamid64")
    :Execute(function(ply, promise)
        local steamid64 = promise.steamid64
        local caller_steamid64 = ply:SteamID64()
        promise:Handle(function()
            Lyn.Player.Unban(steamid64, caller_steamid64, function(err2, no_active_ban, immunity_error)
                if err2 then -- db error
                    Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                elseif no_active_ban then
                    Lyn.Player.Chat.Send(ply, "#lyn.banning.unban_no_active_ban")
                elseif immunity_error then
                    Lyn.Player.Chat.Send(ply, "#lyn.banning.unban_immunity_error")
                else
                    LYN_NOTIFY("*", "#lyn.commands.unban.notify", {
                        P = ply,
                        target_steamid64 = steamid64,
                    })
                end
            end)
        end)
    end)
    :Add()

do
    Command("noclip")
        :Permission("noclip", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                target:SetMoveType(target:GetMoveType() == MOVETYPE_WALK and MOVETYPE_NOCLIP or MOVETYPE_WALK)
            end

            LYN_NOTIFY("*", "#lyn.commands.noclip.notify", { P = ply, T = targets })
        end)
        :Add()

    Lyn.Permission.Add("can_noclip", nil, "admin")

    hook.Add("PlayerNoClip", "Lyn.CanNoClip", function(ply)
        if ply:HasPermission("can_noclip") then
            return true
        end
    end)
end

do
    Lyn.Permission.Add("can_physgun_players", nil, "admin")

    local function freeze_player(ply)
        if SERVER then
            ply:Lock()
        end
        ply:SetMoveType(MOVETYPE_NONE)
    end

    Lyn.Hook.PreReturn("PhysgunPickup", "Lyn.CanPhysgunPlayer", function(ply, target)
        if type(target) == "Player" and ply:HasPermission("can_physgun_players") and ply:CanTarget(target) then
            return true
        end
    end)

    Lyn.Hook.Monitor("OnPhysgunPickup", "Lyn.FreezeOnPhysgunPickup", function(ply, target)
        if type(target) == "Player" and ply:HasPermission("can_physgun_players") and ply:CanTarget(target) then
            freeze_player(target)
        end
    end)

    local physgun_right_click_to_freeze = Lyn.Config.SyncValue("physgun_right_click_to_freeze", false)
    local physgun_nofalldamage = Lyn.Config.SyncValue("physgun_nofalldamage", false)
    local physgun_reset_velocity = Lyn.Config.SyncValue("physgun_reset_velocity", false)

    hook.Add("PhysgunDrop", "Lyn.PhysgunDrop", function(ply, target)
        if type(target) ~= "Player" then return end

        if physgun_right_click_to_freeze() and ply:KeyPressed(IN_ATTACK2) then
            freeze_player(target)
            if SERVER then
                Lyn.Player.SetSharedVar(target, "frozen", true)
                Lyn.Player.SetExclusive(target, "freeze")
            end
        else
            if physgun_reset_velocity() then
                target:SetLocalVelocity(Vector(0, 0, 0))
            end

            if SERVER then
                target:UnLock()
                Lyn.Player.SetSharedVar(target, "frozen", nil)
                Lyn.Player.SetExclusive(target, nil)

                if Lyn.Player.GetVar(target, "god") then
                    target:GodEnable()
                end

                Lyn.Player.SetVar(target, "physgun_drop_was_frozen", not target:IsOnGround())
            end

            target:SetMoveType(MOVETYPE_WALK)
        end
    end, HOOK_MONITOR_LOW) -- HOOK_MONITOR_LOW to run after other addons that unfreeze

    hook.Add("OnPlayerHitGround", "Lyn.PhysgunDropOnPlayerHitGround", function(ply)
        if not physgun_nofalldamage() then return end

        if Lyn.Player.GetVar(ply, "physgun_drop_was_frozen") then
            Lyn.Player.SetVar(ply, "physgun_drop_was_frozen", false)
            return true
        end
    end)
end

do
    Command("cleardecals")
        :Aliases("decalsclear", "removealldecals", "clearmapdecals")
        :Permission("cleardecals")

        :Execute(function(ply)
            Net.StartSV("Command.ClearDecals", "*")
            LYN_NOTIFY("*", "#lyn.commands.cleardecals.notify", {
                P = ply,
            })
        end)
        :Add()


    if CLIENT then
        Net.HookCL("Command.ClearDecals", function()
            game.RemoveRagdolls()
            RunConsoleCommand("r_cleardecals")
        end)
    end
end

do
    Command("stopsound")
        :Permission("stopsound")

        :Execute(function(ply)
            Net.StartSV("Command.StopSound", "*")
            LYN_NOTIFY("*", "#lyn.commands.stopsound.notify", {
                P = ply,
            })
        end)
        :Add()

    if CLIENT then
        Net.HookCL("Command.StopSound", function()
            RunConsoleCommand("stopsound")
        end)
    end
end

Command("exitvehicle")
    :Permission("exitvehicle", "admin")

    :Param("player", { single_target = true })
    :Execute(function(ply, targets)
        local target = targets[1]

        if not target:InVehicle() then
            if ply == target then
                Lyn.Player.Chat.Send(ply, "#lyn.commands.exit_vehicle.not_in_vehicle_self")
            else
                Lyn.Player.Chat.Send(ply, "#lyn.commands.exit_vehicle.not_in_vehicle_target", {
                    T = targets
                })
            end
            return
        end

        target:ExitVehicle()

        LYN_NOTIFY("*", "#lyn.commands.exit_vehicle.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

Command("bot")
    :Aliases("addbot", "spawnbot", "createbot")
    :Permission("bot")

    :Param("number", { hint = "amount", floor = true, min = 1, max = game.MaxPlayers(), default = 1 })
    :Execute(function(ply, amount)
        for _ = 1, amount do
            RunConsoleCommand("bot")
        end

        LYN_NOTIFY("*", "#lyn.commands.bot.notify", {
            P = ply,
            amount = amount,
        })
    end)
    :Add()

Command("help")
    :Param("string", { hint = "command", optional = true })
    :GetRestArgs()
    :Execute(function(ply, cmd_name)
        if cmd_name then
            local cmd = Command.Search(cmd_name)
            if not cmd or (cmd:GetPermissionName() and not ply:HasPermission(cmd:GetPermissionName())) then
                Lyn.Player.Chat.Send(ply, "#lyn.commands.help.no_command", {
                    command = cmd_name
                })
                return
            end
            Net.StartSV("Command.Help", ply, cmd.name, cmd_name)
        else
            Net.StartSV("Command.Help", ply)
        end
    end)
    :Add()

if CLIENT then
    Net.HookCL("Command.Help", function(cmd_name, matched_identifier)
        if cmd_name then
            Command.SendSyntax({
                cmd = Command.Get(cmd_name),
                caller = LocalPlayer(),
                parsed_args = {},
                matched_prefix = matched_identifier,
            })
        else
            local commands = Command.GetAll()
            local chat_lines = {}

            for _, cmd in pairs(commands) do
                if not cmd:GetPermissionName() or LocalPlayer():HasPermission(cmd:GetPermissionName()) then
                    if cmd.help then
                        table.insert(chat_lines, Parser.escape(cmd.chat_prefix .. cmd.name .. " - " .. cmd.help))
                    else
                        table.insert(chat_lines, Parser.escape(cmd.chat_prefix .. cmd.name))
                    end
                end
            end

            if #chat_lines > 0 then
                Lyn.Player.Chat.Add(table.concat(chat_lines, "\n"))
            end
        end
    end)
end

Command("time")
    :Permission("time", Lyn.Role.Defaults())

    :Param("player", { single_target = true, default = "^" })
    :Execute(function(ply, targets)
        if ply == targets[1] then
            Lyn.Player.Chat.Send(ply, "#lyn.commands.time.your", {
                D = Lyn.Player.GetPlayTime(ply)
            })
        else
            Lyn.Player.Chat.Send(ply, "#lyn.commands.time.target", {
                T = targets, D = Lyn.Player.GetPlayTime(targets[1])
            })
        end
    end)
    :Add()
