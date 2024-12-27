local lyn = lyn
local Command = lyn.Command
local Language = lyn.Language
local TimeUtils = lyn.goobie_utils.TimeUtils
local Role = lyn.Role

Command.SetCategory("User Management")

Command("#grantrole")
    :Permission("grantrole")

    :Param("player", {single_target = true})
    :Param("string", {hint = "role", check = function(ctx, input_arg)
        local value = input_arg.value
        return value and Role.Exists(value) and ctx.caller:LynCanTargetRole(value)
    end})
    :Param("duration", {default = 0})

    :Execute(function(ply, targets, role, duration)
        local target = targets[1]

        local duration_formatted
        if duration == 0 then
            duration = nil
            duration_formatted = Language.Get("commands.grantrole.permanent")
        else
            duration_formatted = TimeUtils.FormatDuration(duration)
        end

        lyn.Player.GrantRole(target, role, duration, function(err)
            if err then
                Command.Notify(ply, "#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.grantrole.notify", {
                P = ply,
                T = targets,
                role = Role.GetDisplayName(role),
                duration = duration_formatted,
            })
        end)
    end)
:Register()

Command("#revokerole")
    :Permission("revokerole")

    :Param("player", {single_target = true})
    :Param("string", {hint = "role", check = function(ctx, input_arg)
        local value = input_arg.value
        return value and Role.Exists(value) and ctx.caller:LynCanTargetRole(value)
    end})

    :Execute(function(ply, targets, role)
        local target = targets[1]

        lyn.Player.RevokeRole(target, role, function(err)
            if err then
                Command.Notify(ply, "#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.revokerole.notify", {
                P = ply,
                T = targets,
                role = Role.GetDisplayName(role),
            })
        end)
    end)
:Register()
