hook.Add("OpenPermissions:GetUserGroups", "Lyn.GmodAdminSuite", function(ply, usergroups_tbl)
    for _, role in Lyn.Player.Role.Iter(ply) do
        usergroups_tbl[role] = true
    end
end)

hook.Add("OpenPermissions:IsUserGroup", "Lyn.GmodAdminSuite", function(ply, usergroup)
    if Lyn.Player.Role.Has(ply, usergroup) then return true end
end)
