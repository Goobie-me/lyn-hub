local MODULE    = GAS.Logging:MODULE()

MODULE.Category = "Lyn"
MODULE.Name     = "Commands"
MODULE.Colour   = Color(255, 90, 0)

local blacklist = {
    ["menu"] = true
}

MODULE:Setup(function()
    MODULE:Hook("Lyn.Player.Command.Execute", "Blogs.Lyn", function(ply, cmd_name, ctx)
        if blacklist[cmd_name] then return end

        local args = {}
        for _, v in ipairs(ctx.parsed_args) do
            table.insert(args, tostring(v.value))
        end

        MODULE:LogPhrase("command_used", GAS.Logging:FormatPlayer(Lyn.IsConsole(ply) and "Console" or ply),
            GAS.Logging:Highlight(ctx.matched_prefix .. " \"" .. table.concat(args, "\" \"") .. "\""))
    end)
end)

GAS.Logging:AddModule(MODULE)
