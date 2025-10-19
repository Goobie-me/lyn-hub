local Lyn = Lyn
local Config = Lyn.Config
local TimeUtils = Lyn.GoobieCore.TimeUtils
local UI = Lyn.UI

Config.AddTab("Adverts", function(sheet)
    local panel = sheet:Add("GPanel")
    panel:Dock(FILL)
    panel:DockPadding(8, 5, 8, 5)

    local comment = panel:Add("GLabel")
    comment:Dock(TOP)
    comment:SetWrap(true)
    comment:SetAutoStretchVertical(true)
    comment:SetText(
        "Timed adverts can be done like this: {1m} This advert prints every 1 minute")

    local random_adverts_delay = panel:Add("GLabelPanel")
    random_adverts_delay:Dock(TOP)
    random_adverts_delay:DockMargin(0, 0, 0, 5)
    random_adverts_delay:SetLabel("Random Adverts delay")

    local random_adverts_delay_entry = UI.Create("GTextEntry")
    random_adverts_delay_entry:SetCheck(function(v) return TimeUtils.ParseDuration(v) ~= nil end)
    random_adverts_delay_entry:SetEnterMode(true)
    random_adverts_delay_entry:On("OnEnter", function(self, value)
        value = TimeUtils.ParseDuration(value)
        value = TimeUtils.ShortFormatDuration(value, nil, true)
        self:SetValue(value)
    end)
    random_adverts_delay_entry:SetConfig("adverts_random_delay", "2min")
    random_adverts_delay:SetPanel(random_adverts_delay_entry)

    local adverts_panel = panel:Add("GScrollPanel")
    adverts_panel:Dock(FILL)
    adverts_panel:SetPaintBackground(false)

    local zpos = 0

    local function on_enter(self, value, initial_value)
        local adverts = Config.Get("adverts", {})
        for _, pnl in ipairs(adverts_panel:GetCanvas():GetChildren()) do
            local value = self == pnl and value or pnl:GetValue()
            local initial_value = self == pnl and initial_value or pnl:GetInitialValue()
            if value == "" then
                pnl:Remove()
                if pnl.pos then
                    table.remove(adverts, pnl.pos)
                    if pnl.is_new then goto _continue_ end
                end
            else
                if value ~= initial_value then
                    adverts[pnl.pos] = value
                else
                    goto _continue_
                end
            end
            ::_continue_::
        end
        Config.Set("adverts", adverts)
    end

    local function add_advert_entry(text)
        zpos = zpos + 1
        local entry = adverts_panel:Add("GTextEntry")
        entry:Dock(TOP)
        entry:DockMargin(0, 0, 0, 5)
        entry:SetZPos(zpos)
        entry:SetEnterMode(true)
        entry:SetValue(text or "")
        entry:SetAutoStretchVertical(true)
        entry:On("OnEnter", on_enter)
        return entry
    end

    local add_advert = panel:Add("GButton")
    add_advert:Dock(BOTTOM)
    add_advert:DockMargin(0, 5, 0, 0)
    add_advert:SetText("Add Advert")

    add_advert:On("DoClick", function()
        local entry = add_advert_entry()
        entry.pos = zpos
        entry.is_new = true -- mark as a new entry incase user wants to remove it
    end)

    Config.Hook({ { "adverts", {} } }, adverts_panel, function(adverts)
        zpos = 0
        adverts_panel:Clear()
        for i = 1, #adverts do
            local entry = add_advert_entry(adverts[i])
            entry.pos = i
        end
    end)

    adverts_panel:On("OnRemove", function()
        Config.UnHook(adverts_panel)
    end)

    return panel
end, {
    pos = 3,
    check = function()
        return LocalPlayer():HasPermission("menu.manage_config")
    end
})

local times = {}
local random = {}

Config.Hook({ { "adverts_random_delay", "2min" } }, "adverts_random_delay", function(adverts_random_delay)
    timer.Create("Lyn.Advert.RandomAdverts", TimeUtils.ParseDuration(adverts_random_delay), 0, function()
        local ad = random[math.random(1, #random)]
        if not ad then return end
        Lyn.Player.Chat.Add(ad)
    end)
end)

Config.Hook({ { "adverts", {} } }, "adverts", function(adverts)
    for i = #times, 1, -1 do
        times[i] = nil
        timer.Remove("Lyn.Adverts." .. i)
    end

    random = {}
    for _, v in ipairs(adverts) do
        if v:sub(1, 1) == "{" then
            local time, message = v:match("(%b{}) *(.*)")
            time = TimeUtils.ParseDuration(time)
            if time then
                timer.Create("Lyn.Adverts." .. table.insert(times, true), time, 0, function()
                    Lyn.Player.Chat.Add(message)
                end)
            else
                table.insert(random, v)
            end
        else
            table.insert(random, v)
        end
    end
end)
