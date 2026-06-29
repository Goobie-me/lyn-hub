local Lyn = Lyn
local Hook = Lyn.Hook
local Config = Lyn.Config

Lyn.Permission.Add("manage_teams", "Teams")

local Teams = {}
Lyn.Teams = Teams

--- like ULX, stay clear of gamemode-reserved teams
local STARTING_INDEX = 21
--- like ULX, an index outside the team-bearing range
local UNASSIGNED = 1001

-- role_name -> index (rebuilt each load, never stored)
Teams.Indices = Teams.Indices or {}

function Teams.Enabled()
    local gm = GAMEMODE or GM
    if not gm then return false end
    return gm.IsSandboxDerived and gm.Name ~= "DarkRP"
end

-- stored mapping: role_name -> { name = "...", color = Color }
function Teams.GetAll()
    return Config.Get("teams", {})
end

function Teams.GetIndex(role_name)
    return Teams.Indices[role_name]
end

-- (re)register every team with gmod, ordered by role immunity (highest first)
local function setup_teams()
    if not Teams.Enabled() then return end

    Teams.Indices = {}

    local stored = Teams.GetAll()
    local roles = Lyn.Role.GetAll()

    local ordered = {}
    for role_name in pairs(stored) do
        if roles[role_name] then -- skip teams whose role no longer exists
            ordered[#ordered + 1] = role_name
        end
    end
    Lyn.Role.SortyByImmunity(ordered)

    local index = STARTING_INDEX
    for _, role_name in ipairs(ordered) do
        local info = stored[role_name]
        team.SetUp(index, info.name, info.color, false)
        Teams.Indices[role_name] = index
        index = index + 1
    end

    Hook.ProtectedCall("Lyn.Teams.Setup")
end

-- gives a player the team of their highest-immunity role that has one
function Teams.Assign(ply)
    if CLIENT then return end
    if not Teams.Enabled() then return end
    if not IsValid(ply) then return end

    for _, role_name in Lyn.Player.Role.Iter(ply) do -- already immunity-sorted
        local index = Teams.Indices[role_name]
        if index then
            if ply:Team() ~= index then
                ply:SetTeam(index)
            end
            return
        end
    end

    -- no team-bearing role: reset if we previously moved them
    if ply:Team() >= STARTING_INDEX then
        ply:SetTeam(UNASSIGNED)
    end
end

local function reassign_all()
    for _, ply in player.Iterator() do
        Teams.Assign(ply)
    end
end

Config.Hook({ "teams" }, "Lyn.Teams.Setup", function()
    setup_teams()
    if SERVER then reassign_all() end
end)

Hook.Monitor("Lyn.Role.ChangeImmunity", "Lyn.Teams.Rebuild", function()
    setup_teams()
    if SERVER then reassign_all() end
end)

if SERVER then
    Hook.Monitor("Lyn.Player.Auth", "Lyn.Teams.Assign", Teams.Assign)
    Hook.Monitor("Lyn.Player.Role.Add", "Lyn.Teams.Assign", Teams.Assign)
    Hook.Monitor("Lyn.Player.Role.Remove", "Lyn.Teams.Assign", Teams.Assign)
end

local Command = Lyn.Command
Command.SetCategory("Teams")

Command("setteam")
    :Permission("manage_teams", "superadmin")
    :Param("role")
    :Param("string", { hint = "team_name" })
    :Param("color", { optional = true, default = "FFFFFF" })
    :Execute(function(ply, role_name, name, color)
        Lyn.Teams.Set(role_name, name, color)
        LYN_NOTIFY("*", "#lyn.commands.setteam.notify", {
            P = ply,
            role = role_name,
            name = name,
        })
    end)
    :Add()

Command("removeteam")
    :Permission("manage_teams", "superadmin")
    :Param("role")
    :Execute(function(ply, role_name)
        Lyn.Teams.Remove(role_name)
        LYN_NOTIFY("*", "#lyn.commands.removeteam.notify", {
            P = ply,
            role = role_name,
        })
    end)
    :Add()
