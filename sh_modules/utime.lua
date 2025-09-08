local lyn = lyn

---@class Player
local PLAYER = FindMetaTable("Player")

function PLAYER:GetUTime()
    return lyn.Player.GetSharedVar(self, "TotalUTime", 0)
end

function PLAYER:SetUTime(time)
    lyn.Player.SetSharedVar(self, "TotalUTime", time)
end

function PLAYER:GetUTimeStart()
    return lyn.Player.GetSharedVar(self, "UTimeStart", 0)
end

function PLAYER:SetUTimeStart(time)
    lyn.Player.SetSharedVar(self, "UTimeStart", time)
end

function PLAYER:GetUTimeSessionTime()
    return CurTime() - self:GetUTimeStart()
end

function PLAYER:GetUTimeTotalTime()
    return self:GetUTime() + CurTime() - self:GetUTimeStart()
end

if SERVER then
    hook.Add("Lyn.Player.RetrieveDataTransaction", "Lyn.UTime", function(ply)
        ply:SetUTime(ply:LynGetPlayTime())
        ply:SetUTimeStart(CurTime())
    end)
end
