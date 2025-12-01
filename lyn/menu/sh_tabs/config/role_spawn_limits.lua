local Lyn = Lyn
local Config = Lyn.Config
local UI = Lyn.UI
local Role = Lyn.Role
local Net = Lyn.GoobieCore.Net

local HOOK_NAME = "Lyn.Config.RoleSpawnLimits"

function Config.GetRoleSpawnLimits()
    return Config.Get("role_spawn_limits") or {}
end

local function get_role_limit(role, limit_type)
    local limits = Config.GetRoleSpawnLimits()
    while role do
        if role == "superadmin" then return -1 end

        local role_spawn_limits = limits[role]
        if role_spawn_limits then
            local limit = role_spawn_limits[limit_type]
            if limit ~= nil then
                return limit
            end
        end

        local role_data = Role.Get(role)
        if not role_data then break end

        role = role_data.extends
    end

    return cvars.Number("sbox_max" .. limit_type, 0)
end
Config.GetRoleSpawnLimit = get_role_limit

if SERVER then
    function Config.SetRoleSpawnLimit(role, limit_type, limit)
        if role == "superadmin" then return end -- fuck off
        local limits = Config.GetRoleSpawnLimits()
        limits[role] = limits[role] or {}
        limits[role][limit_type] = limit
        Config.Set("role_spawn_limits", limits)
        limit = get_role_limit(role, limit_type)
        Lyn.Hook.RunShared("Lyn.Config.RoleSpawnLimits.SetLimit", role, limit_type, limit)
    end

    Net.HookSV("Lyn.Config.RoleSpawnLimits.SetLimit", function(_, role, limit_type, limit)
        Config.SetRoleSpawnLimit(role, limit_type, limit)
    end, function(ply)
        return ply:HasPermission("menu_manage_config")
    end)
else
    function Config.SetRoleSpawnLimit(role, limit_type, limit)
        Net.StartCL("Lyn.Config.RoleSpawnLimits.SetLimit", role, limit_type, limit)
    end
end

local function get_player_limit(ply, limit_type)
    local best = 0
    for _, role_name in Lyn.Player.Role.Iter(ply) do
        local limit = get_role_limit(role_name, limit_type)
        if limit == -1 then
            return -1
        end
        if limit > best then
            best = limit
        end
    end
    return best
end
Config.GetPlayerSpawnLimit = get_player_limit

if CLIENT then
    Config.AddTab("Role Spawn Limits", function(sheet)
        local panel = sheet:Add("GPanel")
        panel:Dock(FILL)
        panel:DockPadding(8, 5, 8, 5)

        local enabled_panel = panel:Add("GLabelPanel")
        enabled_panel:DockMargin(0, 0, 0, 5)
        enabled_panel:SetLabel("Enabled")

        local enabled = UI.Create("GToggleButton")
        enabled:SetConfig("role_spawn_limits_enabled", false)
        enabled_panel:SetPanel(enabled)

        Lyn.Menu.Line(panel):DockMargin(0, 0, 0, 5)

        local split = panel:Add("GHorizontalDivider")
        split:Dock(FILL)

        local role_selector = UI.Create("GRoleSelector")
        split:AddItem(role_selector, 60)

        local right_panel = UI.Create("GPanel")
        split:AddItem(right_panel, 120)

        local help = right_panel:Add("GLabel")
        help:Dock(TOP)
        help:DockMargin(0, 0, 0, 5)
        help:SetWrap(true)
        help:SetAutoStretchVertical(true)
        help:SetText(
            "Unlimited = -1 | None = 0\nIf limit was left blank for the role, it will inherit from its parent role or the default sandbox limit (if no parent role)"
        )

        Lyn.Menu.Line(right_panel)

        local limits_panel = right_panel:Add("GScrollPanel")
        limits_panel:SetPaintBackground(false)
        limits_panel:Dock(FILL)
        limits_panel:DockMargin(5, 5, 5, 0)

        local limit_types = {}
        for _, limit_type in SortedPairs(cleanup.GetTable(), true) do
            local cvar = GetConVar("sbox_max" .. limit_type)
            if cvar then
                table.insert(limit_types, limit_type)
            end
        end

        local function entry_OnEnter(self, value)
            value = tonumber(value)
            local selected = role_selector:GetSelectedRole()
            if not selected then return end
            Config.SetRoleSpawnLimit(selected.name, self.limit_type, value)
        end

        local entries
        local function load_limits()
            entries = {}
            limits_panel:Clear()

            local role = role_selector:GetSelectedRole()
            if not role then return end

            for i, limit_type in ipairs(limit_types) do
                local limit_panel = limits_panel:Add("GLabelPanel")
                limit_panel:DockMargin(0, 0, 0, 4)
                limit_panel:SetLabel(limit_type)

                local entry = UI.Create("GTextEntry")
                entry:SetNumeric(true)
                entry:DisallowFloats(true)
                entry:SetWidth(45)
                entry:SetEnterMode(true)
                entry.limit_type = limit_type

                entry:On("OnEnter", entry_OnEnter)

                limit_panel:SetPanel(entry)

                entries[i] = entry
            end
        end

        function role_selector:OnRoleSelected(role)
            if not entries then
                load_limits()
            end

            if not role then
                entries = nil
                limits_panel:Clear()
                return
            end

            for _, entry in ipairs(entries) do
                entry:SetValue(get_role_limit(role.name, entry.limit_type))
                entry:SetDisabled(role.name == "superadmin")
            end
        end

        hook.Add("Lyn.Config.RoleSpawnLimits.SetLimit", limits_panel, function(_, role, limit_type, limit)
            local selected = role_selector:GetSelectedRole()
            if not selected then return end
            if selected.name ~= role then return end

            for _, entry in ipairs(entries) do
                if entry.limit_type == limit_type then
                    entry:SetValue(limit)
                    break
                end
            end
        end)

        return panel
    end, {
        check = function() return LocalPlayer():HasPermission("menu_manage_config") end
    })
end

Config.Hook({ { "role_spawn_limits_enabled", false } }, "role_spawn_limits_enabled", function(role_spawn_limits_enabled)
    if role_spawn_limits_enabled then
        Lyn.Hook.PreReturn("PlayerCheckLimit", HOOK_NAME, function(ply, limit_type, count)
            local limit = get_player_limit(ply, limit_type)
            if limit < 0 then return true end
            if count > limit - 1 then
                return false
            end
            return true
        end)
    else
        hook.Remove("PlayerCheckLimit", HOOK_NAME)
    end
end)
