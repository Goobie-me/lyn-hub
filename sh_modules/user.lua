local Lyn = Lyn
local Command = Lyn.Command
local TimeUtils = Lyn.GoobieCore.TimeUtils
local Role = Lyn.Role

Command.SetCategory("User Management")

Command("playeraddrole")
    :Aliases("giverole", "rolegive", "adduser", "giverank")
    :Permission("playeraddrole")

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
        Lyn.Player.Role.Add(target, role, duration, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.playeraddrole.notify", {
                P = ply,
                T = targets,
                role = Role.GetDisplayName(role),
                duration = duration_formatted,
            })
        end)
    end)
    :Add()

Command("playeraddroleid")
    :Aliases("giveroleid", "roleidgive", "adduserid", "giverankid")
    :Permission("playeraddroleid")

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
            Lyn.Player.Role.AddSteamID64(steamid64, role, duration, function(err)
                if err then
                    Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                    return
                end

                LYN_NOTIFY("*", "#lyn.commands.playeraddroleid.notify", {
                    P = ply,
                    target_steamid64 = steamid64,
                    role = Role.GetDisplayName(role),
                    duration = duration_formatted,
                })
            end)
        end)
    end)
    :Add()

Command("playerremoverole")
    :Aliases("takerole", "takeplayerrole")
    :Permission("playerremoverole")

    :Param("player", { single_target = true })
    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and ctx.caller:CanTargetRole(value)
        end
    })
    :Execute(function(ply, targets, role)
        local target = targets[1]

        Lyn.Player.Role.Remove(target, role, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.playerremoverole.notify", {
                P = ply,
                T = targets,
                role = Role.GetDisplayName(role),
            })
        end)
    end)
    :Add()

Command("playerremoveroleid")
    :Aliases("takeroleid", "playertakeroleid")
    :Permission("playerremoveroleid")

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
            Lyn.Player.Role.RemoveSteamID64(steamid64, role, function(err)
                if err then
                    Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                    return
                end

                LYN_NOTIFY("*", "#lyn.commands.playerremoveroleid.notify", {
                    P = ply,
                    target_steamid64 = steamid64,
                    role = Role.GetDisplayName(role),
                })
            end)
        end)
    end)
    :Add()

Command("createrole")
    :Aliases("newrole", "rolecreate", "rolenew")
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
    :Param("role", {
        hint = "extends",
        optional = true,
    })
    :Execute(function(ply, role, immunity, display_name, color, extends)
        Lyn.Role.Create(role, immunity, display_name, color, extends, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.createrole.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
            })
        end)
    end)
    :Add()

Command("deleterole")
    :Aliases("removerole", "roledelete", "roleremove")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            local value = ctx.value
            return value and not Role.IsDefault(value)
        end
    })
    :Execute(function(ply, role)
        local display_name = Role.GetDisplayName(role)
        Lyn.Role.Delete(role, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.deleterole.notify", {
                P = ply,
                role = role .. " (" .. display_name .. ")",
            })
        end)
    end)
    :Add()

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
        Lyn.Role.Rename(old_role, new_role, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.renamerole.notify", {
                P = ply,
                old_role = old_role .. " (" .. display_name .. ")",
                new_role = new_role,
            })
        end)
    end)
    :Add()

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
        Lyn.Role.SetImmunity(role, immunity, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.setroleimmunity.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                immunity = immunity,
            })
        end)
    end)
    :Add()

Command("setroledisplayname")
    :Aliases("changeroledisplayname")
    :Permission("manage_roles")

    :Param("role")
    :Param("string", {
        hint = "display_name",
    })
    :Execute(function(ply, role, display_name)
        local old_display_name = Role.GetDisplayName(role)
        Lyn.Role.ChangeDisplayName(role, display_name, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.setroledisplayname.notify", {
                P = ply,
                role = role .. " (" .. old_display_name .. ")",
                display_name = display_name,
            })
        end)
    end)
    :Add()

Command("setrolecolor")
    :Aliases("changerolecolor")
    :Permission("manage_roles")

    :Param("role")
    :Param("color")
    :Execute(function(ply, role, color)
        Lyn.Role.SetColor(role, color, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.setrolecolor.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                color = color:ToHex(),
            })
        end)
    end)
    :Add()

Command("setroleextends")
    :Aliases("changeroleextends")
    :Permission("manage_roles")

    :Param("role", {
        check = function(ctx)
            return ctx.value ~= "superadmin"
        end
    })
    :Param("role", {
        hint = "extends",
        optional = true,
        check = function(ctx)
            local value = ctx.value
            local this_role = ctx.results[1]
            return value and this_role and Role.CanExtend(this_role, value)
        end
    })
    :Execute(function(ply, role, extends)
        Lyn.Role.ChangeExtends(role, extends, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            if extends then
                LYN_NOTIFY("*", "#lyn.commands.setroleextends.notify_set", {
                    P = ply,
                    role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                    extends = extends .. " (" .. Role.GetDisplayName(extends) .. ")",
                })
            else
                LYN_NOTIFY("*", "#lyn.commands.setroleextends.notify_removed", {
                    P = ply,
                    role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                })
            end
        end)
    end)
    :Add()

Command("roleaddpermission")
    :Permission("manage_roles")

    :Param("role")
    :Param("string", {
        hint = "permission"
    })
    :Execute(function(ply, role, permission)
        Lyn.Role.AddPermission(role, permission, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.roleaddpermission.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                permission = permission,
            })
        end)
    end)
    :Add()

Command("roleremovepermission")
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
        Lyn.Role.RemovePermission(role, permission, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.roleremovepermission.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                permission = permission,
            })
        end)
    end)
    :Add()

Command("roledeletepermission")
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
        Lyn.Role.DeletePermission(role, permission, function(err)
            if err then
                Lyn.Player.Chat.Send(ply, "#lyn.commands_core.failed_to_run")
                return
            end

            LYN_NOTIFY("*", "#lyn.commands.roledeletepermission.notify", {
                P = ply,
                role = role .. " (" .. Role.GetDisplayName(role) .. ")",
                permission = permission,
            })
        end)
    end)
    :Add()
