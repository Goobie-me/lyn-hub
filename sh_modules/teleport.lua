local Lyn     = Lyn
local Command = Lyn.Command
local util    = util
local Vector  = Vector
local IsValid = IsValid
local bit     = bit
local math    = math

Command.SetCategory("Teleport")

local VEC_UP_4      = Vector(0, 0, 4)
local VEC_UP_8      = Vector(0, 0, 8)
local VEC_UP_16     = Vector(0, 0, 16)
local VEC_UP_32     = Vector(0, 0, 32)
local VEC_UP_64     = Vector(0, 0, 64)
local VEC_DOWN_512  = Vector(0, 0, 512)
local VEC_DOWN_4096 = Vector(0, 0, 4096)

local MASK_GROUND   = MASK_PLAYERSOLID_BRUSHONLY
local MASK_STAND    = MASK_PLAYERSOLID

local CONTENTS_BAD  = CONTENTS_SLIME

local ALT_MAX_DROP  = 160
local ALT_MAX_RISE  = 128
local SEP_PAD       = 8  -- bubble between players
local CLEAR_PAD     = 4  -- extra hull fatness
local BASE_STEP     = 36 -- base radial step (grows as needed)
local MAX_RADIUS    = 1200

local function hull(ply) return ply:GetHull() end
local function hull_duck(ply) return ply:GetHullDuck() end

local function expand(mins, maxs, pad)
    if not pad or pad <= 0 then return mins, maxs end
    return Vector(mins.x - pad, mins.y - pad, mins.z),
        Vector(maxs.x + pad, maxs.y + pad, maxs.z + pad)
end

local function hull_radius(mins, maxs)
    local w = math.max(maxs.x - mins.x, maxs.y - mins.y)
    return w * 0.5
end

local function bad_at(pos)
    return bit.band(util.PointContents(pos), CONTENTS_BAD) ~= 0
end

local function trace_ground(origin, mins, maxs, filter)
    return util.TraceHull({
        start  = origin + VEC_UP_64,
        endpos = origin - VEC_DOWN_4096,
        mins   = mins,
        maxs   = maxs,
        mask   = MASK_GROUND,
        filter = filter
    })
end

local function snap_floor(pos, mins, maxs, filter)
    local tr = util.TraceHull({
        start  = pos + VEC_UP_32,
        endpos = pos - VEC_DOWN_512,
        mins   = mins,
        maxs   = maxs,
        mask   = MASK_GROUND,
        filter = filter
    })
    if tr.Hit and tr.HitNormal.z > 0.7 then
        local hit = tr.HitPos + VEC_UP_4
        if not bad_at(hit) then return hit end
    end
end

local function clear_here(pos, mins, maxs, filter, pad)
    local cmins, cmaxs = expand(mins, maxs, pad or CLEAR_PAD)
    local t = util.TraceHull({
        start  = pos,
        endpos = pos,
        mins   = cmins,
        maxs   = cmaxs,
        mask   = MASK_STAND,
        filter = filter
    })
    return not t.StartSolid and not t.AllSolid
end

local function can_stand(pos, mins, maxs, stand_filter)
    local t = util.TraceHull({
        start  = pos,
        endpos = pos,
        mins   = mins,
        maxs   = maxs,
        mask   = MASK_STAND,
        filter = stand_filter
    })
    if t.StartSolid or t.AllSolid then return false end
    return clear_here(pos, mins, maxs, stand_filter, CLEAR_PAD)
end

local function caller_ground_z(caller, mins, maxs)
    local g = trace_ground(caller:GetPos(), mins, maxs, { caller })
    if g.Hit and g.HitNormal.z > 0.7 then
        local floor = snap_floor(g.HitPos, mins, maxs, { caller }) or (g.HitPos + VEC_UP_4)
        return floor.z
    end
    return caller:GetPos().z
end

local function z_ok(z, caller_z)
    if z < (caller_z - ALT_MAX_DROP) then return false end
    if z > (caller_z + ALT_MAX_RISE) then return false end
    return true
end

