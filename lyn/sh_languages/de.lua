---@diagnostic disable: lowercase-global

-- You can access globals using GLOBAL variable, don't ask why.

steamid64 = "SteamID64"

-- Used as default "reason" for most commands, eg. ban, kick, mute ...etc
unspecified = "nicht angegeben"

player_role_expired = "Deine Rolle {red %role%} ist abgelaufen."

-- All Targets, You, Yourself, Everyone, Unknown, Console get prepended with a white "*"
-- This is to be easier to identify them from players that have the same name as them.
targets = {
    -- This will be used inside {P}
    you = {
        title = "Du",
        color = "#FFD700"
    },

    yourself = "Dich selbst", -- Color will be the same as "You"

    himself = "Sich selbst",  -- Color will be his role color

    -- This will be used inside {T} when the target is "*"
    -- when it prints everyone in chat, it doesn't mean literally everyone, it's everyone that the player can target.
    everyone = {
        title = "Alle",
        color = "#9900FF"
    },

    -- This will be used if {P} is not a player/Console/string
    unknown = {
        title = "Unbekannt",
        color = "#505050"
    },

    -- This will be used if {P} is the console and also used by other functions that need to refer to the console's name
    console = {
        title = "Konsole",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Unschärfe",
    Dark = "Dunkel",
    Light = "Hell",
}

banning = {
    immunity_error =
    "Du kannst den Bann dieses Spielers nicht bearbeiten, da er von jemandem mit höherer Immunität als du ausgesprochen wurde.",

    unban_immunity_error =
    "Du kannst diesen Spieler nicht entbannen, da sein Bann von jemandem mit höherer Immunität als du ausgesprochen wurde.",
    unban_no_active_ban = "Der Spieler ist derzeit nicht gebannt.",

    -- %reason% - The reason the player was banned.
    -- %banned_at% - The date and time the player was banned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %expires_at% - The date and time the player will be unbanned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %ends_in% - The time remaining until the player is unbanned. formatted as "1 hour, 10 minutes and 5 seconds"
    -- %admin_name% - The name of the admin who banned the player.
    -- %admin_steamid64% - The SteamID64 of the admin who banned the player.
    message = [[
Du wurdest von diesem Server gebannt.

- Gebannt von: %admin_name% (%admin_steamid64%)
- Grund: %reason%
- Bann-Datum: %banned_at%
- Entbann-Datum: %expires_at%
- Verbleibende Zeit: %ends_in%

Wenn du glaubst, dass dieser Bann zu Unrecht ausgesprochen wurde, wende dich bitte an das Server-Team.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Befehle",
        },
        players = {
            title = "Spieler",
            player = "Spieler",
            playtime = "Spielzeit",
            first_join = "Erster Beitritt",
            last_join = "Letzter Beitritt",
            name = "Name",
            role = "Rolle",
            copy_name = "Name kopieren",
            copy_steamid = "SteamID kopieren",
            copy_steamid64 = "SteamID64 kopieren",
            remove_role = "Rolle entfernen",
            add_role = "Rolle hinzufügen",
            hide_bots = "Bots ausblenden",
        },
        bans = {
            title = "Banns",
            player = "Spieler",
            banned_by = "Gebannt von",
            expires_in = "Läuft ab in",
            expires_at = "Läuft ab am",
            reason = "Grund",
            ban_date = "Bann-Datum",
            copy_steamid = "SteamID kopieren",
            copy_steamid64 = "SteamID64 kopieren",
            copy_admin_steamid64 = "SteamID64 des Admins kopieren",
            copy_reason = "Grund kopieren",
            unban = "Entbannen",
        },
        roles = {
            title = "Rollen",
        },
        config = {
            title = "Konfiguration",
            tabs = {
                general = "Allgemein",
                adverts = "Werbung",
                physgun = "Physgun",
                updates = "Updates",
            }
        }
    },
    search = "Suchen...",
}

extra = {
    no_tool_permission = "Du hast keine Berechtigung, das Tool {red %tool%} zu verwenden",
    no_spawn_permission = "Du hast keine {red %name%}-Berechtigung",
}

commands_core = {
    cant_use_as_console = "Du musst Spieler sein, um den Befehl {red %command%} zu benutzen.",
    no_permission = "Du hast keine Berechtigung, den Befehl {red %command%} zu benutzen.",

    -- this could happen when a db query fails, etc.
    failed_to_run =
    "Der Befehl konnte nicht ausgeführt werden. Bitte überprüfe die Server-Konsole für weitere Informationen.",

    exclusive_error = "Dieser Befehl kann nicht auf {T} ausgeführt werden – {red %reason%} ist derzeit aktiv",
    exclusive_error_targets = "Exklusiv aktiv – {T} wird übersprungen",

    arguments = {
        -- Sent when a player types an invalid argument.
        -- e.g., "Invalid steamid! (784154572)"
        -- "Invalid number! (invalidsdsds)"
        invalid = "Ungültiges %argument%! Eingabe: {red %input%}",

        -- %valid_inputs% - A list of valid inputs for the parameter. It can't be used inside a {}.
        -- %param_idx% - The index of the parameter in the command.
        -- %param_name% - The hint/name of the parameter.
        -- %input% - The input the player provided.
        restricted =
        "Parameter {blue %param_name%} #{gold %param_idx%} mit der Eingabe {red %input%} ist eingeschränkt auf: %valid_inputs%",

        cant_find_target = "Kein Spieler gefunden, der {red %target%} entspricht",
        target_not_authed = "Du kannst {T} nicht anvisieren, da er noch nicht authentifiziert ist.",
        cant_target = "Du kannst {T} nicht anvisieren.",
        cant_target_self = "Du kannst dich mit dem Befehl {red %command%} nicht selbst anvisieren.",
        cant_target_multiple = "Du kannst mit dem Befehl {red %command%} nicht mehrere Spieler anvisieren.",

        -- Triggered when trying to target a player using their entity ID, e.g.,
        -- !kick #1
        -- The invalid ID message is sent when the input is not a number.
        invalid_id = "Ungültige ID ({red %input%})!",

        player_id_not_found = "Kein Spieler mit der ID {red %input%} gefunden",

        player_steamid_not_found = "Kein Spieler mit der SteamID/SteamID64 {red %input%} gefunden",

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Mehrere Spieler gefunden: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "Keine gültigen Ziele gefunden.",

        role_does_not_exist = "Die Rolle {red %role%} existiert nicht.",
    },

    -- Hints translations are automatically used without using a # before them unlike commands' names.
    hints = {
        duration = "dauer",
        number = "zahl",
        player = "spieler",
        reason = "grund",
        steamid64 = "steamid64",
        string = "zeichenkette",

        amount = "menge",
        role = "rolle",
        immunity = "immunität",
        display_name = "anzeigename",
        color = "farbe",
        message = "nachricht",
        extends = "erweitert",
        model = "modell",
        damage = "schaden",
        permission = "berechtigung",
        map = "map",
        gamemode = "gamemode",
        command = "befehl",
        ["weapon/entity"] = "waffe/entität",
        shipment = "Lieferung",
    },
}

commands = {
    help = {
        help = "Zeigt eine Liste verfügbarer Befehle an oder zeigt Hilfe zu einem bestimmten Befehl.",
        no_command = "Kein Befehl mit dem Namen {red %command%} gefunden",
    },

    menu = {
        help = "Öffnet das Admin-Mod-Menü.",
    },

    -- Chat

    pm = {
        help = "Sende eine private Nachricht an einen Spieler.",

        to = "{gold PN} an {T}: {green %message%}",
        from = "{gold PN} von {P}: {green %message%}",
    },

    asay = {
        help = "Sende eine Nachricht in den Admin-Chat.",

        notify = "[{lightred Admins}] {P}: {green %message%}",
        notify_no_access = "{P} an {lightred Admins}: {red %message%}",
    },

    speakas = {
        help = "Sende eine Nachricht als ein anderer Spieler.",
    },

    mute = {
        help = "Stummschalten eines oder mehrerer Spieler.",
        notify = "{P} hat {T} für {D} mit dem Grund {red %reason%} stummgeschaltet",

        notify_muted = "Du bist für {D} mit dem Grund {red %reason%} stummgeschaltet"
    },

    unmute = {
        help = "Hebt das Stummschalten eines oder mehrerer Spieler auf.",
        notify = "{P} hat {T} entstummt",
    },

    gag = {
        help = "Verbiete einem oder mehreren Spielern zu sprechen.",
        notify = "{P} hat {T} für {D} mit dem Grund {red %reason%} gegaggt",
    },

    ungag = {
        help = "Hebt den Gag eines oder mehrerer Spieler auf.",
        notify = "{P} hat den Gag von {T} aufgehoben",
    },

    -- Fun Commands

    hp = {
        help = "Setze die Lebenspunkte von Spielern.",
        notify = "{P} hat die HP von {T} auf {green %amount%} gesetzt",
    },

    armor = {
        help = "Setze die Rüstung von Spielern.",
        notify = "{P} hat die Rüstung von {T} auf {green %amount%} gesetzt",
    },

    give = {
        help = "Gib einem oder mehreren Spielern eine Waffe oder Entität.",
        notify = "{P} hat {T} {green %class%} gegeben",
    },

    slap = {
        help = "Schlage Spieler und füge ihnen Schaden zu.",

        notify = "{P} hat {T} geohrfeigt",
        notify_damage = "{P} hat {T} für {green %damage%} Schaden geohrfeigt",
    },

    slay = {
        help = "Töte einen Spieler sofort.",
        notify = "{P} hat {T} getötet",
    },

    ignite = {
        help = "Zünde einen Spieler an.",
        notify = "{P} hat {T} für {D} Sekunden entzündet",
    },

    unignite = {
        help = "Lösche einen Spieler und entferne den Feuereffekt.",
        notify = "{P} hat {T} gelöscht",
    },

    god = {
        help = "Aktiviere Godmode für Spieler.",
        notify = "{P} hat Godmode für {T} aktiviert",
    },

    ungod = {
        help = "Deaktiviere Godmode für Spieler.",
        notify = "{P} hat Godmode für {T} deaktiviert",
    },

    buddha = {
        help = "Macht Spieler unsterblich, wenn ihre HP 1 ist.",
        notify = "{P} hat Buddhamodus für {T} aktiviert",
    },

    unbuddha = {
        help = "Deaktiviert Buddhamodus für Spieler.",
        notify = "{P} hat Buddhamodus für {T} deaktiviert",
    },

    freeze = {
        help = "Friert Spieler ein.",
        notify = "{P} hat {T} eingefroren",
    },

    unfreeze = {
        help = "Taut Spieler auf.",
        notify = "{P} hat {T} aufgetaut",
    },

    cloak = {
        help = "Tarne Spieler und mache sie unsichtbar.",
        notify = "{P} hat {T} getarnt",
    },

    uncloak = {
        help = "Enttarne Spieler und mache sie wieder sichtbar.",
        notify = "{P} hat {T} enttarnt",
    },

    jail = {
        help = "Inhaftiere einen oder mehrere Spieler.",
        notify = "{P} hat {T} für {D} mit dem Grund {red %reason%} inhaftiert",
    },

    unjail = {
        help = "Entlasse einen oder mehrere Spieler aus dem Gefängnis.",
        notify = "{P} hat {T} aus dem Gefängnis entlassen",
    },

    strip = {
        help = "Nimmt Spielern ihre Waffen.",
        notify = "{P} hat {T} alle Waffen entfernt",
    },

    setmodel = {
        help = "Setze das Modell von Spielern.",
        notify = "{P} hat das Modell von {T} auf {green %model%} gesetzt",
    },

    giveammo = {
        help = "Gib Spielern Munition.",
        notify = "{P} hat {T} {green %amount%} Munition gegeben",
    },

    scale = {
        help = "Skaliere Spieler auf eine bestimmte Größe.",
        notify = "{P} hat {T} auf {green %amount%} skaliert",
    },

    freezeprops = {
        help = "Friert Props in der Welt ein.",
        notify = "{P} hat alle Props eingefroren",
    },

    respawn = {
        help = "Respawne einen Spieler.",
        notify = "{P} hat {T} wiederbelebt",
    },

    -- Teleport

    bring = {
        help = "Teleportiere einen Spieler zu dir.",
        notify = "{P} hat {T} zu sich teleportiert",
    },

    ["goto"] = {
        help = "Teleportiere zu einem Spieler.",
        notify = "{P} hat sich zu {T} teleportiert",
        no_space = "{T} hat keinen Platz, um sich zu teleportieren!",
    },

    ["return"] = {
        help = "Kehre zu deiner Position vor 'goto' oder 'bring' zurück.",
        notify = "{P} hat {T} zur vorherigen Position zurückgebracht",
        no_previous_location = "Keine vorherige Position für {P} gefunden",
    },

    -- User Management Commands

    playeraddrole = {
        help = "Füge einem Spieler eine Rolle hinzu.",
        notify = "{P} hat die Rolle {green %role%} {T} für {D} gegeben",
    },

    playeraddroleid = {
        help = "Füge einem Spieler über seine SteamID/SteamID64 eine Rolle hinzu.",
        notify = "{P} hat die Rolle {green %role%} an {red %target_steamid64%} für {D} vergeben",
    },

    playerremoverole = {
        help = "Entferne eine Rolle von einem Spieler.",
        notify = "{P} hat die Rolle {red %role%} von {T} entfernt",
    },

    playerremoveroleid = {
        help = "Entferne eine Rolle von einem Spieler über seine SteamID/SteamID64.",
        notify = "{P} hat die Rolle {red %role%} von {red %target_steamid64%} entfernt",
    },

    playerextendrole = {
        help = "Verlängert die Laufzeit einer Spielerrolle.",
        notify = "{P} hat die Rolle {green %role%} für {T} um {D} verlängert",
    },

    playerextendroleid = {
        help = "Verlängert die Laufzeit einer Spielerrolle per SteamID/SteamID64.",
        notify = "{P} hat die Rolle {green %role%} für {red %target_steamid64%} um {D} verlängert",
    },

    createrole = {
        help = "Erstelle eine neue Rolle.",
        notify = "{P} hat eine neue Rolle erstellt: {green %role%}",
    },

    deleterole = {
        help = "Lösche eine Rolle.",
        notify = "{P} hat die Rolle gelöscht: {red %role%}",
    },

    renamerole = {
        help = "Benenne eine Rolle um.",
        notify = "{P} hat die Rolle {red %old_role%} in {green %new_role%} umbenannt",
    },

    setroleimmunity = {
        help = "Ändere die Immunitätsstufe einer Rolle.",
        notify = "{P} hat die Immunität von {green %role%} auf {green %immunity%} geändert",
    },

    setroledisplayname = {
        help = "Ändere den Anzeigenamen einer Rolle.",
        notify = "{P} hat den Anzeigenamen von {green %role%} auf {green %display_name%} geändert",
    },

    setrolecolor = {
        help = "Ändere die Farbe einer Rolle.",
        notify = "{P} hat die Farbe von {green %role%} auf {green %color%} geändert",
    },

    setroleextends = {
        help = "Setze oder lösche, welche Rolle diese erweitert.",

        notify_set = "{P} hat {green %role%} so gesetzt, dass sie {green %extends%} erweitert",
        notify_removed = "{P} hat die Erweiterung von {green %role%} entfernt",
    },

    roleaddpermission = {
        help = "Füge einer Rolle eine Berechtigung hinzu.",
        notify = "{P} hat die Berechtigung {green %permission%} zur Rolle {green %role%} hinzugefügt",
    },

    roleremovepermission = {
        help = "Entferne eine Berechtigung von einer Rolle.",
        notify = "{P} hat die Berechtigung {red %permission%} von der Rolle {green %role%} entfernt",
    },

    roledeletepermission = {
        help =
        "Lösche eine Berechtigung von einer Rolle. Anders als remove wird dadurch das Override entfernt, sodass Vererbung greift.",
        notify = "{P} hat die Berechtigung {red %permission%} aus der Rolle {green %role%} gelöscht",
    },

    -- Utility Commands

    map = {
        help = "Ändere die aktuelle Map und/oder den Gamemode.",

        notify = "Ein Mapwechsel wurde von {P} initiiert und wird in {D} stattfinden.",
        notify_gamemode =
        "Ein Mapwechsel wurde von {P} initiiert und wird in {D} mit dem Gamemode {green %gamemode%} stattfinden.",
    },

    maprestart = {
        help = "Starte die aktuelle Map neu.",
        notify =
        "Ein Neustart der Map wurde von {P} initiiert und wird in {D} stattfinden."
    },

    stopmaprestart = {
        help = "Stoppe den laufenden Map-Neustart.",
        notify = "Der Map-Neustart wurde von {P} gestoppt",
        no_restart = "Es gibt derzeit keinen laufenden Map-Neustart"
    },

    mapreset = {
        help = "Setze die aktuelle Map zurück.",
        notify = "{P} hat ein Map-Reset durchgeführt"
    },

    kick = {
        help = "Kicke einen Spieler vom Server.",
        notify = "{P} hat {T} mit dem Grund {red %reason%} gekickt",
    },

    kickm = {
        help = "Kicke mehrere Spieler vom Server.",
        notify = "{P} hat {T} mit dem Grund {red %reason%} gekickt",
    },

    ban = {
        help = "Banne einen Spieler vom Server.",
        notify = "{P} hat {T} für {D} mit dem Grund {red %reason%} gebannt",
    },

    banid = {
        help = "Banne einen Spieler über seine SteamID/SteamID64.",
        notify = "{P} hat {red %target_steamid64%} für {D} mit dem Grund {red %reason%} gebannt",
    },

    unban = {
        help = "Entbanne einen Spieler vom Server.",
        notify = "{P} hat {red %target_steamid64%} entbannt",
    },

    noclip = {
        help = "Schalte Noclip für einen Spieler um.",
        notify = "{P} hat Noclip für {T} umgeschaltet",
    },

    cleardecals = {
        help = "Entferne Ragdolls und Decals für alle Spieler.",
        notify = "{P} hat Ragdolls und Decals für alle Spieler entfernt.",
    },

    stopsound = {
        help = "Stoppe alle Sounds für alle Spieler.",
        notify = "{P} hat alle Sounds gestoppt",
    },

    exitvehicle = {
        help = "Zwinge einen Spieler, ein Fahrzeug zu verlassen.",

        not_in_vehicle_self = "Du bist in keinem Fahrzeug!",
        not_in_vehicle_target = "{T} ist in keinem Fahrzeug!",

        notify = "{P} hat {T} gezwungen, ein Fahrzeug zu verlassen",
    },

    bot = {
        help = "Füge dem Server einen Bot hinzu.",
        notify = "{P} hat {green %amount%} Bot(s) zum Server hinzugefügt",
    },

    time = {
        help = "Zeige die Spielzeit eines Spielers an.",
        your = "Deine Spielzeit: {D}",
        target = "Spielzeit von {T}: {D}",
    },

    -- DarkRP

    arrest = {
        help = "Spieler verhaften.",
        notify = "{P} hat {T} dauerhaft verhaftet",
        notify_duration = "{P} hat {T} für {D} verhaftet",
    },

    unarrest = {
        help = "Spieler freilassen.",
        notify = "{P} hat {T} freigelassen",
    },

    setmoney = {
        help = "Geld eines Spielers festlegen.",
        notify = "{P} hat {T}s Geld auf {green %amount%} gesetzt",
    },

    addmoney = {
        help = "Geld zu einem Spieler hinzufügen.",
        notify = "{P} hat {green %amount%} zu {T} hinzugefügt",
    },

    selldoor = {
        help = "Tür/Fahrzeug verkaufen, das du ansiehst.",
        notify = "{P} hat eine Tür/ein Fahrzeug für {T} verkauft",
        invalid = "Ungültige Tür zum Verkaufen",
        no_owner = "Diese Tür gehört niemandem",
    },

    sellall = {
        help = "Alle Türen/Fahrzeuge eines Spielers verkaufen.",
        notify = "{P} hat alle Türen/Fahrzeuge für {T} verkauft",
    },

    darkrpsetjailpos = {
        help = "Setzt alle Gefängnispositionen zurück und erstellt eine neue an deinem Standort.",
        notify = "{P} hat eine neue DarkRP-Gefängnisposition gesetzt",
    },

    darkrpaddjailpos = {
        help = "Fügt eine Gefängnisposition an deinem Standort hinzu.",
        notify = "{P} hat eine neue DarkRP-Gefängnisposition hinzugefügt",
    },

    setjob = {
        help = "Job eines Spielers ändern.",
        notify = "{P} hat {T}s Job auf {green %job%} gesetzt",
    },

    shipment = {
        help = "Eine Lieferung spawnen.",
        notify = "{P} hat {green %shipment%}-Lieferung gespawnt",
    },

    forcename = {
        help = "Namen eines Spielers erzwingen.",
        notify = "{P} hat {T}s Namen auf {green %name%} gesetzt",
        taken = "Name bereits vergeben ({red %name%})",
    },
}
