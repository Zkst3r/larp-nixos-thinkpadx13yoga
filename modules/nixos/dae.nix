{ pkgs, ... }:

{
  # Автоматическое скачивание и обновление geodata с russia-blocked списками
  systemd.services.dae-update-geodata = {
    description = "Update dae geodata files with Russia-blocked lists";
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /etc/dae-wing";
      # Скачиваем geoip с российскими блокировками
      ExecStart = "${pkgs.curl}/bin/curl -L -o /etc/dae-wing/geoip.dat https://cdn.jsdelivr.net/gh/runetfreedom/russia-blocked-geoip@release/geoip.dat";
      # Скачиваем geosite с доменными списками
      ExecStartPost = "${pkgs.curl}/bin/curl -L -o /etc/dae-wing/geosite.dat https://cdn.jsdelivr.net/gh/runetfreedom/russia-blocked-geosite@release/geosite.dat";
    };
    # Запускаем при старте системы
    wantedBy = [ "multi-user.target" ];
  };

  # Автоматическое обновление каждые 6 часов (как в upstream)
  systemd.timers.dae-update-geodata = {
    description = "Update dae geodata every 6 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 0/6:00:00";  # Каждые 6 часов: 00:00, 06:00, 12:00, 18:00
      Persistent = true;
      RandomizedDelaySec = "30m";  # Рандомная задержка до 30 мин для снижения нагрузки
    };
  };

  # Создать директорию для geodata
  systemd.tmpfiles.rules = [
    "d /etc/dae 0755 root root -"
  ];
}

