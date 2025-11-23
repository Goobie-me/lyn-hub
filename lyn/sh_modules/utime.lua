local Lyn = Lyn

---@class Player
local PLAYER = FindMetaTable("Player")

function PLAYER:GetUTime()
    return Lyn.Player.GetSharedVar(self, "TotalUTime", 0)
end

function PLAYER:SetUTime(time)
    Lyn.Player.SetSharedVar(self, "TotalUTime", time)
end

function PLAYER:GetUTimeStart()
    return Lyn.Player.GetSharedVar(self, "UTimeStart", 0)
end

function PLAYER:SetUTimeStart(time)
    Lyn.Player.SetSharedVar(self, "UTimeStart", time)
end

function PLAYER:GetUTimeSessionTime()
    return CurTime() - self:GetUTimeStart()
end

function PLAYER:GetUTimeTotalTime()
    return self:GetUTime() + CurTime() - self:GetUTimeStart()
end

if SERVER then
    hook.Add("Lyn.Player.RetrieveDataTransaction", "Lyn.UTime", function(ply)
        ply:SetUTime(Lyn.Player.GetPlayTime(ply))
        ply:SetUTimeStart(CurTime())
    end)
end
