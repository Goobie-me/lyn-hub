local load = not GAMEMODE and hook.Add or function(_, _, fn)
    fn()
end

load("PostGamemodeLoaded", "Lyn.DarkRP", function()
    if not DarkRP then return end

    local Lyn = Lyn
    local Command = Lyn.Command

    Command.SetCategory("DarkRP")

    Command("arrest")
        :Permission("arrest", "superadmin")

        :Param("player")
        :Param("number", { hint = "time", min = 0, default = 0, round = true })
        :Execute(function(caller, targets, time)
            do
                local time = time; if time == 0 then
                    time = math.huge
                end
                for i = 1, #targets do
                    local v = targets[i]
                    if v:isArrested() then
                        v:unArrest()
                    end
                    v:arrest(time, caller)
                end
            end

            LYN_NOTIFY("*", "#lyn.commands.arrest.notify_duration", {
                P = caller,
                T = targets,
                D = time
            })
        end)
        :Add()

    Command("unarrest")
        :Permission("unarrest", "superadmin")

        :Param("player", { default = "^" })
        :Execute(function(caller, targets)
            for i = 1, #targets do
                targets[i]:unArrest()
            end

            LYN_NOTIFY("*", "#lyn.commands.unarrest.notify", {
                P = caller,
                T = targets
            })
        end)
        :Add()

    Command("setmoney")
        :Permission("setmoney", "superadmin")

        :Param("player", { single_target = true })
        :Param("number", { hint = "amount", min = 0, round = true })

        :Execute(function(caller, targets, amount)
            local target = targets[1]

            amount = hook.Call("playerWalletChanged", GAMEMODE, target, amount - target:getDarkRPVar("money"),
                target:getDarkRPVar("money")) or amount

            DarkRP.storeMoney(target, amount)
            target:setDarkRPVar("money", amount)

            LYN_NOTIFY("*", "#lyn.commands.setmoney.notify", {
                P = caller, T = targets, amount = amount
            })
        end)
        :Add()

    Command("addmoney")
        :Permission("addmoney", "superadmin")

        :Param("player", { single_target = true })
        :Param("number", { hint = "amount", min = 0, round = true })
        :Execute(function(caller, targets, amount)
            targets[1]:addMoney(amount)

            LYN_NOTIFY("*", "#lyn.commands.addmoney.notify", {
                P = caller, T = targets, amount = amount
            })
        end)
        :Add()

    Command("selldoor")
        :Permission("selldoor", "superadmin")

        :Execute(function(caller)
            local ent = caller:GetEyeTrace().Entity
            if not IsValid(ent) or not ent.keysUnOwn then
                return Lyn.Player.Chat.Send(caller, "#lyn.commands.selldoor.invalid")
            end
            local door_owner = ent:getDoorOwner()
            if not IsValid(door_owner) then
                return Lyn.Player.Chat.Send(caller, "#lyn.commands.selldoor.no_owner")
            end
            ent:keysUnOwn(caller)

            LYN_NOTIFY("*", "#lyn.commands.selldoor.notify", {
                P = caller, T = { door_owner, caller = caller }
            })
        end)
        :Add()

    Command("sellall")
        :Permission("sellall", "superadmin")

        :Param("player", { single_target = true })
        :Execute(function(caller, targets, amount)
            targets[1]:keysUnOwnAll()

            LYN_NOTIFY("*", "#lyn.commands.sellall.notify", {
                P = caller, T = targets
            })
        end)
        :Add()

    Command("darkrpsetjailpos")
        :Permission("darkrpsetjailpos", "superadmin")

        :Execute(function(caller)
            DarkRP.storeJailPos(caller, false)

            LYN_NOTIFY("*", "#lyn.commands.darkrpsetjailpos.notify", {
                P = caller
            })
        end)
        :Add()

    Command("darkrpaddjailpos")
        :Permission("darkrpaddjailpos", "superadmin")

        :Execute(function(caller)
            DarkRP.storeJailPos(caller, true)

            LYN_NOTIFY("*", "#lyn.commands.darkrpaddjailpos.notify", {
                P = caller
            })
        end)
        :Add()

    local RPExtraTeams = RPExtraTeams
    local job_index = nil

    Command("setjob")
        :Permission("setjob", "admin")

        :Param("player")
        :Param("string", {
            hint = "job",
            check = function(job)
                job = job:lower()

                for i = 1, #RPExtraTeams do
                    local v = RPExtraTeams[i]
                    if v.name:lower() == job or v.command:lower() == job then
                        job_index = v.team
                        return true
                    end
                end

                return false
            end
        })
        :Execute(function(caller, targets, job)
            for i = 1, #targets do
                targets[i]:changeTeam(job_index, true, true, true)
            end

            LYN_NOTIFY("*", "#lyn.commands.setjob.notify", {
                P = caller, T = targets, job = job
            })
        end)
        :Add()

    do
        local function get_shipment(ctx)
            local name = ctx.value
            if not name then return false end

            local found, key = DarkRP.getShipmentByName(name)
            if found then return found, key end

            name = name:lower()

            local shipments = CustomShipments
            for i = 1, #shipments do
                local shipment = shipments[i]
                if shipment.entity == name then
                    return DarkRP.getShipmentByName(shipment.name)
                end
            end

            return false
        end

        local function place_entity(ent, tr, ply)
            local ang = ply:EyeAngles()
            ang.pitch = 0
            ang.yaw = ang.yaw - 90
            ang.roll = 0
            ent:SetAngles(ang)

            local flush_point = tr.HitPos - (tr.HitNormal * 512)
            flush_point = ent:NearestPoint(flush_point)
            flush_point = ent:GetPos() - flush_point
            flush_point = tr.HitPos + flush_point
            ent:SetPos(flush_point)
        end

        Command("shipment")
            :Permission("shipment", "superadmin")

            :Param("string", { hint = "shipment", check = get_shipment })
            :Execute(function(caller, shipment)
                local tr_start = caller:EyePos()
                local tr = util.TraceLine({
                    start = tr_start,
                    endpos = tr_start + caller:GetAimVector() * 85,
                    filter = caller
                })

                local shipment_info, shipment_key = get_shipment({ value = shipment })

                local crate = ents.Create(shipment_info.shipmentClass or "spawned_shipment")
                crate.SID = caller.SID
                crate:Setowning_ent(caller)
                crate:SetContents(shipment_key, shipment_info.amount)
                crate:SetPos(Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z))
                crate.nodupe = true
                crate.ammoadd = shipment_info.spareammo
                crate.clip1 = shipment_info.clip1
                crate.clip2 = shipment_info.clip2
                crate:Spawn()
                crate:SetPlayer(caller)

                place_entity(crate, tr, caller)

                local phys = crate:GetPhysicsObject()
                phys:Wake()
                if shipment_info.weight then
                    phys:SetMass(shipment_info.weight)
                end

                LYN_NOTIFY("*", "#lyn.commands.shipment.notify", {
                    P = caller, shipment = shipment
                })
            end)
            :Add()
    end

    Command("forcename")
        :Permission("forcename", "superadmin")

        :Param("player")
        :Param("string", { hint = "name" })
        :Execute(function(caller, targets, name)
            local target = targets[1]

            DarkRP.retrieveRPNames(name, function(taken)
                if not IsValid(target) then return end

                if taken then
                    return Lyn.Player.Chat.Send(caller, "#lyn.commands.forcename.taken", {
                        name = name
                    })
                end

                LYN_NOTIFY("*", "#lyn.commands.forcename.notify", {
                    P = caller, T = targets, name = name
                })

                DarkRP.storeRPName(target, name)
                target:setDarkRPVar("rpname", name)
            end)
        end)
        :Add()
end)
