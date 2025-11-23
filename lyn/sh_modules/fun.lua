local Lyn = Lyn
local Command = Lyn.Command
local TimeUtils = Lyn.GoobieCore.TimeUtils

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

        LYN_NOTIFY("*", "#lyn.commands.hp.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.armor.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.give.notify", {
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
                LYN_NOTIFY("*", "#lyn.commands.slap.notify_damage", {
                    P = ply,
                    T = targets,
                    damage = damage,
                })
            else
                LYN_NOTIFY("*", "#lyn.commands.slap.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.slay.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.ignite.notify", {
            P = ply,
            T = targets,
            D = duration,
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

        LYN_NOTIFY("*", "#lyn.commands.unignite.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.god.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.ungod.notify", {
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

            LYN_NOTIFY("*", "#lyn.commands.buddha.notify", {
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

            LYN_NOTIFY("*", "#lyn.commands.unbuddha.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    if SERVER then
        hook.Add("EntityTakeDamage", "Lyn.BuddhaMode", function(ply, info)
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

            LYN_NOTIFY("*", "#lyn.commands.freeze.notify", {
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

            LYN_NOTIFY("*", "#lyn.commands.unfreeze.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.cloak.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.uncloak.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

do
    local JAIL_WALLS = {
        { Vector(0, 0, -5),     Angle(90, 0, 0) },
        { Vector(0, 0, 97),     Angle(90, 0, 0) },
        { Vector(21, 31, 46),   Angle(0, 90, 0) },
        { Vector(21, -31, 46),  Angle(0, 90, 0) },
        { Vector(-21, 31, 46),  Angle(0, 90, 0) },
        { Vector(-21, -31, 46), Angle(0, 90, 0) },
        { Vector(-52, 0, 46),   Angle(0, 0, 0) },
        { Vector(52, 0, 46),    Angle(0, 0, 0) }
    }

    local function return_false() return false end

    local function cleanup_jail(ply)
        local props = Lyn.Player.GetVar(ply, "jail_props", {})
        for _, prop in ipairs(props) do
            if IsValid(prop) then prop:Remove() end
        end
    end

    local function unjail(ply)
        if not Lyn.Player.GetSharedVar(ply, "jailed") then return end
        cleanup_jail(ply)
        Lyn.Player.SetExclusive(ply, nil)
        Lyn.Player.Timer.Remove(ply, "Unjail")
        Lyn.Player.Timer.Remove(ply, "JailWatch")
        Lyn.Player.SetVar(ply, "jail_pos", nil)
        Lyn.Player.SetVar(ply, "jail_props", nil)
        Lyn.Player.SetSharedVar(ply, "jailed", nil)
    end

    local function jail(ply, time)
        if not IsValid(ply) then return end
        time = math.max(0, tonumber(time) or 0)

        if Lyn.Player.GetSharedVar(ply, "frozen") then
            Command.Execute("unfreeze", ply)
        end

        if not Lyn.Player.GetSharedVar(ply, "jailed") then
            ply:ExitVehicle()
            ply:SetMoveType(MOVETYPE_WALK)

            local pos = ply:GetPos()
            Lyn.Player.SetVar(ply, "jail_pos", pos)
            Lyn.Player.SetSharedVar(ply, "jailed", true)
            Lyn.Player.SetExclusive(ply, "jail")

            cleanup_jail(ply)

            local props = {}
            for _, wall in ipairs(JAIL_WALLS) do
                local prop = ents.Create("prop_physics")
                prop:SetModel("models/props_building_details/Storefront_Template001a_Bars.mdl")
                prop:SetPos(pos + wall[1])
                prop:SetAngles(wall[2])
                prop:Spawn()

                prop:SetMoveType(MOVETYPE_NONE)
                prop:GetPhysicsObject():EnableMotion(false)

                prop.CanTool = return_false
                prop.PhysgunPickup = return_false
                prop.jailWall = true

                table.insert(props, prop)
            end
            Lyn.Player.SetVar(ply, "jail_props", props)
        end

        Lyn.Player.Timer.Remove(ply, "Unjail")
        if time > 0 then
            Lyn.Player.Timer.Create(ply, "Unjail", time, 1, unjail)
        end

        Lyn.Player.Timer.Create(ply, "JailWatch", 0.5, 0, function()
            local pos = Lyn.Player.GetVar(ply, "jail_pos")
            if ply:GetPos():DistToSqr(pos) > 4900 then
                ply:SetPos(pos)
            end
            local props = Lyn.Player.GetVar(ply, "jail_props", {})
            if not IsValid(props[1]) then
                jail(ply, Lyn.Player.Timer.TimeLeft(ply, "Unjail") or 0)
            end
        end)
    end

    Command("jail")
        :Permission("jail", "admin")
        :Param("player")
        :Param("duration", { default = 0, min = 0 })
        :Param("string", { hint = "reason", optional = true })
        :GetRestArgs()
        :Execute(function(ply, targets, duration, reason)
            if not reason then
                reason = Lyn.I18n.t("#lyn.unspecified")
            end

            for _, target in ipairs(targets) do
                jail(target, duration)
            end

            LYN_NOTIFY("*", "#lyn.commands.jail.notify", {
                P = ply,
                T = targets,
                D = duration,
                reason = reason,
            })
        end)
        :Add()

    Command("unjail")
        :Permission("unjail", "admin")

        :Param("player", { default = "^" })
        :Execute(function(ply, targets)
            for _, target in ipairs(targets) do
                unjail(target)
            end

            LYN_NOTIFY("*", "#lyn.commands.unjail.notify", {
                P = ply,
                T = targets,
            })
        end)
        :Add()

    Lyn.Hook.PreReturn("CanProperty", "Lyn.Jail", function(_, _, ent)
        if ent.jailWall then
            return false
        end
    end)
end

Command("strip")
    :Permission("strip", "admin")

    :Param("player")
    :Execute(function(ply, targets)
        for _, target in ipairs(targets) do
            target:StripWeapons()
        end

        LYN_NOTIFY("*", "#lyn.commands.strip.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.respawn.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

Command("setmodel")
    :Permission("setmodel")

    :Param("player")
    :Param("string", { hint = "model" })
    :Execute(function(ply, targets, model)
        for _, target in ipairs(targets) do
            target:SetModel(model)
        end

        LYN_NOTIFY("*", "#lyn.commands.setmodel.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.giveammo.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.scale.notify", {
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

        LYN_NOTIFY("*", "#lyn.commands.freezeprops.notify", {
            P = ply,
        })
    end)
    :Add()
