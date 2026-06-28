local Lyn = Lyn
local Hook = Lyn.Hook
local ServerStore = Lyn.ServerStore

local Teams = Lyn.Teams
local STORE_KEY = "teams"

local function load()
    local stored = ServerStore.Get(STORE_KEY, {})
    local rebuilt = {}
    for role_name, info in pairs(stored) do
        rebuilt[role_name] = {
            name = info.name,
            color = Lyn.Util.HexToColor(info.color),
        }
    end
    Lyn.Global.Set("teams", rebuilt)
end

local function save()
    local to_store = {}
    for role_name, info in pairs(Teams.GetAll()) do
        to_store[role_name] = {
            name = info.name,
            color = Lyn.Util.ColorToHex(info.color),
        }
    end
    ServerStore.SetSync(STORE_KEY, to_store)
end

function Teams.Set(role_name, name, color)
    Lyn.ArgCheck.Role(role_name, 1)
    Lyn.ArgCheck.string(name, 2)
    color = Lyn.ArgCheck.Color(color, 3)

    local all = Teams.GetAll()
    all[role_name] = { name = name, color = color }
    Lyn.Global.Set("teams", all)

    save()
    Hook.RunShared("Lyn.Teams.Updated")
end

function Teams.Remove(role_name)
    local all = Teams.GetAll()
    if not all[role_name] then return end

    all[role_name] = nil
    Lyn.Global.Set("teams", all)

    save()
    Hook.RunShared("Lyn.Teams.Updated")
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
    Lyn.Global.Set("teams", all)

    save()
    Hook.RunShared("Lyn.Teams.Updated")
end)

load()