local function push_history(ply)
    local tele_stack = Lyn.Player.GetVar(ply, "command_teleport_stack", {})
    tele_stack[#tele_stack + 1] = { pos = ply:GetPos(), ang = ply:EyeAngles() }
    Lyn.Player.SetVar(ply, "command_teleport_stack", tele_stack)
end

local function unstick(ply)
    local mins, maxs = hull(ply)
    for _ = 1, 6 do
        local p = ply:GetPos()
        local t = util.TraceHull({ start = p, endpos = p, mins = mins, maxs = maxs, mask = MASK_STAND, filter = { ply } })
        if not t.StartSolid and not t.AllSolid then return end
        ply:SetPos(p + VEC_UP_16)
    end
    local p0 = ply:GetPos()
    local offs = { Vector(16, 0, 8), Vector(-16, 0, 8), Vector(0, 16, 8), Vector(0, -16, 8),
        Vector(12, 12, 8), Vector(-12, 12, 8), Vector(12, -12, 8), Vector(-12, -12, 8) }
    for i = 1, #offs do
        local p = p0 + offs[i]
        local t = util.TraceHull({ start = p, endpos = p, mins = mins, maxs = maxs, mask = MASK_STAND, filter = { ply } })
        if not t.StartSolid and not t.AllSolid then
            ply:SetPos(p)
            return
        end
    end
    ply:SetPos(p0 + Vector(0, 0, 64))
end

local function respects_sep(pos, my_mins, my_maxs, placed, sep_pad)
    local my_r = hull_radius(my_mins, my_maxs) + (sep_pad or SEP_PAD)
    for i = 1, #placed do
        local other = placed[i]
        if IsValid(other.ent) then
            local emin, emax = other.mins, other.maxs
            local need = my_r + hull_radius(emin, emax)
            if pos:DistToSqr(other.pos) < (need * need) then
                return false
            end
        end
    end
    return true
end

local function gen_ring_slots(center, r, step, angle_offset)
    local circ = 2 * math.pi * r
    local count = math.max(6, math.floor(circ / step + 0.5))
    local out, n = {}, 0
    local da = (2 * math.pi) / count
    local a0 = angle_offset or 0
    for i = 0, count - 1 do
        local a = a0 + i * da
        n = n + 1
        out[n] = center + Vector(math.cos(a) * r, math.sin(a) * r, 0)
    end
    return out
end

local function collect_slots(caller, worst_mins, worst_maxs, caller_z, R, step)
    local origin = caller:GetPos()
    local slots = {}
    local angle_jitter = 0
    local ignore_ground = { caller }

    do
        local eye = caller:EyeAngles()
        local try = origin + eye:Forward() * 72
        local g = trace_ground(try, worst_mins, worst_maxs, ignore_ground)
        if g.Hit and g.HitNormal.z > 0.7 then
            local floor = snap_floor(g.HitPos, worst_mins, worst_maxs, ignore_ground)
            if floor and z_ok(floor.z, caller_z) and not bad_at(floor) then
                slots[#slots + 1] = floor
            end
        end
    end

    for r = step, R, step do
        local ring = gen_ring_slots(origin, r, step, angle_jitter)
        angle_jitter = angle_jitter + 0.37
        for i = 1, #ring do
            local g = trace_ground(ring[i], worst_mins, worst_maxs, ignore_ground)
            if g.Hit and g.HitNormal.z > 0.7 then
                local floor = snap_floor(g.HitPos, worst_mins, worst_maxs, ignore_ground)
                if floor and z_ok(floor.z, caller_z) and not bad_at(floor) then
                    slots[#slots + 1] = floor
                end
            end
        end
    end
    table.sort(slots, function(a, b) return a:DistToSqr(origin) < b:DistToSqr(origin) end)
    return slots
end

local function assign_slots(caller, targets)
    local worst_mins, worst_maxs, worst_r
    local target_count = #targets

    local target_hulls = {}
    for i = 1, target_count do
        local target = targets[i]
        if not target:Alive() then target:Spawn() end
        target:ExitVehicle()
        local mi, ma = hull(target)
        local ri = hull_radius(mi, ma)
        local dmi, dma = hull_duck(target)
        target_hulls[i] = {
            ent = target,
            mins = mi,
            maxs = ma,
            dmins = dmi,
            dmaxs = dma
        }
        if not worst_r or ri > worst_r then
            worst_r, worst_mins, worst_maxs = ri, mi, ma
        end
    end

    local caller_z = caller_ground_z(caller, worst_mins, worst_maxs)
    local step = math.max(BASE_STEP, (worst_r * 2) + (SEP_PAD * 2))
    local R = step
    local placed = {}
    local placed_lookup = {}
    local taken = {}
    local origin = caller:GetPos()
    local min_dist_sqr = (worst_r + SEP_PAD) ^ 2

    while #placed < target_count and R <= MAX_RADIUS do
        local slots = collect_slots(caller, worst_mins, worst_maxs, caller_z, R, step)
        local slot_count = #slots
        for s = 1, slot_count do
            if not taken[s] then
                local pos = slots[s]
                if pos:DistToSqr(origin) > min_dist_sqr then
                    for t = 1, target_count do
                        if not placed_lookup[t] then
                            local th = target_hulls[t]
                            local stand_filter = { th.ent }
                            if can_stand(pos, th.mins, th.maxs, stand_filter)
                                and respects_sep(pos, th.mins, th.maxs, placed, SEP_PAD) then
                                taken[s] = true
                                placed_lookup[t] = true
                                placed[#placed + 1] = { ent = th.ent, pos = pos, mins = th.mins, maxs = th.maxs }
                                break
                            elseif can_stand(pos, th.dmins, th.dmaxs, stand_filter)
                                and respects_sep(pos, th.dmins, th.dmaxs, placed, SEP_PAD) then
                                taken[s] = true
                                placed_lookup[t] = true
                                placed[#placed + 1] = { ent = th.ent, pos = pos, mins = th.dmins, maxs = th.dmaxs }
                                break
                            end
                        end
                    end
                    if #placed >= target_count then break end
                end
            end
        end
        R = R + step
    end
    return placed
end

local function place_group(caller, targets)
    local plan = assign_slots(caller, targets)
    if #plan == 0 then return {} end

    local exclusives = { caller = caller }
    targets = { caller = caller }

    for i = 1, #plan do
        local item   = plan[i]
        local target = item.ent
        if Lyn.Player.GetExclusive(caller, target) then
            table.insert(exclusives, target)
        else
            table.insert(targets, target)
            push_history(target)
            target:SetGroundEntity(nil)
            target:SetPos(item.pos + VEC_UP_8)
            target:DropToFloor()
            Lyn.Player.Timer.Simple(target, 0, unstick)
            local look = (caller:EyePos() - target:EyePos()):Angle()
            target:SetEyeAngles(look)
        end
    end

    return targets, exclusives
end

Command("bring")
    :Permission("bring", "admin")

    :DenyConsole()

    :Param("player", { cant_target_self = true })
    :Execute(function(ply, targets)
        if #targets == 1 and Lyn.Player.SendExclusiveMessage(ply, targets[1]) then
            return
        end
        local targets, exclusives = place_group(ply, targets)
        if #targets > 0 then
            LYN_NOTIFY("*", "#lyn.commands.bring.notify", {
                P = ply,
                T = targets,
            })
        end
        if #exclusives > 0 then
            Lyn.Player.Chat.Send(ply, "#lyn.commands_core.exclusive_error_targets", {
                T = exclusives
            })
        end
    end)
    :Add()

Command("goto")
    :Permission("goto", "admin")

    :DenyConsole()

    :Param("player", { cant_target_self = true, single_target = true, allow_higher_target = true })
    :Execute(function(ply, targets)
        local target = targets[1]
        if Lyn.Player.SendExclusiveMessage(ply, target) then return end
        place_group(target, { ply })

        LYN_NOTIFY("*", "#lyn.commands.goto.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()

Command("return")
    :Permission("return", "admin")

    :DenyConsole()

    :Param("player", { default = "^" })
    :Execute(function(ply, targets)
        local count = #targets
        for _, target in ipairs(targets) do
            local tele_stack = Lyn.Player.GetVar(target, "command_teleport_stack", {})
            if #tele_stack > 0 then
                local last = table.remove(tele_stack)
                Lyn.Player.SetVar(target, "command_teleport_stack", tele_stack)

                target:SetGroundEntity(nil)
                target:SetPos(last.pos)
                target:SetEyeAngles(last.ang)
                target:DropToFloor()

                Lyn.Player.Timer.Simple(target, 0, unstick)
            elseif count == 1 then
                Lyn.Player.Chat.Send(ply, "#lyn.commands.return.no_previous_location", {
                    P = target
                })
                return
            end
        end

        LYN_NOTIFY("*", "#lyn.commands.return.notify", {
            P = ply,
            T = targets,
        })
    end)
    :Add()
