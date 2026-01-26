-- by Dahaka 76561198134120717

steamid64 = "SteamID64"

unspecified = "não especificado"

player_role_expired = "Seu cargo {red %role%} expirou."

targets = {
    you = {
        title = "Você",
        color = "#FFD700"
    },

    yourself = "Você mesmo",

    himself = "Ele mesmo",

    everyone = {
        title = "Todos",
        color = "#9900FF"
    },

    unknown = {
        title = "Desconhecido",
        color = "#505050"
    },

    console = {
        title = "Console",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Desfoque",
    Dark = "Escuro",
    Light = "Claro",
}

banning = {
    immunity_error =
    "Você não pode modificar o banimento deste jogador, pois ele foi aplicado por alguém com imunidade superior à sua.",

    unban_immunity_error =
    "Você não pode remover o banimento deste jogador, pois ele foi aplicado por alguém com imunidade superior à sua.",
    unban_no_active_ban = "Este usuário não está banido no momento.",

    message = [[
Você foi banido deste servidor.

- Banido por: %admin_name% (%admin_steamid64%)
- Motivo: %reason%
- Data do banimento: %banned_at%
- Data de remoção do banimento: %expires_at%
- Tempo restante: %ends_in%

Se você acredita que este banimento foi aplicado por engano, entre em contato com a equipe do servidor.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Comandos",
        },
        players = {
            title = "Jogadores",
            player = "Jogador",
            playtime = "Tempo de Jogo",
            first_join = "Primeira Entrada",
            last_join = "Última Entrada",
            name = "Nome",
            role = "Cargo",
            copy_name = "Copiar Nome",
            copy_steamid = "Copiar SteamID",
            copy_steamid64 = "Copiar SteamID64",
            remove_role = "Remover Cargo",
            add_role = "Adicionar Cargo",
            hide_bots = "Ocultar Bots",
        },
        bans = {
            title = "Banimentos",
            player = "Jogador",
            banned_by = "Banido por",
            expires_in = "Expira em",
            expires_at = "Expira em",
            reason = "Motivo",
            ban_date = "Data do Banimento",
            copy_steamid = "Copiar SteamID",
            copy_steamid64 = "Copiar SteamID64",
            copy_admin_steamid64 = "Copiar SteamID64 do Admin",
            copy_reason = "Copiar Motivo",
            unban = "Desbanir",
        },
        roles = {
            title = "Cargos",
        },
        config = {
            title = "Configurações",
            tabs = {
                general = "Geral",
                adverts = "Anúncios",
                physgun = "Physgun",
                updates = "Atualizações",
            }
        }
    },
    search = "Pesquisar...",
}

extra = {
    no_tool_permission = "Você não tem permissão para usar a ferramenta {red %tool%}",
    no_spawn_permission = "Você não possui a permissão {red %name%}",
}

commands_core = {
    cant_use_as_console = "Você precisa ser um jogador para usar o comando {red %command%}.",
    no_permission = "Você não tem permissão para usar o comando {red %command%}.",

    failed_to_run = "Falha ao executar o comando. Verifique o console do servidor para mais informações.",

    exclusive_error = "Não é possível executar este comando em {T} - {red %reason%} está ativo no momento",
    exclusive_error_targets = "Exclusividade ativa - ignorando {T}",

    arguments = {
        invalid = "Argumento inválido %argument%! Entrada: {red %input%}",

        restricted =
        "Parâmetro {blue %param_name%} #{gold %param_idx%}, com entrada {red %input%}, é restrito a: %valid_inputs%",

        cant_find_target = "Não foi possível encontrar um jogador correspondente a {red %target%}",
        target_not_authed = "Você não pode selecionar {T} porque ele ainda não está autenticado.",
        cant_target = "Você não pode selecionar {T}.",
        cant_target_self = "Você não pode selecionar a si mesmo usando o comando {red %command%}.",
        cant_target_multiple = "Você não pode selecionar múltiplos jogadores usando o comando {red %command%}.",

        invalid_id = "ID inválido ({red %input%})!",

        player_id_not_found = "Nenhum jogador encontrado com o ID {red %input%}",

        player_steamid_not_found = "Nenhum jogador encontrado com o SteamID/SteamID64 {red %input%}",

        multiple_players_found = "Vários jogadores encontrados: {T}",

        no_valid_targets = "Nenhum alvo válido encontrado.",

        role_does_not_exist = "O cargo {red %role%} não existe.",
    },

    hints = {
        duration = "duração",
        number = "número",
        player = "jogador",
        reason = "motivo",
        steamid64 = "steamid64",
        string = "texto",

        amount = "quantidade",
        role = "cargo",
        immunity = "imunidade",
        display_name = "nome de exibição",
        color = "cor",
        message = "mensagem",
        extends = "estende",
        model = "modelo",
        damage = "dano",
        permission = "permissão",
        map = "mapa",
        gamemode = "modo de jogo",
        command = "comando",
        ["weapon/entity"] = "arma/entidade",
        shipment = "remessa",
    },
}

commands = {
    help = {
        help = "Exibe uma lista de comandos disponíveis ou ajuda para um comando específico.",
        no_command = "Nenhum comando encontrado com o nome {red %command%}",
    },

    menu = {
        help = "Abrir o menu do mod de administração.",
    },

    pm = {
        help = "Enviar uma mensagem privada para um jogador.",

        to = "{gold PM} para {T}: {green %message%}",
        from = "{gold PM} de {P}: {green %message%}",
    },

    asay = {
        help = "Enviar uma mensagem para o chat dos administradores.",

        notify = "[{lightred Admins}] {P}: {green %message%}",
        notify_no_access = "{P} para {lightred Admins}: {red %message%}",
    },

    speakas = {
        help = "Enviar uma mensagem como outro jogador.",
    },

    mute = {
        help = "Silenciar jogador(es).",
        notify = "{P} silenciou {T} por {D} com o motivo {red %reason%}",

        notify_muted = "Você foi silenciado por {D} com o motivo {red %reason%}"
    },

    unmute = {
        help = "Remover o silêncio de jogador(es).",
        notify = "{P} removeu o silêncio de {T}",
    },

    gag = {
        help = "Aplicar gag em jogador(es).",
        notify = "{P} aplicou gag em {T} por {D} com o motivo {red %reason%}",
    },

    ungag = {
        help = "Remover gag de jogador(es).",
        notify = "{P} removeu o gag de {T}",
    },

    hp = {
        help = "Definir a vida do(s) jogador(es).",
        notify = "{P} definiu a vida de {T} para {green %amount%}",
    },

    armor = {
        help = "Definir a armadura do(s) jogador(es).",
        notify = "{P} definiu a armadura de {T} para {green %amount%}",
    },

    give = {
        help = "Dar uma arma ou entidade ao(s) jogador(es).",
        notify = "{P} deu {green %class%} para {T}",
    },

    slap = {
        help = "Dar um tapa no(s) jogador(es), causando dano.",

        notify = "{P} deu um tapa em {T}",
        notify_damage = "{P} deu um tapa em {T} causando {green %damage%} de dano",
    },

    slay = {
        help = "Matar um jogador instantaneamente.",
        notify = "{P} matou {T}",
    },

    ignite = {
        help = "Incendiar um jogador, colocando-o em chamas.",
        notify = "{P} incendiou {T} por {D} segundos",
    },

    unignite = {
        help = "Apagar o fogo de um jogador.",
        notify = "{P} apagou o fogo de {T}",
    },

    god = {
        help = "Ativar o modo deus para jogador(es).",
        notify = "{P} ativou o modo deus para {T}",
    },

    ungod = {
        help = "Desativar o modo deus para jogador(es).",
        notify = "{P} desativou o modo deus para {T}",
    },

    buddha = {
        help = "Torna o(s) jogador(es) invencível(is) quando a vida chega a 1.",
        notify = "{P} ativou o modo buddha para {T}",
    },

    unbuddha = {
        help = "Desativar o modo buddha para jogador(es).",
        notify = "{P} desativou o modo buddha para {T}",
    },

    freeze = {
        help = "Congelar jogador(es).",
        notify = "{P} congelou {T}",
    },

    unfreeze = {
        help = "Descongelar jogador(es).",
        notify = "{P} descongelou {T}",
    },

    cloak = {
        help = "Tornar jogador(es) invisível(is).",
        notify = "{P} tornou {T} invisível",
    },

    uncloak = {
        help = "Remover a invisibilidade do(s) jogador(es).",
        notify = "{P} removeu a invisibilidade de {T}",
    },

    jail = {
        help = "Prender jogador(es).",
        notify = "{P} prendeu {T} por {D} com o motivo {red %reason%}",
    },

    unjail = {
        help = "Soltar jogador(es) da prisão.",
        notify = "{P} soltou {T}",
    },

    strip = {
        help = "Remover todas as armas do(s) jogador(es).",
        notify = "{P} removeu as armas de {T}",
    },

    setmodel = {
        help = "Definir o modelo do(s) jogador(es).",
        notify = "{P} definiu o modelo de {T} para {green %model%}",
    },

    giveammo = {
        help = "Dar munição ao(s) jogador(es).",
        notify = "{P} deu {green %amount%} de munição para {T}",
    },

    scale = {
        help = "Redimensionar o(s) jogador(es) para um tamanho específico.",
        notify = "{P} redimensionou {T} para {green %amount%}",
    },

    freezeprops = {
        help = "Congelar todos os props do mapa.",
        notify = "{P} congelou todos os props",
    },

    respawn = {
        help = "Renascer um jogador.",
        notify = "{P} fez {T} renascer",
    },

    bring = {
        help = "Teleportar um jogador até você.",
        notify = "{P} trouxe {T}",
    },

    ["goto"] = {
        help = "Teleportar até um jogador.",
        notify = "{P} teleportou até {T}",
        no_space = "{T} não tem espaço para teleportar!",
    },

    ["return"] = {
        help = "Retornar para a localização anterior antes de usar 'goto' ou 'bring'.",
        notify = "{P} retornou {T} para a localização anterior",
        no_previous_location = "Nenhuma localização anterior encontrada para {P}",
    },

    playeraddrole = {
        help = "Adicionar um cargo a um jogador.",
        notify = "{P} adicionou o cargo {green %role%} a {T} por {D}",
    },

    playeraddroleid = {
        help = "Adicionar um cargo a um jogador pelo SteamID/SteamID64.",
        notify = "{P} adicionou o cargo {green %role%} a {red %target_steamid64%} por {D}",
    },

    playerremoverole = {
        help = "Remover um cargo de um jogador.",
        notify = "{P} removeu o cargo {red %role%} de {T}",
    },

    playerremoveroleid = {
        help = "Remover um cargo de um jogador pelo SteamID/SteamID64.",
        notify = "{P} removeu o cargo {red %role%} de {red %target_steamid64%}",
    },

    playerextendrole = {
        help = "Estender o tempo de expiração do cargo de um jogador.",
        notify = "{P} estendeu o cargo {green %role%} de {T} por {D}",
    },

    playerextendroleid = {
        help = "Estender o tempo de expiração do cargo de um jogador pelo SteamID/SteamID64.",
        notify = "{P} estendeu o cargo {green %role%} de {red %target_steamid64%} por {D}",
    },

    createrole = {
        help = "Criar um novo cargo.",
        notify = "{P} criou um novo cargo: {green %role%}",
    },

    deleterole = {
        help = "Excluir um cargo.",
        notify = "{P} excluiu o cargo: {red %role%}",
    },

    renamerole = {
        help = "Renomear um cargo.",
        notify = "{P} renomeou o cargo {red %old_role%} para {green %new_role%}",
    },

    setroleimmunity = {
        help = "Alterar o nível de imunidade de um cargo.",
        notify = "{P} alterou a imunidade de {green %role%} para {green %immunity%}",
    },

    setroledisplayname = {
        help = "Alterar o nome de exibição de um cargo.",
        notify = "{P} alterou o nome de exibição de {green %role%} para {green %display_name%}",
    },

    setrolecolor = {
        help = "Alterar a cor de um cargo.",
        notify = "{P} alterou a cor de {green %role%} para {green %color%}",
    },

    setroleextends = {
        help = "Definir ou remover qual cargo este estende.",

        notify_set = "{P} definiu {green %role%} para estender {green %extends%}",
        notify_removed = "{P} removeu a extensão de {green %role%}",
    },

    roleaddpermission = {
        help = "Adicionar uma permissão a um cargo.",
        notify = "{P} adicionou a permissão {green %permission%} ao cargo {green %role%}",
    },

    roleremovepermission = {
        help = "Remover uma permissão de um cargo.",
        notify = "{P} removeu a permissão {red %permission%} do cargo {green %role%}",
    },

    roledeletepermission = {
        help = "Excluir uma permissão de um cargo. Diferente de remover, isso remove a sobreposição e aplica a herança.",
        notify = "{P} excluiu a permissão {red %permission%} do cargo {green %role%}",
    },
    map = {
        help = "Alterar o mapa atual e/ou o modo de jogo.",

        notify = "Uma troca de mapa foi iniciada por {P} e ocorrerá em {D}.",
        notify_gamemode =
        "Uma troca de mapa foi iniciada por {P} e ocorrerá em {D} com o modo de jogo definido para {green %gamemode%}.",
    },

    maprestart = {
        help = "Reiniciar o mapa atual.",
        notify =
        "Uma reinicialização do mapa foi iniciada por {P} e ocorrerá em {D}."
    },

    stopmaprestart = {
        help = "Parar a reinicialização do mapa atual.",
        notify = "A reinicialização do mapa foi interrompida por {P}",
        no_restart = "Não há nenhuma reinicialização de mapa em andamento"
    },

    mapreset = {
        help = "Resetar o mapa atual.",
        notify = "{P} realizou um reset do mapa"
    },

    kick = {
        help = "Expulsar um jogador do servidor.",
        notify = "{P} expulsou {T} pelo motivo {red %reason%}",
    },

    kickm = {
        help = "Expulsar múltiplos jogadores do servidor.",
        notify = "{P} expulsou {T} pelo motivo {red %reason%}",
    },

    ban = {
        help = "Banir um jogador do servidor.",
        notify = "{P} baniu {T} por {D} com o motivo {red %reason%}",
    },

    banid = {
        help = "Banir um jogador pelo SteamID/SteamID64.",
        notify = "{P} baniu {red %target_steamid64%} por {D} com o motivo {red %reason%}",
    },

    unban = {
        help = "Remover o banimento de um jogador do servidor.",
        notify = "{P} removeu o banimento de {red %target_steamid64%}",
    },

    noclip = {
        help = "Alternar noclip para um jogador.",
        notify = "{P} alternou o noclip de {T}",
    },

    cleardecals = {
        help = "Limpar ragdolls e decals para todos os jogadores.",
        notify = "{P} limpou todos os ragdolls e decals.",
    },

    stopsound = {
        help = "Parar todos os sons para todos os jogadores.",
        notify = "{P} parou todos os sons",
    },

    exitvehicle = {
        help = "Forçar um jogador a sair de um veículo.",

        not_in_vehicle_self = "Você não está em um veículo!",
        not_in_vehicle_target = "{T} não está em um veículo!",

        notify = "{P} forçou {T} a sair de um veículo",
    },

    bot = {
        help = "Adicionar um bot ao servidor.",
        notify = "{P} adicionou {green %amount%} bot(s) ao servidor",
    },

    time = {
        help = "Verificar o tempo de jogo de um jogador.",
        your = "Seu tempo de jogo: {D}",
        target = "Tempo de jogo de {T}: {D}",
    },

    arrest = {
        help = "Prender jogador(es).",
        notify = "{P} prendeu {T} permanentemente",
        notify_duration = "{P} prendeu {T} por {D}",
    },

    unarrest = {
        help = "Soltar jogador(es) da prisão.",
        notify = "{P} soltou {T}",
    },

    setmoney = {
        help = "Definir o dinheiro de um jogador.",
        notify = "{P} definiu o dinheiro de {T} para {green %amount%}",
    },

    addmoney = {
        help = "Adicionar dinheiro a um jogador.",
        notify = "{P} adicionou {green %amount%} para {T}",
    },

    selldoor = {
        help = "Vender a porta/veículo que você está olhando.",
        notify = "{P} vendeu uma porta/veículo de {T}",
        invalid = "Porta inválida para venda",
        no_owner = "Ninguém é dono desta porta",
    },

    sellall = {
        help = "Vender todas as portas/veículos pertencentes a um jogador.",
        notify = "{P} vendeu todas as portas/veículos de {T}",
    },

    darkrpsetjailpos = {
        help = "Remove todas as posições de prisão e define uma nova na sua localização.",
        notify = "{P} definiu uma nova posição de prisão do DarkRP",
    },

    darkrpaddjailpos = {
        help = "Adicionar uma posição de prisão na sua localização atual.",
        notify = "{P} adicionou uma nova posição de prisão do DarkRP",
    },

    setjob = {
        help = "Alterar o emprego de um jogador.",
        notify = "{P} definiu o emprego de {T} para {green %job%}",
    },

    shipment = {
        help = "Spawnar uma remessa.",
        notify = "{P} spawnou a remessa {green %shipment%}",
    },

    forcename = {
        help = "Forçar o nome de um jogador.",
        notify = "{P} definiu o nome de {T} para {green %name%}",
        taken = "Nome já está em uso ({red %name%})",
    },
}
