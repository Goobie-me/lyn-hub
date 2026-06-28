local Lyn = Lyn
local Config = Lyn.Config
local Role = Lyn.Role
local Teams = Lyn.Teams
local UI = Lyn.UI

Config.AddTab("Teams", function(sheet)
    local panel = sheet:Add("GPanel")
    panel:Dock(FILL)
    panel:DockPadding(8, 5, 8, 5)
    panel:SetPaintBackground(false)

    local split = panel:Add("GHorizontalDivider")
    split:Dock(FILL)

    local role_selector = UI.Create("GRoleSelector")
    split:AddItem(role_selector, 60)

    local selected_role

    local editor = UI.Create("GPanel")
    editor:DockPadding(8, 5, 8, 5)
    split:AddItem(editor, 120)

    local has_team_check = editor:Add("GLabeledCheckBox")
    has_team_check:Dock(TOP)
    has_team_check:SetText(Lyn.I18n.t("#lyn.teams.has_team"))
    has_team_check:SizeToContents()

    local team_name = editor:Add("GTextEntry")
    team_name:Dock(TOP)
    team_name:DockMargin(0, 3, 0, 0)
    team_name:SetTall(21)
    team_name:SetPlaceholder(Lyn.I18n.t("#lyn.teams.team_name"))
    team_name:SetCheck(function(v) return v ~= "" end)

    local team_color = editor:Add("GColorEntry")
    team_color:Dock(TOP)
    team_color:DockMargin(0, 3, 0, 0)
    team_color:SetTall(21)
    team_color:SetPlaceholder(Lyn.I18n.t("#lyn.teams.team_color"))

    local save = editor:Add("GButton")
    save:Dock(TOP)
    save:DockMargin(0, 3, 0, 0)
    save:SetText("✔")
    save:SetTall(25)
    save:SetBackgroundColor("success")
    save:SetTextColor("success-fg")

    local function load_role(role)
        selected_role = role
        local info = Teams.GetAll()[role.name]
        has_team_check:SetChecked(info ~= nil)
        team_name:SetValue(info and info.name or role.name)
        team_color:SetColor(info and info.color or Role.GetColor(role.name))
    end

    function role_selector:OnRoleSelected(role)
        if not role then return end
        load_role(role)
    end

    function save:Think()
        if not selected_role then
            self:SetDisabled(true)
            return
        end
        local ok = not has_team_check:GetChecked() or team_name.valid
        self:SetDisabled(not ok)
    end

    function save:DoClick()
        if not selected_role then return end
        if has_team_check:GetChecked() then
            Lyn.Command.Execute("setteam", selected_role.name, team_name:GetValue(),
                team_color:GetColor():ToHex())
        else
            Lyn.Command.Execute("removeteam", selected_role.name)
        end
    end

    hook.Add("Lyn.Teams.Updated", panel, function()
        if selected_role then load_role(selected_role) end
    end)

    timer.Simple(0, function()
        if not role_selector:IsValid() then return end
        local first = role_selector.RolesCanvas:GetChildren()[1]
        if first and first.role then
            role_selector:SelectRole(first.role)
        end
    end)

    return panel
end, {
    pos = 50,
    check = function()
        return Lyn.Teams.Enabled() and LocalPlayer():HasPermission("manage_teams")
    end
})
