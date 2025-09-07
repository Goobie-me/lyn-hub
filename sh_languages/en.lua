---@diagnostic disable: lowercase-global

-- You don't have access to _G, only Color function for now, I can add more if needed.

-- All Targets, You, Yourself, Everyone, Unknown, Console get prepended with a white "*"
-- This is to be easier to identify them from players that have the same name as them.
targets = {
    -- This will be used inside {P}
    you = {
        label = "You",
        color = Color(255, 215, 0)
    },

    yourself = "Yourself", -- Color will be the same as "You"

    himself = "Himself",   -- Color will be his role color

    -- This will be used inside {T} when the target is "*"
    -- when it prints everyone in chat, it doesn't mean literally everyone, it's everyone that the player can target.
    everyone = {
        label = "Everyone",
        color = Color(153, 0, 255)
    },

    -- This will be used if {P} is not a player/Console/string
    unknown = {
        label = "Unknown",
        color = Color(80, 80, 80)
    },

    -- This will be used if {P} is the console and also used by other functions that need to refer to the console's name
    console = {
        label = "Console",
        color = Color(46, 136, 137)
    }
}

themes = {
    blur = "Blur",
    dark = "Dark",
    light = "Light",
}

-- Used as default "reason" for most commands, eg. ban, kick, mute ...etc
unspecified = "unspecified"

banning = {
    immunity_error =
    "You cannot modify this player's ban because it was issued by someone with higher immunity than you.",

    unban_immunity_error =
    "You cannot unban this player because their ban was issued by someone with higher immunity than you.",
    unban_no_active_ban = "The user is not currently banned.",

    -- %reason% - The reason the player was banned.
    -- %banned_at% - The date and time the player was banned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %expires_at% - The date and time the player will be unbanned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %ends_in% - The time remaining until the player is unbanned. formatted as "1 hour, 10 minutes and 5 seconds"
    -- %admin_name% - The name of the admin who banned the player.
    -- %admin_steamid64% - The SteamID64 of the admin who banned the player.
    message = [[
You have been banned from this server.

- Banned By: %admin_name% (%admin_steamid64%)
- Reason: %reason%
- Ban Date: %banned_at%
- Unban Date: %expires_at%
- Time Remaining: %ends_in%

If you believe this ban was issued in error, please contact the server staff.
]]
}

player_role_expired = "Your role {red %role%} has expired."

