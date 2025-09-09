local Lyn = Lyn
local Command = Lyn.Command
local TimeUtils = Lyn.goobie_utils.TimeUtils

local ipairs = ipairs
local type = type

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
    :Add()

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
    :Add()

Command("give")
    :Permission("give")

    :Param("player", { default = "^" })
    :Param("string", { hint = "weapon/entity" })
    :Execute(function(ply, targets, class)
        for _, target in ipairs(targets) do
            target:Give(class)
        end

        Command.Notify("*", "#commands.give.notify", {
            P = ply,
            T = targets,
            class = class,
        })
    end)
    :Add()

do
    local sounds = {}
    for i = 1, 6 do
        sounds[i] = "physics/body/body_medium_impact_hard" .. i .. ".wav"
    end

    local function slap(ply, damage, admin)
        if not ply:Alive() or Lyn.Player.GetSharedVar(ply, "frozen") then return end
        ply:ExitVehicle()

        ply:SetVelocity(Vector(math.random(-100, 100), math.random(-100, 100), math.random(200, 400)))
        ply:EmitSound(sounds[math.random(1, 6)], 60, math.random(80, 120))

        if damage > 0 then
            ply:TakeDamage(damage, admin, DMG_GENERIC)
        end
    end

    Command("slap")
        :Permission("slap", "admin")

        :Param("player")
        :Param("number", { hint = "damage", round = true, min = 0, default = 0 })
        :Execute(function(ply, targets, damage)
            for _, target in ipairs(targets) do
                slap(target, damage, ply)
            end

            if damage > 0 then
                Command.Notify("*", "#commands.slap.notify_damage", {
                    P = ply,
                    T = targets,
                    damage = damage,
                })
            else
                Command.Notify("*", "#commands.slap.notify", {
                    P = ply,
                    T = targets,
                })
            end
        end)
        :Add()
end

Command("slay")
    :Aliases("kill", "slayplayer", "killplayer")
    :Permission("slay", "admin")

    :Param("player")
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            if not Lyn.Player.GetExclusive(ply, target) then
                target:Kill()
            end
        end

        Command.Notify("*", "#commands.slay.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

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
    :Add()

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
    :Add()

Command("god")
    :Aliases("invincible")
    :Permission("god", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:GodEnable()
            Lyn.Player.SetVar(target, "god", true)
        end

        Command.Notify("*", "#commands.god.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

Command("ungod")
    :Aliases("uninvincible")
    :Permission("god", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:GodDisable()
            Lyn.Player.SetVar(target, "god", false)
        end

        Command.Notify("*", "#commands.ungod.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

do
    Command("buddha")
        :Permission("buddha", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                Lyn.Player.SetVar(target, "buddha", true)
            end

            Command.Notify("*", "#commands.buddha.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    Command("unbuddha")
        :Permission("buddha", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                Lyn.Player.SetVar(target, "buddha", nil)
            end

            Command.Notify("*", "#commands.unbuddha.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    if SERVER then
        hook.Add("EntityTakeDamage", "SAM.BuddhaMode", function(ply, info)
            if type(ply) == "Player" and Lyn.Player.GetVar(ply, "buddha") and ply:Health() - info:GetDamage() <= 1 then
                ply:SetHealth(1)
                return true
            end
        end)
    end
end

do
    Command("freeze")
        :Permission("freeze", "admin")

        :Param("player")
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                target:ExitVehicle()
                if Lyn.Player.GetSharedVar(target, "frozen") then
                    target:UnLock()
                end
                target:Lock()
                Lyn.Player.SetSharedVar(target, "frozen", true)
                Lyn.Player.SetExclusive(target, "freeze")
            end

            Command.Notify("*", "#commands.freeze.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    Command("unfreeze")
        :Permission("freeze", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                target:UnLock()
                Lyn.Player.SetSharedVar(target, "frozen", nil)
                Lyn.Player.SetExclusive(target, nil)
            end

            Command.Notify("*", "#commands.unfreeze.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    local function disallow(ply)
        if Lyn.Player.GetSharedVar(ply, "frozen") then
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
            Lyn.Player.Cloak(target, true)
        end

        Command.Notify("*", "#commands.cloak.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

Command("uncloak")
    :Permission("cloak", "admin")

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            Lyn.Player.Cloak(target, false)
        end

        Command.Notify("*", "#commands.uncloak.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

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
    :Add()

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
    :Add()

Command("setmodel")
    :Permission("setmodel")

    :Param("player")
    :Param("string", { hint = "model", default = "models/props_c17/oildrum001.mdl" })
    :Execute(function(ply, targets, model)
        for _, target in ipairs(targets) do
            target:SetModel(model)
        end

        Command.Notify("*", "#commands.setmodel.notify", {
            P = ply,
            T = targets,
            model = model,
        })
    end)
    :Add()

Command("giveammo")
    :Aliases("setammo", "setammunition", "ammo")
    :Permission("giveammo")

    :Param("player", { default = "^" })
    :Param("number", { hint = "amount", min = 0, max = 99999, default = 100, round = true })
    :Execute(function(ply, targets, amount)
        for _, target in ipairs(targets) do
            for _, wep in ipairs(target:GetWeapons()) do
                if wep:GetPrimaryAmmoType() ~= -1 then
                    target:GiveAmmo(amount, wep:GetPrimaryAmmoType(), true)
                end

                if wep:GetSecondaryAmmoType() ~= -1 then
                    target:GiveAmmo(amount, wep:GetSecondaryAmmoType(), true)
                end
            end
        end

        Command.Notify("*", "#commands.giveammo.notify", {
            P = ply,
            T = targets,
            amount = amount,
        })
    end)
    :Add()

-- scale
Command("scale")
    :Permission("scale")

    :Param("player")
-- thanks to https://www.gmodstore.com/users/76561198109871279 for telling me to set a min value to stop crashes
    :Param("number", { hint = "amount", min = 0.0001, max = 2.5, default = 1 })
    :Execute(function(ply, targets, amount)
        for _, target in ipairs(targets) do
            target:SetModelScale(amount)

            -- https://github.com/carz1175/More-ULX-Commands/blob/9b142ee4247a84f16e2dc2ec71c879ab76e145d4/lua/ulx/modules/sh/extended.lua#L313
            target:SetViewOffset(Vector(0, 0, 64 * amount))
            target:SetViewOffsetDucked(Vector(0, 0, 28 * amount))

            Lyn.Player.SetVar(target, "was_scaled", true)
        end

        Command.Notify("*", "#commands.scale.notify", {
            P = ply,
            T = targets,
            amount = amount,
        })
    end)
    :Add()

if SERVER then
    hook.Add("PlayerSpawn", "Lyn.Scale", function(ply)
        if Lyn.Player.GetVar(ply, "was_scaled") then
            Lyn.Player.SetVar(ply, "was_scaled", nil)
            ply:SetViewOffset(Vector(0, 0, 64))
            ply:SetViewOffsetDucked(Vector(0, 0, 28))
        end
    end)
end
--

Command("freezeprops")
    :Permission("freezeprops", "admin")
    :Execute(function(ply)
        for _, prop in ipairs(ents.FindByClass("prop_physics")) do
            local physics_obj = prop:GetPhysicsObject()
            if IsValid(physics_obj) then
                physics_obj:EnableMotion(false)
            end
        end

        Command.Notify("*", "#commands.freezeprops.notify", {
            P = ply,
        })
    end)
    :Add()
