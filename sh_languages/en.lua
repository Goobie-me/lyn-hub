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

    himself = "Himself", -- Color will be his role color

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

    -- This will be used if {P} is the console
    console = {
        label = "Console",
        color = Color(46, 136, 137)
    }
}

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
}

kicking = {
    default_reason = "Unspecified"
}

banning = {
    default_reason = "Unspecified",

    immunity_error = "You cannot modify this player's ban because they were banned by someone with higher immunity than you.",

    unban_immunity_error = "You cannot unban this player because they were banned by someone with higher immunity than you.",
    unban_no_active_ban = "The user is not currently banned.",

    -- this will be used if expires_at is set to "Permanent"
    expires_at_permanent = "Permanent",
    -- this will be used if ends_in is set to "Permanent"
    ends_in_permanent = "Permanent",
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
        restricted = "Param {blue %param_name%} #{gold %param_idx%}, with input {red %input%}, is restricted to: [[%[%valid_inputs%]%]]",

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

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Multiple players found: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "No valid targets found.",
    },

    hp = {
        identifiers = {
            "hp",
            "health",
            "sethealth",
            "sethp",
            "hpset",
            "healthset",
        },

        help = "Set the health of player(s).",
        notify = "{P} set the hp of {T} to {green %amount%}",
    },

    jail = {

    },

    pm = {
        help = "Send a private message to a player.",
    },

    -- User Management Commands
    grantrole = {
        identifiers = {
            "grantrole",
            "addrole",
            "giverole",
            "roleadd",
            "rolegrant",
            "rolegive",
        },

        help = "Grant a role to a player.",
        notify = "{P} granted the role {green %role%} to {T} for {green %duration%}",
        permanent = "Permanent", -- this will be used if duration is set to 0
    },

    grantroleid = {
        identifiers = {
            "grantroleid",
            "grantroleid64",
            "grantrolesteamid",
            "grantrolesteamid64",
            "addroleid",
            "addroleid64",
            "addrolesteamid",
            "addrolesteamid64",
            "giveroleid",
            "giveroleid64",
            "giverolesteamid",
            "giverolesteamid64",
        },

        help = "Grant a role to a player by their SteamID/SteamID64.",
        notify = "{P} granted the role {green %role%} to {red %target_steamid64%} for {green %duration%}",
        permanent = "Permanent", -- this will be used if duration is set to 0
    },

    revokerole = {
        identifiers = {
            "revokerole",
            "removerole",
            "takerole",
            "roleremove",
            "rolerevoke",
        },

        help = "Revoke a role from a player.",
        notify = "{P} revoked the role {red %role%} from {T}",
    },

    -- Utility Commands
    maprestart = {
        identifiers = {
            "maprestart",
            "restartmap",
            "restart"
        },

        help = "Restart the current map.",
        notify = "A map restart has been initiated by {P} and will occur in 10 seconds. Please prepare accordingly."
    },

    stopmaprestart = {
        identifiers = {
            "stopmaprestart",
            "stoprestart",
            "cancelrestart",
            "cancelmaprestart",
            "abortrestart",
        },

        help = "Stop the current map restart.",

        notify = "The map restart has been stopped by {P}",
        no_restart = "There is no map restart in progress."
    },

    mapreset = {
        identifiers = {
            "resetmap",
            "mapreset",
            "mapclear",
            "clearmap",
        },

        help = "Reset the current map.",
        notify = "{P} reset the map."
    },

    kick = {
        identifiers = {
            "kick",
        },

        help = "Kick a player from the server.",
        notify = "{P} kicked {T} for: {red %reason%}",
    },

    kickm = {
        identifiers = {
            "kickm",
            "kickmulti",
            "kickmultiple",
        },

        help = "Kick multiple players from the server.",
        notify = "{P} kicked {T} for: {red %reason%}",
    },

    ban = {
        identifiers = {
            "ban",
            "addban",
        },

        help = "Ban a player from the server.",
        notify = "{P} banned {T} for {green %duration%} with reason: {red %reason%}",
    },

    banid = {
        identifiers = {
            "banid",
            "banid64",
            "bansteamid",
            "bansteamid64",
            "addbanid",
            "addbanid64",
            "addbansteamid",
            "addbansteamid64",
        },

        help = "Ban a player by their SteamID/SteamID64.",
        notify = "{P} banned {red %target_steamid64%} for {green %duration%} with reason: {red %reason%}",
    },

    unban = {
        identifiers = {
            "unban",
            "unbanid",
            "unbanid64",
            "unbansteamid",
            "unbansteamid64",
            "removeban",
            "removebanid",
            "removebanid64",
            "removebansteamid",
            "removebansteamid64",
        },

        help = "Unban a player from the server.",
        notify = "{P} unbanned {red %target_steamid64%}",
    },

    bot = {
        identifiers = {
            "bot",
            "addbot",
            "createbot",
        },

        help = "Add a bot to the server.",
        notify = "{P} added {green %amount%} bot(s) to the server.",
    },

    help = {
        identifiers = {
            "help",
        },

        help = "Display a list of available commands or get help for a specific command.",
        no_command = "No command found with the name {red %command%}",
    }
}
