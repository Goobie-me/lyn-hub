local Lyn = Lyn
local Config = Lyn.Config
local Hook = Lyn.Hook

local pairs = pairs
local istable = istable

local HOOK_NAME = "Lyn.Config.ToolRestrictions"

local function tool_name(tool)
    return "tool_" .. tool
end

if CLIENT then
    Config.RegisterGeneral(
        "Tool restrictions\nAdds 'tool_*' permissions\nWorks only when gamemode is derived from sandbox", function()
            local entry = Lyn.UI.Create("GToggleButton")
            entry:SetConfig("tool_restrictions", false)
            return entry
        end)
end

Config.Hook({ { "tool_restrictions", false } }, "tool_restrictions", function(tool_restrictions)
    local tools = weapons.GetStored("gmod_tool")

    if tool_restrictions and istable(tools) then
        for _, v in pairs(tools.Tool) do
            local tname = tool_name(v.Mode)
            if not Lyn.Permission.Exists(tname) then
                Lyn.Permission.Add(tname, "Tools - " .. (v.Category or "Other"), "user")
            end
        end

        hook.Add("CanTool", HOOK_NAME, function(ply, _, tool)
            if Lyn.Player.HasPermission(ply, tool_name(tool)) then return end

            if CLIENT and not Lyn.Player.HasCooldown(ply, HOOK_NAME, 0.1) then
                Lyn.Player.Chat.Send(ply, "#lyn.extra.no_tool_permission", { tool = tool })
            end

            return false
        end)
    else
        if istable(tools) then
            for _, v in pairs(tools.Tool) do
                Lyn.Permission.Remove(tool_name(v.Mode))
            end
        end

        hook.Remove("CanTool", HOOK_NAME)
    end
end)

Hook.Monitor("PreRegisterTOOL", HOOK_NAME, function()
    -- Gotta delay because this is a pre-hook
    timer.Simple(0, function()
        Config.Trigger("tool_restrictions")
    end)
end)
