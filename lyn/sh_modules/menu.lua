local Lyn = Lyn
local Command = Lyn.Command
local Net = Lyn.GoobieCore.Net

Command.SetCategory("Other")

Command("menu")
    :DenyConsole()
    :NoConsoleLog()
    :NoMenu()
    :Execute(function(ply)
        Net.StartSV("Menu.Open", ply)
    end)
    :Add()

if CLIENT then
    Net.HookCL("Menu.Open", function()
        Lyn.Menu.Open()
    end)
end
