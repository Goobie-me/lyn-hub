local lyn = lyn
local Command = lyn.Command
local Language = lyn.Language
local TimeUtils = lyn.goobie_utils.TimeUtils
local Net = lyn.goobie_utils.Net

local player = player

Command.SetCategory("Utility")

Command("#maprestart")
    :Permission("maprestart")

    :Execute(function(ply)
        if #player.GetHumans() == 0 then
            game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n")
        else
            timer.Create("Lyn.Command.MapRestart", 10, 1, function()
                RunConsoleCommand("changelevel", game.GetMap())
            end)
        end

        Command.Notify("*", "#commands.maprestart.notify", {
            P = ply,
        })
    end)
    :Register()

Command("#stopmaprestart")
    :Permission("maprestart")

    :Execute(function(ply)
        if not timer.Exists("Lyn.Command.MapRestart") then
            Command.Notify(ply, "#commands.stopmaprestart.no_restart")
            return
        end

        timer.Remove("Lyn.Command.MapRestart")
        Command.Notify("*", "#commands.stopmaprestart.notify", {
            P = ply,
        })
    end)
    :Register()

Command("#mapreset")
    :Permission("mapreset")

    :Execute(function(ply)
        game.CleanUpMap(false, nil, function() end)
        Command.Notify("*", "#commands.mapreset.notify", {
            P = ply,
        })
    end)
    :Register()

Command("#kick")
    :Permission("kick", "admin")

    :Param("player", { single_target = true, disable_self_as_default = true })
    :Param("string", { hint = "reason", default = Language.Get("kicking.default_reason") })

    :Execute(function(ply, targets, reason)
        targets[1]:Kick(reason)

        Command.Notify("*", "#commands.kick.notify", {
            P = ply,
            T = targets,
            reason = reason,
        })
    end)
    :Register()

Command("#kickm")
    :Permission("kickm")

    :Param("player", { disable_self_as_default = true })
    :Param("string", { hint = "reason", default = Language.Get("kicking.default_reason") })

    :Execute(function(ply, targets, reason)
        for i = 1, #targets do
            targets[i]:Kick(reason)
        end

        Command.Notify("*", "#commands.kickm.notify", {
            P = ply,
            T = targets,
            reason = reason,
        })
    end)
    :Register()

Command("#ban")
    :Permission("ban", "admin")

    :Param("player", { single_target = true, disable_self_as_default = true })
    :Param("duration", { default = 0 })
    :Param("string", { hint = "reason", default = Language.Get("banning.default_reason") })

    :GetRestArgs()

    :Execute(function(ply, targets, duration, reason)
        local duration_formatted
        if duration == 0 then
            duration = nil
            duration_formatted = Language.Get("banning.ends_in_permanent")
        else
            duration_formatted = TimeUtils.FormatDuration(duration)
        end

        lyn.Player.Ban(targets[1], duration, reason, ply:SteamID64(), function(err)
            if err then -- db error
                Command.Notify(ply, "#commands.failed_to_run")
                return
            end
            Command.Notify("*", "#commands.ban.notify", {
                P = ply,
                T = targets,
                duration = duration_formatted,
                reason = reason,
            })
        end)
    end)
    :Register()

Command("#banid")
    :Permission("banid", "admin")

    :Param("steamid64")
    :Param("duration", { default = 0 })
    :Param("string", { hint = "reason", default = Language.Get("banning.default_reason") })

    :GetRestArgs()

    :Execute(function(ply, promise, duration, reason)
        local steamid64 = promise.steamid64
        local caller_steamid64 = ply:SteamID64()
        promise:Handle(function()
            local duration_formatted
            if duration == 0 then
                duration = nil
                duration_formatted = Language.Get("banning.ends_in_permanent")
            else
                duration_formatted = TimeUtils.FormatDuration(duration)
            end

            lyn.Player.BanSteamID64(steamid64, duration, reason, caller_steamid64, function(err2, immunity_error)
                if err2 then -- db error
                    Command.Notify(ply, "#commands.failed_to_run")
                elseif immunity_error then
                    Command.Notify(ply, "#banning.immunity_error")
                else
                    Command.Notify("*", "#commands.banid.notify", {
                        P = ply,
                        target_steamid64 = steamid64,
                        duration = duration_formatted,
                        reason = reason,
                    })
                end
            end)
        end)
    end)
    :Register()

Command("#unban")
    :Permission("unban", "admin")

    :Param("steamid64")

    :Execute(function(ply, promise)
        local steamid64 = promise.steamid64
        local caller_steamid64 = ply:SteamID64()
        promise:Handle(function()
            lyn.Player.Unban(steamid64, caller_steamid64, function(err2, no_active_ban, immunity_error)
                if err2 then -- db error
                    Command.Notify(ply, "#commands.failed_to_run")
                elseif no_active_ban then
                    Command.Notify(ply, "#banning.unban_no_active_ban")
                elseif immunity_error then
                    Command.Notify(ply, "#banning.unban_immunity_error")
                else
                    Command.Notify("*", "#commands.unban.notify", {
                        P = ply,
                        target_steamid64 = steamid64,
                    })
                end
            end)
        end)
    end)
    :Register()

Command("#bot")
    :Permission("bot")

    :Param("number", { hint = "amount", floor = true, min = 1, max = game.MaxPlayers(), default = 1 })

    :Execute(function(ply, amount)
        for i = 1, amount do
            RunConsoleCommand("bot")
        end

        Command.Notify("*", "#commands.bot.notify", {
            P = ply,
            amount = amount,
        })
    end)
    :Register()

Command("#help")
    :Param("string", { hint = "command", optional = true })

    :GetRestArgs()

    :Execute(function(ply, cmd_name)
        if cmd_name then
            local cmd = Command.Search(cmd_name)
            if not cmd or (cmd:GetPermissionName() and not ply:LynHasPermission(cmd:GetPermissionName())) then
                Command.Notify(ply, "#commands.help.no_command", {
                    command = cmd_name
                })
                return
            end
            Net.StartSV("Command.Help", ply, cmd.name, cmd_name)
        else
            Net.StartSV("Command.Help", ply)
        end
    end)
    :Register()

if CLIENT then
    Net.HookCL("Command.Help", function(cmd_name, matched_identifier)
        if cmd_name then
            Command.SendSyntax({
                command = Command.Get(cmd_name),
                caller = LocalPlayer(),
                input_args = {},
                invalid_idxs = {},
                command_text_match = matched_identifier,
            })
        else
            local commands = Command.GetAll()
            for _, cmd in pairs(commands) do
                if not cmd:GetPermissionName() or LocalPlayer():LynHasPermission(cmd:GetPermissionName()) then
                    if cmd.help then
                        lyn.Player.SendText(cmd.chat_prefix .. cmd.name .. " - " .. cmd.help)
                    else
                        lyn.Player.SendText(cmd.chat_prefix .. cmd.name)
                    end
                end
            end
        end
    end)
end
