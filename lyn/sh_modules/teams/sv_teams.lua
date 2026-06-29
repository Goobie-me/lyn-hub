local Lyn = Lyn
local Teams = Lyn.Teams
local Config = Lyn.Config

function Teams.Set(role_name, name, color)
    Lyn.ArgCheck.Role(role_name, 1)
    Lyn.ArgCheck.string(name, 2)
    color = Lyn.ArgCheck.Color(color, 3)

    local all = Teams.GetAll()
    all[role_name] = { name = name, color = color }

    Config.Set("teams", all)
end

function Teams.Remove(role_name)
    local all = Teams.GetAll()
    if not all[role_name] then return end

    all[role_name] = nil
    Config.Set("teams", all)
end

hook.Add("Lyn.Role.Delete", "Lyn.Teams.RoleDeleted", function(name)
    Teams.Remove(name)
end)

hook.Add("Lyn.Role.Rename", "Lyn.Teams.RoleRenamed", function(old_name, new_name)
    local all = Teams.GetAll()
    local info = all[old_name]
    if not info then return end

    all[old_name] = nil
    all[new_name] = info
    Config.Set("teams", all)
end)
