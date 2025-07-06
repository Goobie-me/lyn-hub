local lyn = lyn
local Command = lyn.Command

Command("#hp")
    :Permission("hp", "admin")
    :Help("Set the health of a player")

    :Param("player")
    :Param("number", { hint = "amount", default = 100, min = 1, max = 2147483647, round = true })

    :Execute(function(ply, targets, amount)
        for i = 1, #targets do
            targets[i]:SetHealth(amount)
        end

        Command.Notify("*", "#commands.hp.notify", {
            P = ply,
            T = targets,
            amount = amount,
        })
    end)
    :Register()
