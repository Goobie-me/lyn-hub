local Lyn = Lyn
local Role = Lyn.Role

local type = type

local function load_roles()
    for name, role in pairs(Role.GetAll()) do
        if not CAMI.GetUsergroup(name) then
            CAMI.RegisterUsergroup({
                Name = name,
                Inherits = role.extends,
                CAMI_Source = "Lyn"
            }, "Lyn")
        end
    end
end

hook.Add("Lyn.Role.Loaded", "Lyn.CAMI.LoadRoles", load_roles)
hook.Add("Lyn.Role.Create", "Lyn.CAMI.RegisterRole", load_roles)

hook.Add("Lyn.Role.Delete", "Lyn.CAMI.UnregisterRole", function(name)
    CAMI.UnregisterUsergroup(name, "Lyn")
end)

hook.Add("Lyn.Role.Rename", "Lyn.CAMI.RenameRole", function(name)
    CAMI.UnregisterUsergroup(name, "Lyn")
    load_roles()
end)

hook.Add("Lyn.Role.ChangeExtends", "Lyn.CAMI.ChangeExtendsRole", function(name)
    CAMI.UnregisterUsergroup(name, "Lyn")
    load_roles()
end)

hook.Add("Lyn.Player.Role.Add", "Lyn.CAMI.RoleAdd", function(ply, _, role)
    if not ply then return end

    local map = Lyn.Player.Role.GetMap(ply)
    local primary = map:GetKeyAtIndex(1) or ""
    if primary ~= role then return end
    local old_primary = map:GetKeyAtIndex(2) or ""

    CAMI.SignalUserGroupChanged(ply, old_primary, primary, "Lyn")
end)

hook.Add("Lyn.Player.Role.Remove", "Lyn.CAMI.RoleRemove", function(ply, _, role)
    if not ply then return end

    local new_primary = Lyn.Player.Role.Get(ply)
    local new_immunity = Role.GetImmunity(new_primary)
    local removed_immunity = Role.GetImmunity(role)
    if removed_immunity <= new_immunity then return end

    CAMI.SignalUserGroupChanged(ply, role, new_primary, "Lyn")
end)

if SERVER then
    local function on_user_group_registered(role, source)
        if source == "Lyn" then return end
        if Role.Exists(role.Name) then return end

        local extends; if Role.Exists(role.Inherits) then
            extends = role.Inherits
        end

        Role.Create(role.Name, 2, nil, nil, extends)
    end
    hook.Add("CAMI.OnUsergroupRegistered", "Lyn.CAMI.OnUsergroupRegistered", on_user_group_registered)

    hook.Add("CAMI.OnUsergroupUnregistered", "Lyn.CAMI.OnUsergroupUnregistered", function(role, source)
        if source == "Lyn" then return end
        if Role.IsDefault(role.Name) then return end
        if not Role.Exists(role.Name) then return end

        Role.Delete(role.Name)
    end)

    for _, role in pairs(CAMI.GetUsergroups()) do
        on_user_group_registered(role, "CAMI")
    end
end

local function on_privilege_registered(privilege)
    Lyn.Permission.Add(privilege.Name, "CAMI", privilege.MinAccess)
end
hook.Add("CAMI.OnPrivilegeRegistered", "Lyn.CAMI.OnPrivilegeRegistered", on_privilege_registered)

hook.Add("CAMI.OnPrivilegeUnregistered", "Lyn.CAMI.OnPrivilegeUnregistered", function(privilege)
    Lyn.Permission.Remove(privilege.Name)
end)

for _, privilege in pairs(CAMI.GetPrivileges()) do
    on_privilege_registered(privilege)
end

hook.Add("CAMI.PlayerHasAccess", "Lyn.CAMI.PlayerHasAccess", function(ply, privilege, callback, target)
    if type(ply) ~= "Player" then return end

    local has_permission = ply:HasPermission(privilege)
    if type(target) == "Player" then
        callback(has_permission and ply:CanTarget(target))
    else
        callback(has_permission)
    end

    return true
end)
