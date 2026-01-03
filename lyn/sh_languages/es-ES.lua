---@diagnostic disable: lowercase-global

-- You can access globals using GLOBAL variable, don't ask why.

steamid64 = "SteamID64"

-- Used as default "reason" for most commands, eg. ban, kick, mute ...etc
unspecified = "no especificado"

player_role_expired = "Tu rol {red %role%} ha expirado."

-- All Targets, You, Yourself, Everyone, Unknown, Console get prepended with a white "*"
-- This is to be easier to identify them from players that have the same name as them.
targets = {
    -- This will be used inside {P}
    you = {
        title = "Tú",
        color = "#FFD700"
    },

    yourself = "Ti mismo", -- Color will be the same as "You"

    himself = "Sí mismo",  -- Color will be his role color

    -- This will be used inside {T} when the target is "*"
    -- when it prints everyone in chat, it doesn't mean literally everyone, it's everyone that the player can target.
    everyone = {
        title = "Todos",
        color = "#9900FF"
    },

    -- This will be used if {P} is not a player/Console/string
    unknown = {
        title = "Desconocido",
        color = "#505050"
    },

    -- This will be used if {P} is the console and also used by other functions that need to refer to the console's name
    console = {
        title = "Consola",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Difuminado",
    Dark = "Oscuro",
    Light = "Claro",
}

banning = {
    immunity_error =
    "No puedes modificar el baneo de este jugador porque fue emitido por alguien con mayor inmunidad que tú.",

    unban_immunity_error =
    "No puedes desbanear a este jugador porque su baneo fue emitido por alguien con mayor inmunidad que tú.",
    unban_no_active_ban = "El usuario no está baneado actualmente.",

    -- %reason% - The reason the player was banned.
    -- %banned_at% - The date and time the player was banned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %expires_at% - The date and time the player will be unbanned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %ends_in% - The time remaining until the player is unbanned. formatted as "1 hour, 10 minutes and 5 seconds"
    -- %admin_name% - The name of the admin who banned the player.
    -- %admin_steamid64% - The SteamID64 of the admin who banned the player.
    message = [[
Has sido baneado de este servidor.

- Baneado por: %admin_name% (%admin_steamid64%)
- Razón: %reason%
- Fecha del baneo: %banned_at%
- Fecha de desbaneo: %expires_at%
- Tiempo restante: %ends_in%

Si crees que este baneo fue un error, por favor contacta al staff del servidor.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Comandos",
        },
        players = {
            title = "Jugadores",
            player = "Jugador",
            playtime = "Tiempo jugado",
            first_join = "Primera conexión",
            last_join = "Última conexión",
            name = "Nombre",
            role = "Rol",
            copy_name = "Copiar nombre",
            copy_steamid = "Copiar SteamID",
            copy_steamid64 = "Copiar SteamID64",
            remove_role = "Quitar rol",
            add_role = "Añadir rol",
            hide_bots = "Ocultar bots",
        },
        bans = {
            title = "Baneos",
            player = "Jugador",
            banned_by = "Baneado por",
            expires_in = "Expira en",
            expires_at = "Expira el",
            reason = "Razón",
            ban_date = "Fecha del baneo",
            copy_steamid = "Copiar SteamID",
            copy_steamid64 = "Copiar SteamID64",
            copy_admin_steamid64 = "Copiar SteamID64 del admin",
            copy_reason = "Copiar razón",
        },
        roles = {
            title = "Roles",
        },
        config = {
            title = "Configuración",
            tabs = {
                general = "General",
                adverts = "Anuncios",
                physgun = "Physgun",
                updates = "Actualizaciones",
            }
        }
    }
}

extra = {
    no_tool_permission = "No tienes permiso para usar la herramienta {red %tool%}",
}

commands_core = {
    cant_use_as_console = "Debes ser un jugador para usar el comando {red %command%}.",
    no_permission = "No tienes permiso para usar el comando {red %command%}.",

    -- this could happen when a db query fails, etc.
    failed_to_run = "Error al ejecutar el comando. Por favor revisa la consola del servidor para más información.",

    exclusive_error = "No se puede ejecutar este comando en {T} - {red %reason%} está activo actualmente",
    exclusive_error_targets = "Exclusivo activo - omitiendo {T}",

    arguments = {
        -- Sent when a player types an invalid argument.
        -- e.g., "Invalid steamid! (784154572)"
        -- "Invalid number! (invalidsdsds)"
        invalid = "¡%argument% inválido! Entrada: {red %input%}",

        -- %valid_inputs% - A list of valid inputs for the parameter. It can't be used inside a {}.
        -- %param_idx% - The index of the parameter in the command.
        -- %param_name% - The hint/name of the parameter.
        -- %input% - The input the player provided.
        restricted =
        "Parámetro {blue %param_name%} #{gold %param_idx%}, con entrada {red %input%}, está restringido a: %valid_inputs%",

        cant_find_target = "No se puede encontrar un jugador que coincida con {red %target%}",
        target_not_authed = "No puedes apuntar a {T} porque aún no está autenticado.",
        cant_target = "No puedes apuntar a {T}.",
        cant_target_self = "No puedes apuntarte a ti mismo usando el comando {red %command%}.",
        cant_target_multiple = "No puedes apuntar a múltiples jugadores usando el comando {red %command%}.",

        -- Triggered when trying to target a player using their entity ID, e.g.,
        -- !kick #1
        -- The invalid ID message is sent when the input is not a number.
        invalid_id = "¡ID inválido ({red %input%})!",

        player_id_not_found = "No se encontró ningún jugador con ID {red %input%}",

        player_steamid_not_found = "No se encontró ningún jugador con SteamID/SteamID64 {red %input%}",

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Se encontraron múltiples jugadores: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "No se encontraron objetivos válidos.",

        role_does_not_exist = "El rol {red %role%} no existe.",
    },

    -- Hints translations are automatically used without using a # before them unlike commands' names.
    hints = {
        duration = "duración",
        number = "número",
        player = "jugador",
        reason = "razón",
        steamid64 = "steamid64",
        string = "texto",

        amount = "cantidad",
        role = "rol",
        immunity = "inmunidad",
        display_name = "nombre visible",
        color = "color",
        message = "mensaje",
        extends = "extiende",
        model = "modelo",
        damage = "daño",
        permission = "permiso",
        map = "mapa",
        gamemode = "modo de juego",
        command = "comando",
        ["weapon/entity"] = "arma/entidad",
        shipment = "cargamento",
    },
}

commands = {
    help = {
        help = "Muestra una lista de comandos disponibles u obtiene ayuda para un comando específico.",
        no_command = "No se encontró ningún comando con el nombre {red %command%}",
    },

    menu = {
        help = "Abre el menú de administración.",
    },

    -- Chat

    pm = {
        help = "Envía un mensaje privado a un jugador.",

        to = "{gold MP} para {T}: {green %message%}",
        from = "{gold MP} de {P}: {green %message%}",
    },

    asay = {
        help = "Envía un mensaje al chat de administradores.",

        notify = "[{lightred Admins}] {P}: {green %message%}",
        notify_no_access = "{P} a {lightred Admins}: {red %message%}",
    },

    speakas = {
        help = "Envía un mensaje como otro jugador.",
    },

    mute = {
        help = "Silencia a un jugador(es).",
        notify = "{P} silenció a {T} por {D} con razón {red %reason%}",

        notify_muted = "Estás silenciado por {D} con razón {red %reason%}"
    },

    unmute = {
        help = "Quita el silencio a un jugador(es).",
        notify = "{P} quitó el silencio a {T}",
    },

    gag = {
        help = "Amordaza a un jugador(es).",
        notify = "{P} amordazó a {T} por {D} con razón {red %reason%}",
    },

    ungag = {
        help = "Quita la mordaza a un jugador(es).",
        notify = "{P} quitó la mordaza a {T}",
    },

    -- Fun Commands

    hp = {
        help = "Establece la vida de un jugador(es).",
        notify = "{P} estableció la vida de {T} a {green %amount%}",
    },

    armor = {
        help = "Establece la armadura de un jugador(es).",
        notify = "{P} estableció la armadura de {T} a {green %amount%}",
    },

    give = {
        help = "Da un arma o entidad a un jugador(es).",
        notify = "{P} dio a {T} {green %class%}",
    },

    slap = {
        help = "Golpea a un jugador(es), causándole daño.",

        notify = "{P} golpeó a {T}",
        notify_damage = "{P} golpeó a {T} por {green %damage%} de daño",
    },

    slay = {
        help = "Mata a un jugador, causándole la muerte instantánea.",
        notify = "{P} mató a {T}",
    },

    ignite = {
        help = "Prende fuego a un jugador.",
        notify = "{P} prendió fuego a {T} por {D} segundos",
    },

    unignite = {
        help = "Apaga a un jugador, quitando el efecto de fuego.",
        notify = "{P} apagó a {T}",
    },

    god = {
        help = "Activa el modo dios para un jugador(es).",
        notify = "{P} activó el modo dios para {T}",
    },

    ungod = {
        help = "Desactiva el modo dios para un jugador(es).",
        notify = "{P} desactivó el modo dios para {T}",
    },

    buddha = {
        help = "Hace invencible a un jugador(es) cuando su vida es 1.",
        notify = "{P} activó el modo buddha para {T}",
    },

    unbuddha = {
        help = "Desactiva el modo buddha para un jugador(es).",
        notify = "{P} desactivó el modo buddha para {T}",
    },

    freeze = {
        help = "Congela a un jugador(es).",
        notify = "{P} congeló a {T}",
    },

    unfreeze = {
        help = "Descongela a un jugador(es).",
        notify = "{P} descongeló a {T}",
    },

    cloak = {
        help = "Oculta a un jugador(es), haciéndolo invisible.",
        notify = "{P} ocultó a {T}",
    },

    uncloak = {
        help = "Desoculta a un jugador(es), haciéndolo visible de nuevo.",
        notify = "{P} desocultó a {T}",
    },

    jail = {
        help = "Encarcela a un jugador(es).",
        notify = "{P} encarceló a {T} por {D} con razón {red %reason%}",
    },

    unjail = {
        help = "Libera a un jugador(es) de la cárcel.",
        notify = "{P} liberó a {T}",
    },

    strip = {
        help = "Quita las armas a un jugador(es).",
        notify = "{P} quitó las armas a {T}",
    },

    setmodel = {
        help = "Establece el modelo de un jugador(es).",
        notify = "{P} estableció el modelo de {T} a {green %model%}",
    },

    giveammo = {
        help = "Da munición a un jugador(es).",
        notify = "{P} dio a {T} {green %amount%} de munición",
    },

    scale = {
        help = "Escala a un jugador(es) a un tamaño específico.",
        notify = "{P} escaló a {T} a {green %amount%}",
    },

    freezeprops = {
        help = "Congela los props del mundo.",
        notify = "{P} congeló todos los props",
    },

    respawn = {
        help = "Reaparece a un jugador.",
        notify = "{P} reapareció a {T}",
    },

    -- Teleport

    bring = {
        help = "Teletransporta a un jugador hacia ti.",
        notify = "{P} trajo a {T}",
    },

    ["goto"] = {
        help = "Teletransportarse a un jugador.",
        notify = "{P} se teletransportó a {T}",
        no_space = "¡{T} no tiene espacio para teletransportarse!",
    },

    ["return"] = {
        help = "Vuelve a tu ubicación anterior antes de usar 'goto' o 'bring'.",
        notify = "{P} devolvió a {T} a la ubicación anterior",
        no_previous_location = "No se encontró ubicación anterior para {P}",
    },

    -- User Management Commands

    playeraddrole = {
        help = "Añade un rol a un jugador.",
        notify = "{P} añadió el rol {green %role%} a {T} por {D}",
    },

    playeraddroleid = {
        help = "Añade un rol a un jugador por su SteamID/SteamID64.",
        notify = "{P} añadió el rol {green %role%} a {red %target_steamid64%} por {D}",
    },

    playerremoverole = {
        help = "Quita un rol de un jugador.",
        notify = "{P} quitó el rol {red %role%} de {T}",
    },

    playerremoveroleid = {
        help = "Quita un rol de un jugador por su SteamID/SteamID64.",
        notify = "{P} quitó el rol {red %role%} de {red %target_steamid64%}",
    },

    createrole = {
        help = "Crea un nuevo rol.",
        notify = "{P} creó un nuevo rol: {green %role%}",
    },

    deleterole = {
        help = "Elimina un rol.",
        notify = "{P} eliminó el rol: {red %role%}",
    },

    renamerole = {
        help = "Renombra un rol.",
        notify = "{P} renombró el rol {red %old_role%} a {green %new_role%}",
    },

    setroleimmunity = {
        help = "Cambia el nivel de inmunidad de un rol.",
        notify = "{P} cambió la inmunidad de {green %role%} a {green %immunity%}",
    },

    setroledisplayname = {
        help = "Cambia el nombre visible de un rol.",
        notify = "{P} cambió el nombre visible de {green %role%} a {green %display_name%}",
    },

    setrolecolor = {
        help = "Cambia el color de un rol.",
        notify = "{P} cambió el color de {green %role%} a {green %color%}",
    },

    setroleextends = {
        help = "Establece o elimina de qué rol hereda este.",

        notify_set = "{P} estableció que {green %role%} extienda de {green %extends%}",
        notify_removed = "{P} eliminó la extensión de {green %role%}",
    },

    roleaddpermission = {
        help = "Añade un permiso a un rol.",
        notify = "{P} añadió el permiso {green %permission%} al rol {green %role%}",
    },

    roleremovepermission = {
        help = "Quita un permiso de un rol.",
        notify = "{P} quitó el permiso {red %permission%} del rol {green %role%}",
    },

    roledeletepermission = {
        help =
        "Elimina un permiso de un rol. A diferencia de quitar, elimina la anulación para que se aplique la herencia.",
        notify = "{P} eliminó el permiso {red %permission%} del rol {green %role%}",
    },

    -- Utility Commands

    map = {
        help = "Cambia el mapa actual y/o modo de juego.",

        notify = "Un cambio de mapa ha sido iniciado por {P} y ocurrirá en {D}.",
        notify_gamemode =
        "Un cambio de mapa ha sido iniciado por {P} y ocurrirá en {D} con el modo de juego establecido a {green %gamemode%}.",
    },

    maprestart = {
        help = "Reinicia el mapa actual.",
        notify =
        "Un reinicio de mapa ha sido iniciado por {P} y ocurrirá en {D}."
    },

    stopmaprestart = {
        help = "Detiene el reinicio de mapa actual.",
        notify = "El reinicio de mapa ha sido detenido por {P}",
        no_restart = "No hay ningún reinicio de mapa en progreso"
    },

    mapreset = {
        help = "Resetea el mapa actual.",
        notify = "{P} realizó un reseteo de mapa"
    },

    kick = {
        help = "Expulsa a un jugador del servidor.",
        notify = "{P} expulsó a {T} por {red %reason%}",
    },

    kickm = {
        help = "Expulsa a múltiples jugadores del servidor.",
        notify = "{P} expulsó a {T} por {red %reason%}",
    },

    ban = {
        help = "Banea a un jugador del servidor.",
        notify = "{P} baneó a {T} por {D} con razón {red %reason%}",
    },

    banid = {
        help = "Banea a un jugador por su SteamID/SteamID64.",
        notify = "{P} baneó a {red %target_steamid64%} por {D} con razón {red %reason%}",
    },

    unban = {
        help = "Desbanea a un jugador del servidor.",
        notify = "{P} desbaneó a {red %target_steamid64%}",
    },

    noclip = {
        help = "Activa/desactiva noclip para un jugador.",
        notify = "{P} activó/desactivó noclip para {T}",
    },

    cleardecals = {
        help = "Limpia ragdolls y decals para todos los jugadores.",
        notify = "{P} limpió ragdolls y decals para todos los jugadores.",
    },

    stopsound = {
        help = "Detiene todos los sonidos para todos los jugadores.",
        notify = "{P} detuvo todos los sonidos",
    },

    exit_vehicle = {
        help = "Fuerza a un jugador a salir de un vehículo.",

        not_in_vehicle_self = "¡No estás en un vehículo!",
        not_in_vehicle_target = "¡{T} no está en un vehículo!",

        notify = "{P} forzó a {T} a salir de un vehículo",
    },

    bot = {
        help = "Añade un bot al servidor.",
        notify = "{P} añadió {green %amount%} bot(s) al servidor",
    },

    time = {
        help = "Comprueba el tiempo de juego de un jugador.",
        your = "Tu tiempo de juego: {D}",
        target = "Tiempo de juego de {T}: {D}",
    },

    -- DarkRP

    arrest = {
        help = "Arresta a un jugador(es).",
        notify = "{P} arrestó a {T} permanentemente",
        notify_duration = "{P} arrestó a {T} por {D}",
    },

    unarrest = {
        help = "Libera a un jugador(es) del arresto.",
        notify = "{P} liberó a {T}",
    },

    setmoney = {
        help = "Establece el dinero de un jugador.",
        notify = "{P} estableció el dinero de {T} a {green %amount%}",
    },

    addmoney = {
        help = "Añade dinero a un jugador.",
        notify = "{P} añadió {green %amount%} a {T}",
    },

    selldoor = {
        help = "Vende la puerta/vehículo que estás mirando.",
        notify = "{P} vendió una puerta/vehículo para {T}",
        invalid = "Puerta inválida para vender",
        no_owner = "Nadie es dueño de esta puerta",
    },

    sellall = {
        help = "Vende todas las puertas/vehículos de un jugador.",
        notify = "{P} vendió todas las puertas/vehículos de {T}",
    },

    darkrpsetjailpos = {
        help = "Resetea todas las posiciones de cárcel y establece una nueva en tu ubicación.",
        notify = "{P} estableció una nueva posición de cárcel de DarkRP",
    },

    darkrpaddjailpos = {
        help = "Añade una posición de cárcel en tu ubicación actual.",
        notify = "{P} añadió una nueva posición de cárcel de DarkRP",
    },

    setjob = {
        help = "Cambia el trabajo de un jugador.",
        notify = "{P} estableció el trabajo de {T} a {green %job%}",
    },

    shipment = {
        help = "Genera un cargamento.",
        notify = "{P} generó el cargamento {green %shipment%}",
    },

    forcename = {
        help = "Fuerza el nombre de un jugador.",
        notify = "{P} estableció el nombre de {T} a {green %name%}",
        taken = "Nombre ya en uso ({red %name%})",
    },
}
