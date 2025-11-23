---@diagnostic disable: lowercase-global

-- You can access globals using GLOBAL variable, don't ask why.

steamid64 = "SteamID64"

-- Used as default "reason" for most commands, eg. ban, kick, mute ...etc
unspecified = "belirtilmemiş"

player_role_expired = "Rolünüz {red %role%} süresi doldu."

-- All Targets, You, Yourself, Everyone, Unknown, Console get prepended with a white "*"
-- This is to be easier to identify them from players that have the same name as them.
targets = {
    -- This will be used inside {P}
    you = {
        title = "Sen",
        color = "#FFD700"
    },

    yourself = "Kendin", -- Color will be the same as "You"

    himself = "Kendisi", -- Color will be his role color

    -- This will be used inside {T} when the target is "*"
    -- when it prints everyone in chat, it doesn't mean literally everyone, it's everyone that the player can target.
    everyone = {
        title = "Herkes",
        color = "#9900FF"
    },

    -- This will be used if {P} is not a player/Console/string
    unknown = {
        title = "Bilinmeyen",
        color = "#505050"
    },

    -- This will be used if {P} is the console and also used by other functions that need to refer to the console's name
    console = {
        title = "Konsol",
        color = "#2E8889"
    }
}

themes = {
    Blur = "Bulanıklık",
    Dark = "Karanlık",
    Light = "Açık",
}

banning = {
    immunity_error =
    "Bu oyuncunun yasağını değiştiremezsiniz çünkü yasağı veren kişi sizden daha yüksek dokunulmazlığa sahip.",

    unban_immunity_error =
    "Bu oyuncunun yasağını kaldıramazsınız çünkü yasağı veren kişi sizden daha yüksek dokunulmazlığa sahip.",
    unban_no_active_ban = "Kullanıcı şu anda yasaklı değil.",

    -- %reason% - The reason the player was banned.
    -- %banned_at% - The date and time the player was banned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %expires_at% - The date and time the player will be unbanned. formatted as %d-%b-%Y %I:%M %p (e.g., 01-Jan-1970 12:00 AM)
    -- %ends_in% - The time remaining until the player is unbanned. formatted as "1 hour, 10 minutes and 5 seconds"
    -- %admin_name% - The name of the admin who banned the player.
    -- %admin_steamid64% - The SteamID64 of the admin who banned the player.
    message = [[
Bu sunucudan yasaklandınız.

- Yasaklayan: %admin_name% (%admin_steamid64%)
- Sebep: %reason%
- Yasaklanma Tarihi: %banned_at%
- Yasak Kalkma Tarihi: %expires_at%
- Kalan Zaman: %ends_in%

Bu yasağın hatalı olarak uygulandığını düşünüyorsanız, lütfen sunucu yetkilileri ile iletişime geçin.
]]
}

menu = {
    tabs = {
        commands = {
            title = "Komutlar",
        },
        players = {
            title = "Oyuncular",
            player = "Oyuncu",
            playtime = "Oynama Süresi",
            first_join = "İlk Katılma",
            last_join = "Son Katılma",
            name = "İsim",
            role = "Rol",
            copy_name = "İsmi Kopyala",
            copy_steamid = "SteamID'yi Kopyala",
            copy_steamid64 = "SteamID64'ü Kopyala",
            remove_role = "Rolü Sil",
            add_role = "Rol Ekle",
        },
        bans = {
            title = "Yasaklar",
            player = "Oyuncu",
            banned_by = "Yasaklayan",
            expires_in = "Kalan Süre",
            expires_at = "Bitiş Tarihi",
            reason = "Sebep",
            ban_date = "Yasaklanma Tarihi",
            copy_steamid = "SteamID'yi Kopyala",
            copy_steamid64 = "SteamID64'ü Kopyala",
            copy_admin_steamid64 = "Yöneticinin SteamID64'ünü Kopyala",
            copy_reason = "Sebebi Kopyala",
        },
        roles = {
            title = "Roller",
        },
        config = {
            title = "Yapılandırma",
            tabs = {
                general = "Genel",
                adverts = "Duyurular",
                physgun = "Fizik Silahı",
                updates = "Güncellemeler",
            }
        }
    }
}

