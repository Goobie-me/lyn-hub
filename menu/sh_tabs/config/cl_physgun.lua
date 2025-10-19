local Lyn = Lyn

local items = {
    {
        title = "Right click to freeze",
        func = function()
            local toggle = Lyn.UI.Create("GToggleButton")
            toggle:SetConfig("physgun_right_click_to_freeze", false)
            return toggle
        end
    },
    {
        title = "No fall damage on drop",
        func = function()
            local toggle = Lyn.UI.Create("GToggleButton")
            toggle:SetConfig("physgun_nofalldamage", false)
            return toggle
        end
    },
    {
        title = "Reset Velocity to fix some issues when players fall",
        func = function()
            local toggle = Lyn.UI.Create("GToggleButton")
            toggle:SetConfig("physgun_reset_velocity", false)
            return toggle
        end
    },
}

Lyn.Config.AddSimpleTab("Physgun", function() return items end, {
    pos = 4,
    check = function()
        return LocalPlayer():HasPermission("menu.manage_config")
    end
})
