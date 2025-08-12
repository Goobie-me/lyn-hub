---@class Player
local PLAYER = FindMetaTable("Player")

function PLAYER:GetUTime()
    return self:LynGetSharedVar("TotalUTime", 0)
end

function PLAYER:SetUTime(time)
    self:LynSetSharedVar("TotalUTime", time)
end

function PLAYER:GetUTimeStart()
    return self:LynGetSharedVar("UTimeStart", 0)
end

function PLAYER:SetUTimeStart(time)
    self:LynSetSharedVar("UTimeStart", time)
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