commands_core = {
    cant_use_as_console = "{red %command%} komutunu kullanmak için oyuncu olmanız gerekir.",
    no_permission = "{red %command%} komutunu kullanma izniniz yok.",

    -- this could happen when a db query fails, etc.
    failed_to_run = "Komut çalıştırılamadı. Lütfen daha fazla bilgi için sunucu konsolunu kontrol edin.",

    exclusive_error = "Bu komut {T} üzerinde çalıştırılamaz - {red %reason%} şu anda aktif",
    exclusive_error_targets = "Özel aktif - {T} atlanıyor",

    arguments = {
        -- Sent when a player types an invalid argument.
        -- e.g., "Invalid steamid! (784154572)"
        -- "Invalid number! (invalidsdsds)"
        invalid = "Geçersiz %argument%! Girdi: {red %input%}",

        -- %valid_inputs% - A list of valid inputs for the parameter. It can't be used inside a {}.
        -- %param_idx% - The index of the parameter in the command.
        -- %param_name% - The hint/name of the parameter.
        -- %input% - The input the player provided.
        restricted =
        "Parametre {blue %param_name%} #{gold %param_idx%}, {red %input%} girdisi ile, şunlarla sınırlıdır: %valid_inputs%",

        cant_find_target = "{red %target%} ile eşleşen bir oyuncu bulunamadı",
        target_not_authed = "{T} hedef alınamaz çünkü henüz kimlik doğrulaması yapılmamış.",
        cant_target = "{T} hedef alınamaz.",
        cant_target_self = "{red %command%} komutunu kullanarak kendinizi hedef alamazsınız.",
        cant_target_multiple = "{red %command%} komutunu kullanarak birden fazla oyuncuyu hedef alamazsınız.",

        -- Triggered when trying to target a player using their entity ID, e.g.,
        -- !kick #1
        -- The invalid ID message is sent when the input is not a number.
        invalid_id = "Geçersiz ID ({red %input%})!",

        player_id_not_found = "{red %input%} ID'sine sahip oyuncu bulunamadı",

        player_steamid_not_found = "{red %input%} SteamID/SteamID64'üne sahip oyuncu bulunamadı",

        -- Sent when the command only accepts a single target but multiple matches are found.
        multiple_players_found = "Birden fazla oyuncu bulundu: {T}",

        -- This is used when there are players but he can't target any of them. (higher roles, not-authed yet, etc.)
        no_valid_targets = "Geçerli hedef bulunamadı.",

        role_does_not_exist = "{red %role%} rolü mevcut değil.",
    },

    -- Hints translations are automatically used without using a # before them unlike commands' names.
    hints = {
        duration = "süre",
        number = "sayı",
        player = "oyuncu",
        reason = "sebep",
        steamid64 = "steamid64",
        string = "metin",

        amount = "miktar",
        role = "rol",
        immunity = "dokunulmazlık",
        display_name = "görünen isim",
        color = "renk",
        message = "mesaj",
        extends = "genişletir",
        model = "model",
        damage = "hasar",
        permission = "izin",
        map = "harita",
        gamemode = "oyun modu",
        command = "komut",
        ["weapon/entity"] = "silah/varlık",
    },
}

