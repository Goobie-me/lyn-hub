local lyn = lyn
local Command = lyn.Command
local TimeUtils = lyn.goobie_utils.TimeUtils

local ipairs = ipairs

Command.SetCategory("Fun")

Command("hp")
    :Aliases("health", "sethealth", "sethp", "hpset", "healthset")
    :Permission("hp", "admin")

    :Param("player", { default = "^" })
    :Param("number", { hint = "amount", default = 100, min = 1, max = 2147483647, round = true })
    :Execute(function(ply, targets, amount)
        for _, target in ipairs(targets) do
            target:SetHealth(amount)
        end

        Command.Notify("*", "#commands.hp.notify", {
            P = ply,
            T = targets,
            amount = amount,
        })
    end)
    :Register()

Command("armor")
    :Aliases("setarmor", "armorset")
    :Permission("armor", "admin")

    :Param("player", { default = "^" })
    :Param("number", { hint = "amount", default = 100, min = 0, max = 2147483647, round = true })
    :Execute(function(ply, targets, amount)
        for _, target in ipairs(targets) do
            target:SetArmor(amount)
        end

        Command.Notify("*", "#commands.armor.notify", {
            P = ply,
            T = targets,
            amount = amount,
        })
    end)
    :Register()

Command("slay")
    :Aliases("kill", "slayplayer", "killplayer")
    :Permission("slay", "admin")

    :Param("player")
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            if not lyn.Player.GetExclusive(ply, target) then
                target:Kill()
            end
        end

        Command.Notify("*", "#commands.slay.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("ignite")
    :Aliases("burn", "setonfire")
    :Permission("ignite", "admin")

    :Param("player")
    :Param("duration", { hint = "duration", default = 30, min = 1, max = "1h" })
    :Execute(function(ply, targets, duration)
        for _, target in ipairs(targets) do
            if target:IsOnFire() then
                target:Extinguish()
            end

            target:Ignite(duration)
        end

        Command.Notify("*", "#commands.ignite.notify", {
            P = ply,
            T = targets,
            duration = TimeUtils.FormatDuration(duration),
        })
    end)
    :Register()

Command("unignite")
    :Aliases("extinguish")
    :Permission("ignite", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:Extinguish()
        end

        Command.Notify("*", "#commands.unignite.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("god")
    :Aliases("invincible")
    :Permission("god", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:GodEnable()
            target:LynSetVar("god", true)
        end

        Command.Notify("*", "#commands.god.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("ungod")
    :Aliases("uninvincible")
    :Permission("god", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:GodDisable()
            target:LynSetVar("god", false)
        end

        Command.Notify("*", "#commands.ungod.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

do
    Command("freeze")
        :Permission("freeze", "admin")

        :Param("player")
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                target:ExitVehicle()
                if target:LynGetSharedVar("frozen") then
                    target:UnLock()
                end
                target:Lock()
                target:LynSetSharedVar("frozen", true)
                lyn.Player.SetExclusive(target, "freeze")
            end

            Command.Notify("*", "#commands.freeze.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Register()

    Command("unfreeze")
        :Permission("freeze", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                target:UnLock()
                target:LynSetSharedVar("frozen", nil)
                lyn.Player.SetExclusive(target, nil)
            end

            Command.Notify("*", "#commands.unfreeze.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Register()

    local function disallow(ply)
        if ply:LynGetSharedVar("frozen") then
            return false
        end
    end

    for _, v in ipairs({ "Lyn.Player.CanSpawn", "CanPlayerSuicide", "CanTool" }) do
        hook.Add(v, "Lyn.FreezePlayer." .. v, disallow)
    end
end

Command("cloak")
    :Permission("cloak", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            lyn.Player.Cloak(target, true)
        end

        Command.Notify("*", "#commands.cloak.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("uncloak")
    :Permission("cloak", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            lyn.Player.Cloak(target, false)
        end

        Command.Notify("*", "#commands.uncloak.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("strip")
    :Permission("strip", "admin")

    :Param("player")
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:StripWeapons()
        end

        Command.Notify("*", "#commands.strip.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()

Command("respawn")
    :Permission("respawn", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:Spawn()
        end

        Command.Notify("*", "#commands.respawn.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Register()
