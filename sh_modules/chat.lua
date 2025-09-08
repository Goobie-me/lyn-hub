local lyn = lyn
local Command = lyn.Command
local TimeUtils = lyn.goobie_utils.TimeUtils
local Language = lyn.Language

local ipairs = ipairs

Command.SetCategory("Chat")

Command("pm")
    :Permission("pm", lyn.Role.Defaults())

    :Param("player", { single_target = true, allow_higher_target = true, cant_target_self = true })
    :Param("string", {
        hint = "message",
        check = function(ctx)
            local value = ctx.value
            return value and value:match("%S") ~= nil
        end
    })
    :GetRestArgs()
    :Execute(function(ply, targets, message)
        local target = targets[1]

        lyn.Player.SendFmtText(ply, "#commands.pm.to", {
            T = targets,
            message = message
        })

        lyn.Player.SendFmtText(target, "#commands.pm.from", {
            P = ply,
            message = message
        })
    end)
    :Register()

-- asay
lyn.Permission.Register("see_admin_chat", nil, "admin")

Command("asay")
    :CustomAlias("@", {
        sticky = true,
        chat_prefix = "",
    })

    :Permission("asay", lyn.Role.Defaults())

    :Param("string", {
        hint = "message",
        check = function(ctx)
            local value = ctx.value
            return value and value:match("%S") ~= nil
        end
    })
    :GetRestArgs()
    :Execute(function(ply, message)
        local targets = { ply }
        for _, target in player.Iterator() do
            if target:HasPermission("see_admin_chat") and target ~= ply then
                table.insert(targets, target)
            end
        end

        -- Not using Command.Notify because it's a message
        if ply:HasPermission("see_admin_chat") then
            lyn.Player.SendFmtText(targets, "#commands.asay.notify", {
                P = ply,
                message = message
            })
        else
            lyn.Player.SendFmtText(targets, "#commands.asay.notify_no_access", {
                P = ply,
                message = message
            })
        end
    end)
    :Register()
--

-- mute
Command("mute")
    :Permission("mute", "admin")

    :Param("player")
    :Param("duration", {
        min = 0, default = "5m",
    })
    :Param("string", { hint = "reason", default = Language.Get("unspecified") })
    :GetRestArgs()
    :Execute(function(ply, targets, duration, reason)
        local till = duration ~= 0 and os.time() + duration or 0

        for _, target in ipairs(targets) do
            target:LynSetPData("muted", {
                till = till,
                reason = reason
            })
        end

        Command.Notify("*", "#commands.mute.notify", {
            P = ply,
            T = targets,
            duration = TimeUtils.FormatDuration(duration),
            reason = reason,
        })
    end)
    :Register()

Command("unmute")
    :Permission("unmute", "admin")

    :Param("player", { default = "^" })
    :GetRestArgs()
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:LynSetPData("muted", nil)
        end

        Command.Notify("*", "#commands.unmute.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

if SERVER then
    local function is_muted(ply, no_notify)
        local muted = ply:LynGetPData("muted")
        if not muted then return end

        local till = muted.till
        if till == 0 or till > os.time() then
            if not no_notify then
                local duration = till == 0 and 0 or till - os.time()
                ply:LynSendFmtText("#commands.mute.notify_muted", {
                    duration = TimeUtils.FormatDuration(duration),
                    reason = muted.reason
                })
            end
            return true
        end

        ply:LynSetPData("muted", nil)
    end

    hook.Add("PlayerSay", "Lyn.Chat.Mute", function(ply)
        if is_muted(ply) then
            return ""
        end
    end)

    hook.Add("Lyn.Player.Command.CanExecute", "Lyn.Chat.Mute", function(ply, cmd_name)
        if cmd_name == "pm" then
            if is_muted(ply) then
                return false
            end
        end
    end)
end
--

-- gag
Command("gag")
    :Permission("gag", "admin")

    :Param("player")
    :Param("duration", {
        min = 0, default = "5m",
    })
    :Param("string", { hint = "reason", default = Language.Get("unspecified") })
    :GetRestArgs()
    :Execute(function(ply, targets, duration, reason)
        for _, target in ipairs(targets) do
            target:LynSetPData("gagged", {
                till = duration ~= 0 and os.time() + duration or 0,
                reason = reason
            })
            if duration ~= 0 then
                lyn.Player.Timer.Create(target, "Lyn.Chat.Gag", duration, 1, function()
                    target:LynSetPData("gagged", nil)
                end)
            end
        end

        Command.Notify("*", "#commands.gag.notify", {
            P = ply,
            T = targets,
            duration = TimeUtils.FormatDuration(duration),
            reason = reason,
        })
    end)
    :Register()

Command("ungag")
    :Permission("ungag", "admin")

    :Param("player", { default = "^" })
    :GetRestArgs()
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:LynSetPData("gagged", nil)
            lyn.Player.Timer.Remove(target, "Lyn.Chat.Gag")
        end

        Command.Notify("*", "#commands.ungag.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

if SERVER then
    local GetPData = lyn.Player.GetPData

    hook.Add("PlayerCanHearPlayersVoice", "Lyn.Chat.Gag", function(_, ply)
        if GetPData(ply, "gagged") then
            return false
        end
    end)

    hook.Add("Lyn.Player.Auth", "Lyn.Chat.Gag", function(ply)
        local gag_info = GetPData(ply, "gagged")
        if not gag_info then return end

        local till = gag_info.till
        if till == 0 then return end

        local remaining = till - os.time()
        lyn.Player.Timer.Create(ply, "Lyn.Chat.Gag", remaining, 1, function()
            ply:LynSetPData("gagged", nil)
        end)
    end)
end
--


Command("speakas")
    :Permission("speakas")

    :Param("player", { single_target = true, cant_target_self = true })
    :Param("string", {
        hint = "message",
        check = function(ctx)
            local value = ctx.value
            return value and value:match("%S") ~= nil
        end
    })
    :GetRestArgs()
    :Execute(function(ply, targets, message)
        local target = targets[1]
        target:Say(message)
    end)
    :Register()