commands = {
    menu_help = "Open the admin mod menu.",

    cant_use_as_console = "You must be a player to use the {red %command%} command.",
    no_permission = "You do not have permission to use the {red %command%} command.",

    -- this could happen when a db query fails, etc.
    failed_to_run = "Failed to run the command. Please check the server console for more information.",

    arguments = {
        -- Sent when a player types an invalid argument.
        -- e.g., "Invalid steamid! (784154572)"
        -- "Invalid number! (invalidsdsds)"
        invalid = "Invalid %argument%! Input: {red %input%}",

        -- [%[%valid_inputs%]%] - A list of valid inputs for the parameter. It can't be used inside a {}.
        -- %param_idx% - The index of the parameter in the command.
        -- %param_name% - The hint/name of the parameter.
        -- %input% - The input the player provided.
        restricted =
        "Param {blue %param_name%} #{gold %param_idx%}, with input {red %input%}, is restricted to: [[%[%valid_inputs%]%]]",

        cant_find_target = "Cannot find a player matching {red %target%}",
        target_not_authed = "You cannot target {T} because they are not authenticated yet.",
        cant_target = "You cannot target {T}.",
        cant_target_self = "You cannot target yourself using the {red %command%} command.",
        cant_target_multiple = "You cannot target multiple players using the {red %command%} command.",

        -- Triggered when trying to target a player using their entity ID, e.g.,
        -- !kick #1
        -- The invalid ID message is sent when the input is not a number.
        invalid_id = "Invalid ID ({red %input%})!",

        player_id_not_found = "No player found with ID {red %input%}",

        player_steamid_not_found = "No player found with SteamID/SteamID64 {red %input%}",

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Multiple players found: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "No valid targets found.",

        role_does_not_exist = "The role {red %role%} does not exist.",
    },

    exclusive_error = "Cannot run this command on {T} - {red %reason%} is currently active.",

    -- Hints translations are automatically used without using a # before them unlike commands' names.
    hints = {
        duration = "duration",
        number = "number",
        player = "player",
        reason = "reason",
        steamid64 = "steamid64",
        string = "string",

        amount = "amount",
        role = "role",
        immunity = "immunity",
        display_name = "display name",
        color = "color",
        message = "message",
        extends = "extends",
    },

    help = {
        help = "Display a list of available commands or get help for a specific command.",
        no_command = "No command found with the name {red %command%}",
    },

    -- Chat

    pm = {
        help = "Send a private message to a player.",

        to = "{gold PM} to {T}: {green %message%}",
        from = "{gold PM} from {P}: {green %message%}",
    },

    asay = {
        help = "Send a message to admin chat.",

        notify = "[{lightred Admins}] {P}: {green %message%}",
        notify_no_access = "{P} to {lightred Admins}: {red %message%}",
    },

    speakas = {
        help = "Send a message as another player.",
    },

    mute = {
        help = "Mute a player(s).",
        notify = "{P} muted {T} for {green %duration%} with reason {red %reason%}",

        notify_muted = "You are muted for {green %duration%} with reason {red %reason%}"
    },

    unmute = {
        help = "Unmute a player(s).",
        notify = "{P} unmuted {T}",
    },

    gag = {
        help = "Gag a player(s).",
        notify = "{P} gagged {T} for {green %duration%} with reason {red %reason%}",
    },

    ungag = {
        help = "Ungag a player(s).",
        notify = "{P} ungagged {T}",
    },

    -- Fun Commands

    hp = {
        help = "Set the health of player(s).",
        notify = "{P} set the HP of {T} to {green %amount%}",
    },

    armor = {
        help = "Set the armor of player(s).",
        notify = "{P} set the armor of {T} to {green %amount%}",
    },

    give = {
        help = "Give a weapon or entity to player(s).",
        notify = "{P} gave {T} {green %class%}",
    },

    slap = {
        help = "Slap a player(s), causing them to take damage.",

        notify = "{P} slapped {T}",
        notify_damage = "{P} slapped {T} for {green %damage%} damage",
    },

    slay = {
        help = "Slay a player, causing them to die instantly.",
        notify = "{P} slayed {T}",
    },

    ignite = {
        help = "Ignite a player, setting them on fire.",
        notify = "{P} ignited {T} for {green %duration%} seconds",
    },

    unignite = {
        help = "Extinguish a player, removing the fire effect.",
        notify = "{P} extinguished {T}",
    },

    god = {
        help = "Enable god mode for player(s).",
        notify = "{P} enabled god mode for {T}",
    },

    ungod = {
        help = "Disable god mode for player(s).",
        notify = "{P} disabled god mode for {T}",
    },

    buddha = {
        help = "Makes player(s) invincible when their health is 1.",
        notify = "{P} enabled buddha mode for {T}",
    },

    unbuddha = {
        help = "Disables buddha mode for player(s).",
        notify = "{P} disabled buddha mode for {T}",
    },

    freeze = {
        help = "Freeze player(s).",
        notify = "{P} froze {T}",
    },

    unfreeze = {
        help = "Unfreeze player(s).",
        notify = "{P} unfroze {T}",
    },

    cloak = {
        help = "Cloak player(s), making them invisible.",
        notify = "{P} cloaked {T}",
    },

    uncloak = {
        help = "Uncloak player(s), making them visible again.",
        notify = "{P} uncloaked {T}",
    },

    strip = {
        help = "Strip player(s) of their weapons.",
        notify = "{P} stripped {T} of their weapons",
    },

    setmodel = {
        help = "Set the model of player(s).",
        notify = "{P} set the model of {T} to {green %model%}",
    },

    giveammo = {
        help = "Give ammunition to player(s).",
        notify = "{P} gave {T} {green %amount%} ammo",
    },

    scale = {
        help = "Scale player(s) to a specific size.",
        notify = "{P} scaled {T} to {green %amount%}",
    },

    freezeprops = {
        help = "Freeze props in the world.",
        notify = "{P} froze all props",
    },

    jail = {

    },

    respawn = {
        help = "Respawn a player.",
        notify = "{P} respawned {T}",
    },

    -- User Management Commands

    grantrole = {
        help = "Grant a role to a player.",
        notify = "{P} granted the role {green %role%} to {T} for {green %duration%}",
        permanent = "Permanent", -- this will be used if duration is set to 0
    },

    grantroleid = {
        help = "Grant a role to a player by their SteamID/SteamID64.",
        notify = "{P} granted the role {green %role%} to {red %target_steamid64%} for {green %duration%}",
        permanent = "Permanent", -- this will be used if duration is set to 0
    },

    revokerole = {
        help = "Revoke a role from a player.",
        notify = "{P} revoked the role {red %role%} from {T}",
    },

    revokeroleid = {
        help = "Revoke a role from a player by their SteamID/SteamID64.",
        notify = "{P} revoked the role {red %role%} from {red %target_steamid64%}",
    },

    newrole = {
        help = "Create a new role.",
        notify = "{P} created a new role: {green %role%}",
    },

    deleterole = {
        help = "Delete a role.",
        notify = "{P} deleted the role: {red %role%}",
    },

    renamerole = {
        help = "Rename a role.",
        notify = "{P} renamed the role {red %old_role%} to {green %new_role%}",
    },

    setroleimmunity = {
        help = "Change the immunity level of a role.",
        notify = "{P} changed the immunity of {green %role%} to {green %immunity%}",
    },

    setroledisplayname = {
        help = "Change the display name of a role.",
        notify = "{P} changed the display name of {green %role%} to {green %display_name%}",
    },

    setrolecolor = {
        help = "Change the color of a role.",
        notify = "{P} changed the color of {green %role%} to {green %color%}",
    },

    setroleextends = {
        help = "Set or clear what role this one extends.",

        notify_set = "{P} set {green %role%} to extend {green %extends%}",
        notify_removed = "{P} removed the extend from {green %role%}",
    },

    rolegrantpermission = {
        help = "Grant a permission to a role.",
        notify = "{P} granted the permission {green %permission%} to the role {green %role%}",
    },

    rolerevokepermission = {
        help = "Revoke a permission from a role.",
        notify = "{P} revoked the permission {red %permission%} from the role {green %role%}",
    },

    roledeletepermission = {
        help = "Delete a permission from a role. Unlike revoke, it removes the override so inheritance applies.",
        notify = "{P} deleted the permission {red %permission%} from the role {green %role%}",
    },

    -- Utility Commands

    map = {
        help = "Change current map and/or gamemode.",

        notify = "A map change has been initiated by {P} and will occur in {green %duration%}.",
        notify_gamemode =
        "A map change has been initiated by {P} and will occur in {green %duration%} with the gamemode set to {green %gamemode%}.",
    },

    maprestart = {
        help = "Restart the current map.",
        notify =
        "A map restart has been initiated by {P} and will occur in {green %duration%}."
    },

    stopmaprestart = {
        help = "Stop the current map restart.",
        notify = "The map restart has been stopped by {P}",
        no_restart = "There is no map restart in progress"
    },

    mapreset = {
        help = "Reset the current map.",
        notify = "{P} performed a map reset"
    },

    kick = {
        help = "Kick a player from the server.",
        notify = "{P} kicked {T} for {red %reason%}",
    },

    kickm = {
        help = "Kick multiple players from the server.",
        notify = "{P} kicked {T} for {red %reason%}",
    },

    ban = {
        help = "Ban a player from the server.",
        notify = "{P} banned {T} for {green %duration%} with reason {red %reason%}",
    },

    banid = {
        help = "Ban a player by their SteamID/SteamID64.",
        notify = "{P} banned {red %target_steamid64%} for {green %duration%} with reason {red %reason%}",
    },

    unban = {
        help = "Unban a player from the server.",
        notify = "{P} unbanned {red %target_steamid64%}",
    },

    bot = {
        help = "Add a bot to the server.",
        notify = "{P} added {green %amount%} bot(s) to the server",
    },

    time = {
        help = "Check the playtime of a player.",
        your = "Your playtime: {green %time%}",
        target = "{T} playtime: {green %time%}",
    }
}
