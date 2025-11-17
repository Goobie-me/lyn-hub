local Lyn = Lyn
local Config = Lyn.Config

if CLIENT then
    Config.RegisterGeneral("Restrict command notifications to roles\nAdds 'command_notify' permission", function()
        local entry = Lyn.UI.Create("GToggleButton")
        entry:SetConfig("restrict_command_notifications", false)
        return entry
    end)
end

Config.Hook({ { "restrict_command_notifications", false } }, "restrict_command_notifications",
    function(restrict_command_notifications)
        if restrict_command_notifications then
            Lyn.Permission.Add("command_notify", nil, "admin")
            hook.Add("Lyn.Command.Notify", "Lyn.Config.RestrictCommandNotifications", function(_, target, msg, tbl)
                if target == "*" then
                    local new_target = Lyn.Player.GetAllWithPermission("command_notify")
                    Lyn.Player.Chat.Send(new_target, msg, tbl)
                    return true
                end
            end)
        else
            Lyn.Permission.Remove("command_notify")
            hook.Remove("Lyn.Command.Notify", "Lyn.Config.RestrictCommandNotifications")
        end
    end)
