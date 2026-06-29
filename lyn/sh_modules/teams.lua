local Lyn = Lyn

local load = not GAMEMODE and hook.Add or function(_, _, fn)
    fn()
end

load("PostGamemodeLoaded", "Lyn.Teams", function()
    Lyn.RunFile("teams/sh_core.lua")
    Lyn.RunFile("teams/sv_teams.lua")
    Lyn.RunFile("teams/cl_config.lua")
end)
