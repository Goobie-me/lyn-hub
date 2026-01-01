---@diagnostic disable: lowercase-global

-- Vous pouvez accéder aux variables globales en utilisant la variable GLOBAL, ne demandez pas pourquoi.Retry

steamid64 = "SteamID64"

-- Utilisé comme "raison" par défaut pour la plupart des commandes, par ex. ban, kick, mute ...etc
unspecified = "non spécifié"

player_role_expired = "Votre rôle {red %role%} a expiré."

-- Tous les Targets, Vous, Vous-même, Tout le monde, Inconnu, Console sont précédés d'un "*" blanc
-- Ceci est pour les identifier plus facilement des joueurs qui ont le même nom qu'eux.
targets = {
    -- Ceci sera utilisé dans {P}
    you = {
        title = "Vous",
        color = "#FFD700"
    },

    yourself = "Vous-même", -- La couleur sera la même que "Vous"

    himself = "Lui-même",   -- La couleur sera celle de son rôle

    -- Ceci sera utilisé dans {T} lorsque la cible est "*"
    -- quand cela affiche tout le monde dans le chat, cela ne signifie pas littéralement tout le monde, c'est tout le monde que le joueur peut cibler.
    everyone = {
        title = "Tout le monde",
        color = "#9900FF"
    },

    -- Ceci sera utilisé si {P} n'est pas un joueur/Console/chaîne
    unknown = {
        title = "Inconnu",
        color = "#505050"
    },

    -- Ceci sera utilisé si {P} est la console et également utilisé par d'autres fonctions qui doivent faire référence au nom de la console
    console = {
        title = "Console",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Flou",
    Dark = "Sombre",
    Light = "Clair",
}

banning = {
    immunity_error =
    "Vous ne pouvez pas modifier le bannissement de ce joueur car il a été émis par quelqu'un avec une immunité supérieure à la vôtre.",

    unban_immunity_error =
    "Vous ne pouvez pas débannir ce joueur car son bannissement a été émis par quelqu'un avec une immunité supérieure à la vôtre.",
    unban_no_active_ban = "L'utilisateur n'est pas actuellement banni.",

    -- %reason% - La raison pour laquelle le joueur a été banni.
    -- %banned_at% - La date et l'heure auxquelles le joueur a été banni. formaté comme %d-%b-%Y %I:%M %p (par ex., 01-Jan-1970 12:00 AM)
    -- %expires_at% - La date et l'heure auxquelles le joueur sera débanni. formaté comme %d-%b-%Y %I:%M %p (par ex., 01-Jan-1970 12:00 AM)
    -- %ends_in% - Le temps restant jusqu'à ce que le joueur soit débanni. formaté comme "1 heure, 10 minutes et 5 secondes"
    -- %admin_name% - Le nom de l'administrateur qui a banni le joueur.
    -- %admin_steamid64% - Le SteamID64 de l'administrateur qui a banni le joueur.
    message = [[
Vous avez été banni de ce serveur.

- Banni par: %admin_name% (%admin_steamid64%)
- Raison: %reason%
- Date du ban: %banned_at%
- Date de déban: %expires_at%
- Temps restant: %ends_in%

Si vous pensez que ce bannissement a été émis par erreur, veuillez contacter le personnel du serveur.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Commandes",
        },
        players = {
            title = "Joueurs",
            player = "Joueur",
            playtime = "Temps de jeu",
            first_join = "Première connexion",
            last_join = "Dernière connexion",
            name = "Nom",
            role = "Rôle",
            copy_name = "Copier le nom",
            copy_steamid = "Copier SteamID",
            copy_steamid64 = "Copier SteamID64",
            remove_role = "Supprimer le rôle",
            add_role = "Ajouter un rôle",
            hide_bots = "Masquer les bots",
        },
        bans = {
            title = "Bans",
            player = "Joueur",
            banned_by = "Banni par",
            expires_in = "Expire dans",
            expires_at = "Expire le",
            reason = "Raison",
            ban_date = "Date du ban",
            copy_steamid = "Copier SteamID",
            copy_steamid64 = "Copier SteamID64",
            copy_admin_steamid64 = "Copier SteamID64 de l'admin",
            copy_reason = "Copier la raison",
        },
        roles = {
            title = "Rôles",
        },
        config = {
            title = "Configuration",
            tabs = {
                general = "Général",
                adverts = "Annonces",
                physgun = "Physgun",
                updates = "Mises à jour",
            }
        }
    }
}

extra = {
    no_tool_permission = "Vous n'avez pas la permission d'utiliser l'outil {red %tool%}",
}

commands_core = {
    cant_use_as_console = "Vous devez être un joueur pour utiliser la commande {red %command%}.",
    no_permission = "Vous n'avez pas la permission d'utiliser la commande {red %command%}.",

    -- cela peut se produire lorsqu'une requête de base de données échoue, etc.
    failed_to_run =
    "Échec de l'exécution de la commande. Veuillez vérifier la console du serveur pour plus d'informations.",

    exclusive_error = "Impossible d'exécuter cette commande sur {T} - {red %reason%} est actuellement actif",
    exclusive_error_targets = "Exclusif actif - ignoré {T}",

    arguments = {
        -- Envoyé lorsqu'un joueur tape un argument invalide.
        -- par ex., "Steamid invalide! (784154572)"
        -- "Nombre invalide! (invalidsdsds)"
        invalid = "%argument% invalide! Entrée: {red %input%}",

        -- %valid_inputs% - Une liste des entrées valides pour le paramètre. Il ne peut pas être utilisé à l'intérieur d'un {}.
        -- %param_idx% - L'index du paramètre dans la commande.
        -- %param_name% - L'indice/nom du paramètre.
        -- %input% - L'entrée fournie par le joueur.
        restricted =
        "Le paramètre {blue %param_name%} #{gold %param_idx%}, avec l'entrée {red %input%}, est limité à: %valid_inputs%",

        cant_find_target = "Impossible de trouver un joueur correspondant à {red %target%}",
        target_not_authed = "Vous ne pouvez pas cibler {T} car ils ne sont pas encore authentifiés.",
        cant_target = "Vous ne pouvez pas cibler {T}.",
        cant_target_self = "Vous ne pouvez pas vous cibler vous-même en utilisant la commande {red %command%}.",
        cant_target_multiple = "Vous ne pouvez pas cibler plusieurs joueurs en utilisant la commande {red %command%}.",

        -- Déclenché lors de la tentative de ciblage d'un joueur en utilisant son ID d'entité, par ex.,
        -- !kick #1
        -- Le message d'ID invalide est envoyé lorsque l'entrée n'est pas un nombre.
        invalid_id = "ID invalide ({red %input%})!",

        player_id_not_found = "Aucun joueur trouvé avec l'ID {red %input%}",

        player_steamid_not_found = "Aucun joueur trouvé avec le SteamID/SteamID64 {red %input%}",

        -- Envoyé lorsque la commande n'accepte qu'une seule cible mais que plusieurs correspondances sont trouvées.
        multiple_players_found = "Plusieurs joueurs trouvés: {T}",

        -- Ceci est utilisé lorsqu'il y a des joueurs mais qu'il ne peut en cibler aucun. (rôles supérieurs, pas encore authentifiés, etc.)
        no_valid_targets = "Aucune cible valide trouvée.",

        role_does_not_exist = "Le rôle {red %role%} n'existe pas.",
    },

    -- Les traductions des indices sont automatiquement utilisées sans utiliser un # avant eux contrairement aux noms des commandes.
    hints = {
        duration = "durée",
        number = "nombre",
        player = "joueur",
        reason = "raison",
        steamid64 = "steamid64",
        string = "chaîne",

        amount = "quantité",
        role = "rôle",
        immunity = "immunité",
        display_name = "nom d'affichage",
        color = "couleur",
        message = "message",
        extends = "étend",
        model = "modèle",
        damage = "dégâts",
        permission = "permission",
        map = "carte",
        gamemode = "mode de jeu",
        command = "commande",
        ["weapon/entity"] = "arme/entité",
    },
}

commands = {
    help = {
        help = "Afficher une liste des commandes disponibles ou obtenir de l'aide pour une commande spécifique.",
        no_command = "Aucune commande trouvée avec le nom {red %command%}",
    },

    menu = {
        help = "Ouvrir le menu du mod admin."
    },

    -- Chat

    pm = {
        help = "Envoyer un message privé à un joueur.",

        to = "{gold MP} à {T}: {green %message%}",
        from = "{gold MP} de {P}: {green %message%}",
    },

    asay = {
        help = "Envoyer un message au chat admin.",

        notify = "[{lightred Admins}] {P}: {green %message%}",
        notify_no_access = "{P} à {lightred Admins}: {red %message%}",
    },

    speakas = {
        help = "Envoyer un message en tant qu'un autre joueur.",
    },

    mute = {
        help = "Rendre muet un ou plusieurs joueurs.",
        notify = "{P} a rendu muet {T} pendant {D} avec la raison {red %reason%}",

        notify_muted = "Vous êtes muet pendant {D} avec la raison {red %reason%}"
    },

    unmute = {
        help = "Rendre la parole à un ou plusieurs joueurs.",
        notify = "{P} a rendu la parole à {T}",
    },

    gag = {
        help = "Bâillonner un ou plusieurs joueurs.",
        notify = "{P} a bâillonné {T} pendant {D} avec la raison {red %reason%}",
    },

    ungag = {
        help = "Débâillonner un ou plusieurs joueurs.",
        notify = "{P} a débâillonné {T}",
    },

    -- Commandes Fun

    hp = {
        help = "Définir la santé d'un ou plusieurs joueurs.",
        notify = "{P} a défini les PV de {T} à {green %amount%}",
    },

    armor = {
        help = "Définir l'armure d'un ou plusieurs joueurs.",
        notify = "{P} a défini l'armure de {T} à {green %amount%}",
    },

    give = {
        help = "Donner une arme ou une entité à un ou plusieurs joueurs.",
        notify = "{P} a donné {green %class%} à {T}",
    },

    slap = {
        help = "Gifler un ou plusieurs joueurs, leur infligeant des dégâts.",

        notify = "{P} a giflé {T}",
        notify_damage = "{P} a giflé {T} pour {green %damage%} dégâts",
    },

    slay = {
        help = "Tuer un joueur, le faisant mourir instantanément.",
        notify = "{P} a tué {T}",
    },

    ignite = {
        help = "Enflammer un joueur, le mettant en feu.",
        notify = "{P} a enflammé {T} pendant {D} secondes",
    },

    unignite = {
        help = "Éteindre un joueur, retirant l'effet de feu.",
        notify = "{P} a éteint {T}",
    },

    god = {
        help = "Activer le mode dieu pour un ou plusieurs joueurs.",
        notify = "{P} a activé le mode dieu pour {T}",
    },

    ungod = {
        help = "Désactiver le mode dieu pour un ou plusieurs joueurs.",
        notify = "{P} a désactivé le mode dieu pour {T}",
    },

    buddha = {
        help = "Rend un ou plusieurs joueurs invincibles lorsque leur santé est à 1.",
        notify = "{P} a activé le mode bouddha pour {T}",
    },

    unbuddha = {
        help = "Désactive le mode bouddha pour un ou plusieurs joueurs.",
        notify = "{P} a désactivé le mode bouddha pour {T}",
    },

    freeze = {
        help = "Geler un ou plusieurs joueurs.",
        notify = "{P} a gelé {T}",
    },

    unfreeze = {
        help = "Dégeler un ou plusieurs joueurs.",
        notify = "{P} a dégelé {T}",
    },

    cloak = {
        help = "Rendre invisible un ou plusieurs joueurs.",
        notify = "{P} a rendu invisible {T}",
    },

    uncloak = {
        help = "Rendre visible un ou plusieurs joueurs.",
        notify = "{P} a rendu visible {T}",
    },

    jail = {
        help = "Incarcérer un ou plusieurs joueurs.",
        notify = "{P} a incarcéré {T} pendant {D} avec la raison {red %reason%}",
    },

    unjail = {
        help = "Libérer un ou plusieurs joueurs de la prison.",
        notify = "{P} a libéré {T} de la prison",
    },

    strip = {
        help = "Retirer les armes d'un ou plusieurs joueurs.",
        notify = "{P} a retiré les armes de {T}",
    },

    setmodel = {
        help = "Définir le modèle d'un ou plusieurs joueurs.",
        notify = "{P} a défini le modèle de {T} à {green %model%}",
    },

    giveammo = {
        help = "Donner des munitions à un ou plusieurs joueurs.",
        notify = "{P} a donné {green %amount%} munitions à {T}",
    },

    scale = {
        help = "Redimensionner un ou plusieurs joueurs à une taille spécifique.",
        notify = "{P} a redimensionné {T} à {green %amount%}",
    },

    freezeprops = {
        help = "Geler les props dans le monde.",
        notify = "{P} a gelé tous les props",
    },

    respawn = {
        help = "Réapparaître un joueur.",
        notify = "{P} a fait réapparaître {T}",
    },

    -- Téléportation

    bring = {
        help = "Téléporter un joueur vers vous.",
        notify = "{P} a amené {T}",
    },

    ["goto"] = {
        help = "Se téléporter vers un joueur.",
        notify = "{P} s'est téléporté vers {T}",
        no_space = "{T} n'a pas assez d'espace pour se téléporter!",
    },

    ["return"] = {
        help = "Retourner à votre position précédente avant d'utiliser 'goto' ou 'bring'.",
        notify = "{P} a renvoyé {T} à la position précédente",
        no_previous_location = "Aucune position précédente trouvée pour {P}",
    },

    -- Commandes de Gestion des Utilisateurs

    playeraddrole = {
        help = "Ajouter un rôle à un joueur.",
        notify = "{P} a ajouté le rôle {green %role%} à {T} pendant {D}",
    },

    playeraddroleid = {
        help = "Ajouter un rôle à un joueur par son SteamID/SteamID64.",
        notify = "{P} a ajouté le rôle {green %role%} à {red %target_steamid64%} pendant {D}",
    },

    playerremoverole = {
        help = "Retirer un rôle d'un joueur.",
        notify = "{P} a retiré le rôle {red %role%} de {T}",
    },

    playerremoveroleid = {
        help = "Retirer un rôle d'un joueur par son SteamID/SteamID64.",
        notify = "{P} a retiré le rôle {red %role%} de {red %target_steamid64%}",
    },

    createrole = {
        help = "Créer un nouveau rôle.",
        notify = "{P} a créé un nouveau rôle: {green %role%}",
    },

    deleterole = {
        help = "Supprimer un rôle.",
        notify = "{P} a supprimé le rôle: {red %role%}",
    },

    renamerole = {
        help = "Renommer un rôle.",
        notify = "{P} a renommé le rôle {red %old_role%} en {green %new_role%}",
    },

    setroleimmunity = {
        help = "Changer le niveau d'immunité d'un rôle.",
        notify = "{P} a changé l'immunité de {green %role%} à {green %immunity%}",
    },

    setroledisplayname = {
        help = "Changer le nom d'affichage d'un rôle.",
        notify = "{P} a changé le nom d'affichage de {green %role%} en {green %display_name%}",
    },

    setrolecolor = {
        help = "Changer la couleur d'un rôle.",
        notify = "{P} a changé la couleur de {green %role%} en {green %color%}",
    },

    setroleextends = {
        help = "Définir ou effacer quel rôle celui-ci étend.",

        notify_set = "{P} a défini {green %role%} pour étendre {green %extends%}",
        notify_removed = "{P} a retiré l'extension de {green %role%}",
    },

    roleaddpermission = {
        help = "Ajouter une permission à un rôle.",
        notify = "{P} a ajouté la permission {green %permission%} au rôle {green %role%}",
    },

    roleremovepermission = {
        help = "Retirer une permission d'un rôle.",
        notify = "{P} a retiré la permission {red %permission%} du rôle {green %role%}",
    },

    roledeletepermission = {
        help =
        "Supprimer une permission d'un rôle. Contrairement à retirer, cela supprime la substitution afin que l'héritage s'applique.",
        notify = "{P} a supprimé la permission {red %permission%} du rôle {green %role%}",
    },

    -- Commandes Utilitaires

    map = {
        help = "Changer la carte actuelle et/ou le mode de jeu.",

        notify = "Un changement de carte a été initié par {P} et se produira dans {D}.",
        notify_gamemode =
        "Un changement de carte a été initié par {P} et se produira dans {D} avec le mode de jeu défini sur {green %gamemode%}.",
    },

    maprestart = {
        help = "Redémarrer la carte actuelle.",
        notify =
        "Un redémarrage de carte a été initié par {P} et se produira dans {D}."
    },

    stopmaprestart = {
        help = "Arrêter le redémarrage de carte actuel.",
        notify = "Le redémarrage de carte a été arrêté par {P}",
        no_restart = "Il n'y a pas de redémarrage de carte en cours"
    },

    mapreset = {
        help = "Réinitialiser la carte actuelle.",
        notify = "{P} a effectué une réinitialisation de carte"
    },

    kick = {
        help = "Expulser un joueur du serveur.",
        notify = "{P} a expulsé {T} pour {red %reason%}",
    },

    kickm = {
        help = "Expulser plusieurs joueurs du serveur.",
        notify = "{P} a expulsé {T} pour {red %reason%}",
    },

    ban = {
        help = "Bannir un joueur du serveur.",
        notify = "{P} a banni {T} pendant {D} avec la raison {red %reason%}",
    },

    banid = {
        help = "Bannir un joueur par son SteamID/SteamID64.",
        notify = "{P} a banni {red %target_steamid64%} pendant {D} avec la raison {red %reason%}",
    },

    unban = {
        help = "Débannir un joueur du serveur.",
        notify = "{P} a débanni {red %target_steamid64%}",
    },

    noclip = {
        help = "Activer/désactiver le noclip pour un joueur.",
        notify = "{P} a activé/désactivé le noclip pour {T}",
    },

    cleardecals = {
        help = "Nettoyer les ragdolls et décalcomanies pour tous les joueurs.",
        notify = "{P} a nettoyé les ragdolls et décalcomanies pour tous les joueurs.",
    },

    stopsound = {
        help = "Arrêter tous les sons pour tous les joueurs.",
        notify = "{P} a arrêté tous les sons",
    },

    exit_vehicle = {
        help = "Forcer un joueur à sortir d'un véhicule.",

        not_in_vehicle_self = "Vous n'êtes pas dans un véhicule!",
        not_in_vehicle_target = "{T} n'est pas dans un véhicule!",

        notify = "{P} a forcé {T} à sortir d'un véhicule",
    },

    bot = {
        help = "Ajouter un bot au serveur.",
        notify = "{P} a ajouté {green %amount%} bot(s) au serveur",
    },

    time = {
        help = "Vérifier le temps de jeu d'un joueur.",
        your = "Votre temps de jeu: {D}",
        target = "Temps de jeu de {T}: {D}",
    }
}