commands = {
    help = {
        help = "Kullanılabilir komutların listesini görüntüle veya belirli bir komut için yardım al.",
        no_command = "{red %command%} isimli komut bulunamadı",
    },

    menu = {
        help = "Yönetici menüsünü aç.",
    },

    -- Chat

    pm = {
        help = "Bir oyuncuya özel mesaj gönder.",

        to = "{gold ÖM} {T} için: {green %message%}",
        from = "{gold ÖM} {P} gönderen: {green %message%}",
    },

    asay = {
        help = "Yönetici sohbetine mesaj gönder.",

        notify = "[{lightred Yöneticiler}] {P}: {green %message%}",
        notify_no_access = "{P} {lightred Yöneticiler} için: {red %message%}",
    },

    speakas = {
        help = "Başka bir oyuncu olarak mesaj gönder.",
    },

    mute = {
        help = "Bir oyuncuyu/oyuncuları sessize al.",
        notify = "{P}, {T} oyuncusunu {D} süreyle {red %reason%} sebebiyle sessize aldı",

        notify_muted = "{D} süreyle {red %reason%} sebebiyle sessize alındınız"
    },

    unmute = {
        help = "Bir oyuncunun/oyuncuların sesini aç.",
        notify = "{P}, {T} oyuncusunun sesini açtı",
    },

    gag = {
        help = "Bir oyuncuyu/oyuncuları engelle.",
        notify = "{P}, {T} oyuncusunu {D} süreyle {red %reason%} sebebiyle engelledi",
    },

    ungag = {
        help = "Bir oyuncunun/oyuncuların engelini kaldır.",
        notify = "{P}, {T} oyuncusunun engelini kaldırdı",
    },

    -- Fun Commands

    hp = {
        help = "Oyuncu(ların) canını ayarla.",
        notify = "{P}, {T} oyuncusunun canını {green %amount%} olarak ayarladı",
    },

    armor = {
        help = "Oyuncu(ların) zırhını ayarla.",
        notify = "{P}, {T} oyuncusunun zırhını {green %amount%} olarak ayarladı",
    },

    give = {
        help = "Oyuncu(lara) bir silah veya varlık ver.",
        notify = "{P}, {T} oyuncusuna {green %class%} verdi",
    },

    slap = {
        help = "Bir oyuncuya/oyunculara tokat at ve hasar ver.",

        notify = "{P}, {T} oyuncusuna tokat attı",
        notify_damage = "{P}, {T} oyuncusuna {green %damage%} hasar vererek tokat attı",
    },

    slay = {
        help = "Bir oyuncuyu öldür.",
        notify = "{P}, {T} oyuncusunu öldürdü",
    },

    ignite = {
        help = "Bir oyuncuyu ateşe ver.",
        notify = "{P}, {T} oyuncusunu {D} saniye boyunca ateşe verdi",
    },

    unignite = {
        help = "Bir oyuncunun üzerindeki ateşi söndür.",
        notify = "{P}, {T} oyuncusunun üzerindeki ateşi söndürdü",
    },

    god = {
        help = "Oyuncu(lar) için tanrı modunu etkinleştir.",
        notify = "{P}, {T} için tanrı modunu etkinleştirdi",
    },

    ungod = {
        help = "Oyuncu(lar) için tanrı modunu devre dışı bırak.",
        notify = "{P}, {T} için tanrı modunu devre dışı bıraktı",
    },

    buddha = {
        help = "Oyuncu(ları) canları 1 olduğunda ölmez yap.",
        notify = "{P}, {T} için buddha modunu etkinleştirdi",
    },

    unbuddha = {
        help = "Oyuncu(lar) için buddha modunu devre dışı bırak.",
        notify = "{P}, {T} için buddha modunu devre dışı bıraktı",
    },

    freeze = {
        help = "Oyuncu(ları) dondur.",
        notify = "{P}, {T} oyuncusunu dondurdu",
    },

    unfreeze = {
        help = "Oyuncu(ların) donmasını çöz.",
        notify = "{P}, {T} oyuncusunun donmasını çözdü",
    },

    cloak = {
        help = "Oyuncu(ları) görünmez yap.",
        notify = "{P}, {T} oyuncusunu görünmez yaptı",
    },

    uncloak = {
        help = "Oyuncu(ları) tekrar görünür yap.",
        notify = "{P}, {T} oyuncusunu tekrar görünür yaptı",
    },

    strip = {
        help = "Oyuncu(ların) silahlarını al.",
        notify = "{P}, {T} oyuncusunun silahlarını aldı",
    },

    setmodel = {
        help = "Oyuncu(ların) modelini ayarla.",
        notify = "{P}, {T} oyuncusunun modelini {green %model%} olarak ayarladı",
    },

    giveammo = {
        help = "Oyuncu(lara) cephane ver.",
        notify = "{P}, {T} oyuncusuna {green %amount%} cephane verdi",
    },

    scale = {
        help = "Oyuncu(ları) belirli bir boyuta ölçeklendir.",
        notify = "{P}, {T} oyuncusunu {green %amount%} boyutuna ölçeklendirdi",
    },

    freezeprops = {
        help = "Dünyadaki objeleri dondur.",
        notify = "{P} tüm objeleri dondurdu",
    },

    jail = {
        help = "Oyuncu(yu/ları) hapse at.",
        notify = "{P}, {T} oyuncusunu hapse attı",
    },

    unjail = {
        help = "Oyuncu(ların) hapisten çıkmasını sağla.",
        notify = "{P}, {T} oyuncusunu hapisten çıkardı",
    },

    respawn = {
        help = "Bir oyuncuyu yeniden canlandır.",
        notify = "{P}, {T} oyuncusunu yeniden canlandırdı",
    },

    -- Teleport

    bring = {
        help = "Bir oyuncuyu yanına ışınla.",
        notify = "{P}, {T} oyuncusunu yanına ışınladı",
    },

    ["goto"] = {
        help = "Bir oyuncuya ışınlan.",
        notify = "{P}, {T} oyuncusuna ışınlandı",
        no_space = "{T} ışınlanmak için yeterli alana sahip değil!",
    },

    ["return"] = {
        help = "'goto' veya 'bring' kullanmadan önceki konumuna geri dön.",
        notify = "{P}, {T} oyuncusunu önceki konumuna geri gönderdi",
        no_previous_location = "{P} için önceki konum bulunamadı",
    },

    -- User Management Commands

    playeraddrole = {
        help = "Bir oyuncuya rol ekle.",
        notify = "{P}, {T} oyuncusuna {D} süreyle {green %role%} rolünü ekledi",
    },

    playeraddroleid = {
        help = "SteamID/SteamID64 ile bir oyuncuya rol ekle.",
        notify = "{P}, {red %target_steamid64%} oyuncusuna {D} süreyle {green %role%} rolünü ekledi",
    },

    playerremoverole = {
        help = "Bir oyuncudan rol kaldır.",
        notify = "{P}, {T} oyuncusundan {red %role%} rolünü kaldırdı",
    },

    playerremoveroleid = {
        help = "SteamID/SteamID64 ile bir oyuncudan rol kaldır.",
        notify = "{P}, {red %target_steamid64%} oyuncusundan {red %role%} rolünü kaldırdı",
    },

    createrole = {
        help = "Yeni bir rol oluştur.",
        notify = "{P} yeni bir rol oluşturdu: {green %role%}",
    },

    deleterole = {
        help = "Bir rolü sil.",
        notify = "{P} rolü sildi: {red %role%}",
    },

    renamerole = {
        help = "Bir rolü yeniden adlandır.",
        notify = "{P}, {red %old_role%} rolünü {green %new_role%} olarak yeniden adlandırdı",
    },

    setroleimmunity = {
        help = "Bir rolün dokunulmazlık seviyesini değiştir.",
        notify = "{P}, {green %role%} rolünün dokunulmazlığını {green %immunity%} olarak değiştirdi",
    },

    setroledisplayname = {
        help = "Bir rolün görünen adını değiştir.",
        notify = "{P}, {green %role%} rolünün görünen adını {green %display_name%} olarak değiştirdi",
    },

    setrolecolor = {
        help = "Bir rolün rengini değiştir.",
        notify = "{P}, {green %role%} rolünün rengini {green %color%} olarak değiştirdi",
    },

    setroleextends = {
        help = "Bu rolün hangi rolü genişlettiğini ayarla veya temizle.",

        notify_set = "{P}, {green %role%} rolünü {green %extends%} rolünü genişletecek şekilde ayarladı",
        notify_removed = "{P}, {green %role%} rolünden genişletmeyi kaldırdı",
    },

    roleaddpermission = {
        help = "Bir role izin ekle.",
        notify = "{P}, {green %role%} rolüne {green %permission%} iznini ekledi",
    },

    roleremovepermission = {
        help = "Bir rolden izin kaldır.",
        notify = "{P}, {green %role%} rolünden {red %permission%} iznini kaldırdı",
    },

    roledeletepermission = {
        help = "Bir rolden izni sil. Kaldırmadan farklı olarak, geçersiz kılmayı kaldırır böylece kalıtım geçerli olur.",
        notify = "{P}, {green %role%} rolünden {red %permission%} iznini sildi",
    },

    -- Utility Commands

    map = {
        help = "Mevcut haritayı ve/veya oyun modunu değiştir.",

        notify = "{P} tarafından harita değişikliği başlatıldı ve {D} içinde gerçekleşecek.",
        notify_gamemode =
        "{P} tarafından harita değişikliği başlatıldı ve {D} içinde {green %gamemode%} oyun moduyla gerçekleşecek.",
    },

    maprestart = {
        help = "Mevcut haritayı yeniden başlat.",
        notify =
        "{P} tarafından harita yeniden başlatması başlatıldı ve {D} içinde gerçekleşecek."
    },

    stopmaprestart = {
        help = "Mevcut harita yeniden başlatmasını durdur.",
        notify = "{P} tarafından harita yeniden başlatması durduruldu",
        no_restart = "Devam eden harita yeniden başlatması yok"
    },

    mapreset = {
        help = "Mevcut haritayı sıfırla.",
        notify = "{P} harita sıfırlama gerçekleştirdi"
    },

    kick = {
        help = "Bir oyuncuyu sunucudan at.",
        notify = "{P}, {T} oyuncusunu {red %reason%} sebebiyle attı",
    },

    kickm = {
        help = "Birden fazla oyuncuyu sunucudan at.",
        notify = "{P}, {T} oyuncularını {red %reason%} sebebiyle attı",
    },

    ban = {
        help = "Bir oyuncuyu sunucudan yasakla.",
        notify = "{P}, {T} oyuncusunu {D} süreyle {red %reason%} sebebiyle yasakladı",
    },

    banid = {
        help = "SteamID/SteamID64 ile bir oyuncuyu yasakla.",
        notify = "{P}, {red %target_steamid64%} oyuncusunu {D} süreyle {red %reason%} sebebiyle yasakladı",
    },

    unban = {
        help = "Bir oyuncunun sunucudan yasaklamasını kaldır.",
        notify = "{P}, {red %target_steamid64%} oyuncusunun yasağını kaldırdı",
    },

    noclip = {
        help = "Bir oyuncu için noclip'i aç/kapat.",
        notify = "{P}, {T} için noclip'i açtı",
    },

    cleardecals = {
        help = "Tüm oyuncular için ragdoll'ları ve çıkartmaları temizle.",
        notify = "{P} tüm oyuncular için ragdoll'ları ve çıkartmaları temizledi.",
    },

    stopsound = {
        help = "Tüm oyuncular için tüm sesleri durdur.",
        notify = "{P} tüm sesleri durdurdu",
    },

    exit_vehicle = {
        help = "Bir oyuncuyu araçtan zorla çıkar.",

        not_in_vehicle_self = "Araçta değilsin!",
        not_in_vehicle_target = "{T} araçta değil!",

        notify = "{P}, {T} oyuncusunu araçtan zorla çıkardı",
    },

    bot = {
        help = "Sunucuya bir bot ekle.",
        notify = "{P} sunucuya {green %amount%} bot ekledi",
    },

    time = {
        help = "Bir oyuncunun oynama süresini kontrol et.",
        your = "Oynama süreniz: {D}",
        target = "{T} oynama süresi: {D}",
    }
}
