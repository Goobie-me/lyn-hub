local Lyn = Lyn
local Command = Lyn.Command
local TimeUtils = Lyn.GoobieCore.TimeUtils
local Language = Lyn.Language

local ipairs = ipairs

Command.SetCategory("Chat")

Command("pm")
    :Permission("pm", Lyn.Role.Defaults())

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

        Lyn.Player.Chat.Send(ply, "#commands.pm.to", {
            T = targets,
            message = message
        })

        Lyn.Player.Chat.Send(target, "#commands.pm.from", {
            P = ply,
            message = message
        })
    end)
    :Add()

-- asay
Lyn.Permission.Add("see_admin_chat", nil, "admin")

Command("asay")
    :CustomAlias("@", {
        sticky = true,
        chat_prefix = "",
    })

    :Permission("asay", Lyn.Role.Defaults())

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

        -- Not using LYN_NOTIFY because it's a message
        if ply:HasPermission("see_admin_chat") then
            Lyn.Player.Chat.Send(targets, "#commands.asay.notify", {
                P = ply,
                message = message
            })
        else
            Lyn.Player.Chat.Send(targets, "#commands.asay.notify_no_access", {
                P = ply,
                message = message
            })
        end
    end)
    :Add()
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
            Lyn.Player.SetPData(target, "muted", {
                till = till,
                reason = reason
            })
        end

        LYN_NOTIFY("*", "#commands.mute.notify", {
            P = ply,
            T = targets,
            duration = TimeUtils.FormatDuration(duration),
            reason = reason,
        })
    end)
    :Add()

Command("unmute")
    :Permission("unmute", "admin")

    :Param("player", { default = "^" })
    :GetRestArgs()
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            Lyn.Player.SetPData(target, "muted", nil)
        end

        LYN_NOTIFY("*", "#commands.unmute.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

if SERVER then
    local function is_muted(ply, no_notify)
        local muted = Lyn.Player.GetPData(ply, "muted")
        if not muted then return end

        local till = muted.till
        if till == 0 or till > os.time() then
            if not no_notify then
                local duration = till == 0 and 0 or till - os.time()
                Lyn.Player.Chat.Send(ply, "#commands.mute.notify_muted", {
                    duration = TimeUtils.FormatDuration(duration),
                    reason = muted.reason
                })
            end
            return true
        end

        Lyn.Player.SetPData(ply, "muted", nil)
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
            Lyn.Player.SetPData(target, "gagged", {
                till = duration ~= 0 and os.time() + duration or 0,
                reason = reason
            })
            if duration ~= 0 then
                Lyn.Player.Timer.Create(target, "Lyn.Chat.Gag", duration, 1, function()
                    Lyn.Player.SetPData(target, "gagged", nil)
                end)
            end
        end

        LYN_NOTIFY("*", "#commands.gag.notify", {
            P = ply,
            T = targets,
            duration = TimeUtils.FormatDuration(duration),
            reason = reason,
        })
    end)
    :Add()

Command("ungag")
    :Permission("ungag", "admin")

    :Param("player", { default = "^" })
    :GetRestArgs()
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            Lyn.Player.SetPData(target, "gagged", nil)
            Lyn.Player.Timer.Remove(target, "Lyn.Chat.Gag")
        end

        LYN_NOTIFY("*", "#commands.ungag.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

if SERVER then
    local GetPData = Lyn.Player.GetPData

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
        Lyn.Player.Timer.Create(ply, "Lyn.Chat.Gag", remaining, 1, function()
            Lyn.Player.SetPData(ply, "gagged", nil)
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
    :Add()
