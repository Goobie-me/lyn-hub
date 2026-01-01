---@diagnostic disable: lowercase-global

-- You can access globals using GLOBAL variable, don't ask why.

steamid64 = "SteamID64"

-- Used as default "reason" for most commands, eg. ban, kick, mute ...etc
unspecified = "nieokreślony"

player_role_expired = "Twoja rola {red %role%} wygasła."

-- All Targets, You, Yourself, Everyone, Unknown, Console get prepended with a white "*"
-- This is to be easier to identify them from players that have the same name as them.
targets = {
    -- This will be used inside {P}
    you = {
        title = "Ty",
        color = "#FFD700"
    },

    yourself = "Siebie", -- Color will be the same as "You"

    himself = "Siebie",  -- Color will be his role color

    -- This will be used inside {T} when the target is "*"
    -- when it prints everyone in chat, it doesn't mean literally everyone, it's everyone that the player can target.
    everyone = {
        title = "Wszystkich",
        color = "#9900FF"
    },

    -- This will be used if {P} is not a player/Console/string
    unknown = {
        title = "Nieznany",
        color = "#505050"
    },

    -- This will be used if {P} is the console and also used by other functions that need to refer to the console's name
    console = {
        title = "Konsola",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Rozmycie",
    Dark = "Ciemny",
    Light = "Jasny",
}

banning = {
    immunity_error =
    "Nie możesz zmodyfikować bana tego gracza, ponieważ został wydany przez kogoś z wyższym immunitetem niż ty.",

    unban_immunity_error =
    "Nie możesz odbanować tego gracza, ponieważ jego ban został wydany przez kogoś z wyższym immunitetem niż ty.",
    unban_no_active_ban = "Użytkownik nie jest obecnie zbanowany.",

    -- %reason% - The reason the player was banned.
    -- %banned_at% - The date and time the player was banned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %expires_at% - The date and time the player will be unbanned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %ends_in% - The time remaining until the player is unbanned. formatted as "1 hour, 10 minutes and 5 seconds"
    -- %admin_name% - The name of the admin who banned the player.
    -- %admin_steamid64% - The SteamID64 of the admin who banned the player.
    message = [[
Zostałeś zbanowany na tym serwerze.

- Zbanowany przez: %admin_name% (%admin_steamid64%)
- Powód: %reason%
- Zbanowany dnia: %banned_at%
- Data odbanowania: %expires_at%
- Pozostały czas: %ends_in%

Jeśli uważasz, że ten ban został wydany omyłkowo, skontaktuj się z administratorem.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Komendy",
        },
        players = {
            title = "Gracze",
            player = "Gracz",
            playtime = "Czas gry",
            first_join = "Pierwsza wizyta",
            last_join = "Ostatnia wizyta",
            name = "Nazwa",
            role = "Rola",
            copy_name = "Skopiuj nazwę",
            copy_steamid = "Skopiuj SteamID",
            copy_steamid64 = "Skopiuj SteamID64",
            remove_role = "Usuń rolę",
            add_role = "Dodaj rolę",
            hide_bots = "Ukryj boty",
        },
        bans = {
            title = "Bany",
            player = "Gracz",
            banned_by = "Zbanowany przez",
            expires_in = "Wygasa za",
            expires_at = "Wygasa o",
            reason = "Powód",
            ban_date = "Data banu",
            copy_steamid = "Skopiuj SteamID",
            copy_steamid64 = "Skopiuj SteamID64",
            copy_admin_steamid64 = "Skopiuj SteamID64 admina",
            copy_reason = "Skopiuj powód",
        },
        roles = {
            title = "Role",
        },
        config = {
            title = "Konfiguracja",
            tabs = {
                general = "Ogólne",
                adverts = "Ogłoszenia",
                physgun = "Physgun",
                updates = "Aktualizacje",
            }
        }
    }
}

extra = {
    no_tool_permission = "Nie masz uprawnień do używania narzędzia {red %tool%}",
}

commands_core = {
    cant_use_as_console = "Musisz być graczem, aby użyć polecenia {red %command%}.",
    no_permission = "Nie masz uprawnień do użycia polecenia {red %command%}.",

    -- this could happen when a db query fails, etc.
    failed_to_run = "Nie udało się uruchomić polecenia. Sprawdź konsolę serwera, aby uzyskać więcej informacji.",

    exclusive_error = "Nie można uruchomić tego polecenia na {T} - {red %reason%} jest aktywny",
    exclusive_error_targets = "Wyłączność aktywna - pomijanie {T}",

    arguments = {
        -- Sent when a player types an invalid argument.
        -- e.g., "Invalid steamid! (784154572)"
        -- "Invalid number! (invalidsdsds)"
        invalid = "Nieprawidłowy %argument%! Wejście: {red %input%}",

        -- %valid_inputs% - A list of valid inputs for the parameter. It can't be used inside a {}.
        -- %param_idx% - The index of the parameter in the command.
        -- %param_name% - The hint/name of the parameter.
        -- %input% - The input the player provided.
        restricted =
        "Parametr {blue %param_name%} #{gold %param_idx%}, z wejściem {red %input%}, jest ograniczony do: %valid_inputs%",

        cant_find_target = "Nie można znaleźć gracza pasującego do {red %target%}",
        target_not_authed = "Nie możesz wybrać {T}, ponieważ nie jest jeszcze uwierzytelniony.",
        cant_target = "Nie możesz wybrać {T}.",
        cant_target_self = "Nie możesz wybrać siebie za pomocą polecenia {red %command%}.",
        cant_target_multiple = "Nie możesz wybrać wielu graczy za pomocą polecenia {red %command%}.",

        -- Triggered when trying to target a player using their entity ID, e.g.,
        -- !kick #1
        -- The invalid ID message is sent when the input is not a number.
        invalid_id = "Nieprawidłowe ID ({red %input%})!",

        player_id_not_found = "Nie znaleziono gracza o ID {red %input%}",

        player_steamid_not_found = "Nie znaleziono gracza o SteamID/SteamID64 {red %input%}",

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Znaleziono wielu graczy: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "Nie znaleziono prawidłowych celów.",

        role_does_not_exist = "Rola {red %role%} nie istnieje.",
    },

    -- Hints translations are automatically used without using a # before them unlike commands' names.
    hints = {
        duration = "czas trwania",
        number = "liczba",
        player = "gracz",
        reason = "powód",
        steamid64 = "steamid64",
        string = "tekst",

        amount = "ilość",
        role = "rola",
        immunity = "immunitet",
        display_name = "nazwa wyświetlana",
        color = "kolor",
        message = "wiadomość",
        extends = "rozszerza",
        model = "model",
        damage = "obrażenia",
        permission = "permisja",
        map = "mapa",
        gamemode = "tryb gry",
        command = "polecenie",
        ["weapon/entity"] = "broń/przedmiot",
    },
}

commands = {
    help = {
        help = "Wyświetl listę dostępnych poleceń lub uzyskaj pomoc dotyczącą konkretnego polecenia.",
        no_command = "Nie znaleziono polecenia o nazwie {red %command%}",
    },

    menu = {
        help = "Otwórz menu administratora.",
    },

    -- Chat

    pm = {
        help = "Wyślij wiadomość prywatną do gracza.",

        to = "{gold PW} do {T}: {green %message%}",
        from = "{gold PW} od {P}: {green %message%}",
    },

    asay = {
        help = "Wyślij wiadomość na czat administratorów.",

        notify = "[{lightred Admini}] {P}: {green %message%}",
        notify_no_access = "{P} do {lightred Adminów}: {red %message%}",
    },

    speakas = {
        help = "Wyślij wiadomość jako inny gracz.",
    },

    mute = {
        help = "Wycisz gracza/graczy.",
        notify = "{P} wyciszył {T} na {D} z powodu {red %reason%}",

        notify_muted = "Jesteś wyciszony na {D} z powodu {red %reason%}"
    },

    unmute = {
        help = "Odcisz gracza/graczy.",
        notify = "{P} odciszył {T}",
    },

    gag = {
        help = "Zaknebluj gracza/graczy.",
        notify = "{P} zakneblował {T} na {D} z powodu {red %reason%}",
    },

    ungag = {
        help = "Odknebluj gracza/graczy.",
        notify = "{P} odkneblował {T}",
    },

    -- Fun Commands

    hp = {
        help = "Ustaw zdrowie gracza/graczy.",
        notify = "{P} ustawił HP {T} na {green %amount%}",
    },

    armor = {
        help = "Ustaw pancerz gracza/graczy.",
        notify = "{P} ustawił pancerz {T} na {green %amount%}",
    },

    give = {
        help = "Daj broń lub przedmiot graczu/graczom.",
        notify = "{P} dał {T} {green %class%}",
    },

    slap = {
        help = "Uderz gracza/graczy, powodując obrażenia.",

        notify = "{P} uderzył {T}",
        notify_damage = "{P} uderzył {T} za {green %damage%} obrażeń",
    },

    slay = {
        help = "Zabij gracza.",
        notify = "{P} zabił {T}",
    },

    ignite = {
        help = "Podpal gracza.",
        notify = "{P} zapłonął {T} na {D} sekund",
    },

    unignite = {
        help = "Ugaś gracza.",
        notify = "{P} ugasił {T}",
    },

    god = {
        help = "Włącz goda dla gracza/graczy.",
        notify = "{P} włączył goda dla {T}",
    },

    ungod = {
        help = "Wyłącz goda dla gracza/graczy.",
        notify = "{P} wyłączył goda dla {T}",
    },

    buddha = {
        help = "Sprawia, że gracz/gracze są niezniszczalni, gdy ich zdrowie wynosi 1.",
        notify = "{P} włączył tryb buddy dla {T}",
    },

    unbuddha = {
        help = "Wyłącza tryb buddy dla gracza/graczy.",
        notify = "{P} wyłączył tryb buddy dla {T}",
    },

    freeze = {
        help = "Zamroź gracza/graczy.",
        notify = "{P} zamroził {T}",
    },

    unfreeze = {
        help = "Rozmroź gracza/graczy.",
        notify = "{P} rozmroził {T}",
    },

    cloak = {
        help = "Ukryj gracza/graczy, czyniąc ich niewidzialnym.",
        notify = "{P} ukrył {T}",
    },

    uncloak = {
        help = "Odkryj gracza/graczy, czyniąc ich widocznym ponownie.",
        notify = "{P} odkrył {T}",
    },

    jail = {
        help = "Uwięź gracza/graczy.",
        notify = "{P} uwięził {T} na {D} z powodu {red %reason%}",
    },

    unjail = {
        help = "Wypuść gracza/graczy z więzienia.",
        notify = "{P} wypuścił {T} z więzienia",
    },

    strip = {
        help = "Pozbaw gracza/graczy broni.",
        notify = "{P} pozbawił {T} broni",
    },

    setmodel = {
        help = "Ustaw model gracza/graczy.",
        notify = "{P} ustawił model {T} na {green %model%}",
    },

    giveammo = {
        help = "Daj amunicję graczu/graczom.",
        notify = "{P} dał {T} {green %amount%} amunicji",
    },

    scale = {
        help = "Skaluj gracza/graczy do określonego rozmiaru.",
        notify = "{P} przeskalował {T} do {green %amount%}",
    },

    freezeprops = {
        help = "Zamroź obiekty na świecie.",
        notify = "{P} zamroził wszystkie obiekty",
    },

    respawn = {
        help = "Odrodź gracza.",
        notify = "{P} odrodził {T}",
    },

    -- Teleport

    bring = {
        help = "Teleportuj gracza do siebie.",
        notify = "{P} przywołał {T}",
    },

    ["goto"] = {
        help = "Teleportuj się do gracza.",
        notify = "{P} teleportował się do {T}",
        no_space = "{T} nie ma wystarczająco miejsca na teleportację!",
    },

    ["return"] = {
        help = "Wróć do poprzedniej lokalizacji przed użyciem 'goto' lub 'bring'.",
        notify = "{P} zwrócił {T} do poprzedniej lokalizacji",
        no_previous_location = "Nie znaleziono poprzedniej lokalizacji dla {P}",
    },

    -- User Management Commands

    playeraddrole = {
        help = "Dodaj rolę do gracza.",
        notify = "{P} dodał rolę {green %role%} do {T} na {D}",
    },

    playeraddroleid = {
        help = "Dodaj rolę do gracza po jego SteamID/SteamID64.",
        notify = "{P} dodał rolę {green %role%} do {red %target_steamid64%} na {D}",
    },

    playerremoverole = {
        help = "Usuń rolę z gracza.",
        notify = "{P} usunął rolę {red %role%} z {T}",
    },

    playerremoveroleid = {
        help = "Usuń rolę z gracza po jego SteamID/SteamID64.",
        notify = "{P} usunął rolę {red %role%} z {red %target_steamid64%}",
    },

    createrole = {
        help = "Utwórz nową rolę.",
        notify = "{P} utworzył nową rolę: {green %role%}",
    },

    deleterole = {
        help = "Usuń rolę.",
        notify = "{P} usunął rolę: {red %role%}",
    },

    renamerole = {
        help = "Zmień nazwę roli.",
        notify = "{P} zmienił nazwę roli {red %old_role%} na {green %new_role%}",
    },

    setroleimmunity = {
        help = "Zmień poziom immunitetu roli.",
        notify = "{P} zmienił immunitet {green %role%} na {green %immunity%}",
    },

    setroledisplayname = {
        help = "Zmień nazwę wyświetlaną roli.",
        notify = "{P} zmienił nazwę wyświetlaną {green %role%} na {green %display_name%}",
    },

    setrolecolor = {
        help = "Zmień kolor roli.",
        notify = "{P} zmienił kolor {green %role%} na {green %color%}",
    },

    setroleextends = {
        help = "Ustaw lub wyczyść, jaką rolę ta rozszerza.",

        notify_set = "{P} ustawił {green %role%} na rozszerzenie {green %extends%}",
        notify_removed = "{P} usunął rozszerzenie z {green %role%}",
    },

    roleaddpermission = {
        help = "Dodaj uprawnienie do roli.",
        notify = "{P} dodał uprawnienie {green %permission%} do roli {green %role%}",
    },

    roleremovepermission = {
        help = "Usuń uprawnienie z roli.",
        notify = "{P} usunął uprawnienie {red %permission%} z roli {green %role%}",
    },

    roledeletepermission = {
        help =
        "Usuń uprawnienie z roli. W przeciwieństwie do usunięcia, usuwa zastąpienie, aby miało zastosowanie dziedziczenie.",
        notify = "{P} usunął uprawnienie {red %permission%} z roli {green %role%}",
    },

    -- Utility Commands

    map = {
        help = "Zmień bieżącą mapę i/lub tryb gry.",

        notify = "Zmiana mapy została zainicjowana przez {P} i nastąpi za {D}.",
        notify_gamemode =
        "Zmiana mapy została zainicjowana przez {P} i nastąpi za {D} z trybem gry ustawionym na {green %gamemode%}.",
    },

    maprestart = {
        help = "Uruchom ponownie bieżącą mapę.",
        notify =
        "Ponowne uruchomienie mapy zostało zainicjowane przez {P} i następi za {D}."
    },

    stopmaprestart = {
        help = "Zatrzymaj bieżące ponowne uruchomienie mapy.",
        notify = "Ponowne uruchomienie mapy zostało zatrzymane przez {P}",
        no_restart = "Nie ma ponownego uruchomienia mapy w toku"
    },

    mapreset = {
        help = "Zresetuj bieżącą mapę.",
        notify = "{P} wykonał reset mapy"
    },

    kick = {
        help = "Wyrzuć gracza z serwera.",
        notify = "{P} wyrzucił {T} z powodu {red %reason%}",
    },

    kickm = {
        help = "Wyrzuć wielu graczy z serwera.",
        notify = "{P} wyrzucił {T} z powodu {red %reason%}",
    },

    ban = {
        help = "Zbanuj gracza na serwerze.",
        notify = "{P} zbanował {T} na {D} z powodu {red %reason%}",
    },

    banid = {
        help = "Zbanuj gracza po jego SteamID/SteamID64.",
        notify = "{P} zbanował {red %target_steamid64%} na {D} z powodu {red %reason%}",
    },

    unban = {
        help = "Odbanuj gracza na serwerze.",
        notify = "{P} odbanował {red %target_steamid64%}",
    },

    noclip = {
        help = "Przełącz noclip dla gracza.",
        notify = "{P} przełączył noclip dla {T}",
    },

    cleardecals = {
        help = "Wyczyść ragdoll i detale dla wszystkich graczy.",
        notify = "{P} wyczyścił ragdoll i detale dla wszystkich graczy.",
    },

    stopsound = {
        help = "Zatrzymaj wszystkie dźwięki dla wszystkich graczy.",
        notify = "{P} zatrzymał wszystkie dźwięki",
    },

    exit_vehicle = {
        help = "Wymuś wyjście gracza z pojazdu.",

        not_in_vehicle_self = "Nie jesteś w pojeździe!",
        not_in_vehicle_target = "{T} nie jest w pojeździe!",

        notify = "{P} wymusił {T} wyjście z pojazdu",
    },

    bot = {
        help = "Dodaj bota na serwer.",
        notify = "{P} dodał {green %amount%} bota(ów) na serwer",
    },

    time = {
        help = "Sprawdź czas gry gracza.",
        your = "Twój czas gry: {D}",
        target = "Czas gry {T}: {D}",
    }
}
