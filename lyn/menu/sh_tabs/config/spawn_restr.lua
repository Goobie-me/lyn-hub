-- TODO: Change AdminOnly hack shit to proper hooks once this PR gets merged https://github.com/Facepunch/garrysmod/pull/2419

local Lyn = Lyn
local Config = Lyn.Config

local pairs = pairs

local HOOK_NAME = "Lyn.Config.SpawnRestrictions."

local function no_permission(ply, name)
    Lyn.Player.PlaySound(ply, "buttons/button10.wav")
    Lyn.Player.Chat.Send(ply, "#lyn.extra.no_spawn_permission", {
        name = name
    })
end

local function get_spawn_hooks()
    return {
        PlayerSpawnProp = {
            name = "spawn_props",
            default_role = "user",
            call_gm = true,
        },
        PlayerGiveSWEP = {
            name = "give_weapons",
            callback = function(_, ply, _, wep)
                if wep.Lyn_AdminOnly and not ply:HasPermission("give_admin_weapons") then
                    no_permission(ply, "give_admin_weapons")
                    return false
                end
                return true
            end,
            hook_type = HOOK_HIGH,
        },
        PlayerSpawnSWEP = {
            name = "spawn_weapons",
            callback = function(_, ply, _, wep)
                if wep.Lyn_AdminOnly and not ply:HasPermission("give_admin_weapons") then
                    no_permission(ply, "give_admin_weapons")
                    return false
                end
                return true
            end,
            hook_type = HOOK_HIGH,
        },
        -- PlayerSpawnSENT = {
        -- 	name = "entities",
        -- 	check_limit = "sents"
        -- },
        PlayerSpawnNPC = {
            name = "spawn_npcs",
            check_limit = "npcs",
        },
        PlayerSpawnVehicle = {
            name = "spawn_vehicles",
            check_limit = "vehicles",
        },
        PlayerSpawnRagdoll = {
            name = "spawn_ragdolls",
            permission = "user",
            check_limit = "ragdolls",
        }
    }
end

local function get_override_list()
    return {
        "Weapon",
        -- "SpawnableEntities"
    }
end

local function LimitReachedProcess(ply, str)
    if not IsValid(ply) then return true end
    return ply:CheckLimit(str)
end

if CLIENT then
    Config.RegisterGeneral(
        "Spawn restrictions\nAdds spawn permissions under 'Spawning' category", function()
            local entry = Lyn.UI.Create("GToggleButton")
            entry:SetConfig("spawn_restrictions", false)
            return entry
        end)
end

Config.Hook({ { "spawn_restrictions", false } }, "spawn_restrictions", function(spawn_restrictions)
    if spawn_restrictions then
        Lyn.Permission.Add("give_admin_weapons", "Spawning", "superadmin")
    else
        Lyn.Permission.Remove("give_admin_weapons")
    end

    for hook_name, data in pairs(get_spawn_hooks()) do
        local permission_name = data.name
        local default_role = data.default_role or "superadmin"
        local call_gm = data.call_gm
        local callback = data.callback
        local check_limit = data.check_limit
        local hook_type = data.hook_type or HOOK_LOW

        if spawn_restrictions then
            Lyn.Permission.Add(permission_name, "Spawning", default_role)
        else
            Lyn.Permission.Remove(permission_name)
        end

        if SERVER then
            if spawn_restrictions then
                hook.Add(hook_name, HOOK_NAME .. hook_name, function(ply, ...)
                    if not ply:HasPermission(permission_name) then
                        no_permission(ply, permission_name)
                        return false
                    end

                    if check_limit then
                        return LimitReachedProcess(ply, check_limit)
                    end

                    if call_gm then
                        return GAMEMODE[hook_name](GAMEMODE, ply, ...)
                    elseif callback then
                        return callback(GAMEMODE, ply, ...)
                    end

                    return true
                end, hook_type)
            else
                hook.Remove(hook_name, HOOK_NAME .. data.name)
            end
        end

        timer.Simple(5, function()
            for _, override_name in pairs(get_override_list()) do
                for _, item in pairs(list.GetForEdit(override_name)) do
                    if spawn_restrictions then
                        item.Lyn_AdminOnly = item.Lyn_AdminOnly or item.AdminOnly
                        item.AdminOnly = false
                    else
                        if item.Lyn_AdminOnly then
                            item.AdminOnly = item.Lyn_AdminOnly
                        end
                    end
                end
            end
        end)
    end
end)
