local lyn = lyn
local Command = lyn.Command
local Language = lyn.Language
local TimeUtils = lyn.goobie_utils.TimeUtils
local Role = lyn.Role

Command.SetCategory("User Management")

Command("grantrole")
    :Aliases("giverole", "rolegrant", "rolegive", "setrole", "adduser", "giverank", "setrank")
    :Permission("grantrole")

    :Param("player", { single_target = true })
    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and ctx.caller:CanTargetRole(value)
        end
    })
    :Param("duration", { default = 0 })
    :Execute(function(ply, targets, role, duration)
        local target = targets[1]

        local duration_formatted = TimeUtils.FormatDuration(duration)
        lyn.Player.GrantRole(target, role, duration, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
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

Command("grantroleid")
    :Aliases("grantroleid64", "grantrolesteamid", "grantrolesteamid64", "giveroleid", "giveroleid64", "giverolesteamid",
        "giverolesteamid64", "adduserid")
    :Permission("grantroleid")

    :Param("steamid64")
    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and ctx.caller:CanTargetRole(value)
        end
    })
    :Param("duration", { default = 0 })
    :Execute(function(ply, promise, role, duration)
        local steamid64 = promise.steamid64
        promise:Handle(function()
            local duration_formatted = TimeUtils.FormatDuration(duration)
            lyn.Player.GrantRoleSteamID64(steamid64, role, duration, function(err)
                if err then
                    ply:LynSendFmtText("#commands.failed_to_run")
                    return
                end

                Command.Notify("*", "#commands.grantroleid.notify", {
                    P = ply,
                    target_steamid64 = steamid64,
                    role = Role.GetDisplayName(role),
                    duration = duration_formatted,
                })
            end)
        end)
    end)
    :Register()

Command("revokerole")
    :Aliases("takerole", "rolerevoke")
    :Permission("revokerole")

    :Param("player", { single_target = true })
    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and ctx.caller:CanTargetRole(value)
        end
    })
    :Execute(function(ply, targets, role)
        local target = targets[1]

        lyn.Player.RevokeRole(target, role, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
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

Command("revokeroleid")
    :Aliases("revokeroleid64", "revokerolesteamid", "revokerolesteamid64", "takeroleid", "takeroleid64",
        "takerolesteamid", "takerolesteamid64")
    :Permission("revokeroleid")

    :Param("steamid64")
    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and ctx.caller:CanTargetRole(value)
        end
    })
    :Execute(function(ply, promise, role)
        local steamid64 = promise.steamid64
        promise:Handle(function()
            lyn.Player.RevokeRoleSteamID64(steamid64, role, function(err)
                if err then
                    ply:LynSendFmtText("#commands.failed_to_run")
                    return
                end

                Command.Notify("*", "#commands.revokeroleid.notify", {
                    P = ply,
                    target_steamid64 = steamid64,
                    role = Role.GetDisplayName(role),
                })
            end)
        end)
    end)
    :Register()

Command("newrole")
    :Aliases("createrole", "rolecreate", "rolenew")
    :Permission("manage_roles")

    :Param("string", {
        hint = "role",
        check = function(ctx)
            local value = ctx.value
            return value and not Role.Exists(value)
        end
    })
    :Param("number", {
        hint = "immunity",
    })
    :Param("string", {
        hint = "display_name",
        optional = true,
    })
    :Param("color", {
        optional = true
    })
    :Execute(function(ply, role, immunity, display_name, color)
        lyn.Role.Create(role, immunity, display_name, color, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.newrole.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
            })
        end)
    end)
    :Register()

Command("removerole")
    :Aliases("deleterole", "roledelete", "roleremove")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and not Role.IsDefault(value)
        end
    })
    :Execute(function(ply, role)
        local display_name = Role.GetDisplayName(role)
        lyn.Role.Remove(role, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.removerole.notify", {
                P = ply,
                role = role .. " (" .. display_name .. ")",
            })
        end)
    end)
    :Register()

Command("renamerole")
    :Aliases("rolerename")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and not Role.IsDefault(value)
        end
    })
    :Param("string", {
        hint = "role",
        check = function(ctx)
            local value = ctx.value
            return value and not Role.Exists(value)
        end
    })
    :Execute(function(ply, old_role, new_role)
        local display_name = Role.GetDisplayName(old_role)
        lyn.Role.Rename(old_role, new_role, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.renamerole.notify", {
                P = ply,
                old_role = old_role .. " (" .. display_name .. ")",
                new_role = new_role,
            })
        end)
    end)
    :Register()

Command("setroleimmunity")
    :Aliases("changeroleimmunity")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and value ~= "superadmin"
        end
    })
    :Param("number", {
        hint = "immunity",
        min = Role.MIN_IMMUNITY,
        max = Role.MAX_IMMUNITY
    })
    :Execute(function(ply, role, immunity)
        lyn.Role.ChangeImmunity(role, immunity, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.setroleimmunity.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                immunity = immunity,
            })
        end)
    end)
    :Register()

Command("setroledisplayname")
    :Aliases("changeroledisplayname")
    :Permission("manage_roles")

    :Param("role")
    :Param("string", {
        hint = "display_name",
    })
    :Execute(function(ply, role, display_name)
        local old_display_name = Role.GetDisplayName(role)
        lyn.Role.SetDisplayName(role, display_name, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.setroledisplayname.notify", {
                P = ply,
                role = role .. " (" .. old_display_name .. ")",
                display_name = display_name,
            })
        end)
    end)
    :Register()

Command("setrolecolor")
    :Aliases("changerolecolor")
    :Permission("manage_roles")

    :Param("role")
    :Param("color")
    :Execute(function(ply, role, color)
        lyn.Role.SetColor(role, color, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.setrolecolor.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                color = color:ToHex(),
            })
        end)
    end)
    :Register()

Command("rolegrantpermission")
    :Aliases("grantrolepermission", "roleaddpermission", "roleaddperm", "giverolepermission", "addrolepermission")
    :Permission("manage_roles")

    :Param("role")
    :Param("string", {
        hint = "permission"
    })
    :Execute(function(ply, role, permission)
        lyn.Role.GrantPermission(role, permission, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.rolegrantpermission.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                permission = permission,
            })
        end)
    end)
    :Register()

Command("rolerevokepermission")
    :Aliases("revokerolepermission", "roleremovepermission", "roledeletepermission", "roleremoveperm",
        "takerolepermission")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and value ~= "superadmin"
        end
    })
    :Param("string", {
        hint = "permission"
    })
    :Execute(function(ply, role, permission)
        lyn.Role.RevokePermission(role, permission, function(err)
            if err then
                ply:LynSendFmtText("#commands.failed_to_run")
                return
            end

            Command.Notify("*", "#commands.rolerevokepermission.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                permission = permission,
            })
        end)
    end)
    :Register()
