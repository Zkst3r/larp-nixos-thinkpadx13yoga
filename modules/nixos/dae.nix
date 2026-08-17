{ pkgs, ... }:

{
  # Создать директорию для geodata
  systemd.tmpfiles.rules = [
    "d /etc/dae-wing 0755 root root -"
  ];

  # Автоматическое скачивание geodata с russia-blocked списками
  systemd.services.dae-update-geodata = {
    description = "Download dae geodata files from russia-blocked repos";

    # Запускаться после того как сеть поднялась
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      # Скачиваем файлы с проверкой
      ExecStart = pkgs.writeShellScript "download-geodata" ''
        set -euo pipefail

        echo "Downloading geoip.dat..."
        ${pkgs.curl}/bin/curl -fsSL -o /etc/dae-wing/geoip.dat \
          https://cdn.jsdelivr.net/gh/runetfreedom/russia-blocked-geoip@release/geoip.dat

        # Проверяем что файл скачался и не пустой
        if [ ! -s /etc/dae-wing/geoip.dat ]; then
          echo "ERROR: geoip.dat is empty or failed to download"
          exit 1
        fi

        echo "Downloading geosite.dat..."
        ${pkgs.curl}/bin/curl -fsSL -o /etc/dae-wing/geosite.dat \
          https://cdn.jsdelivr.net/gh/runetfreedom/russia-blocked-geosite@release/geosite.dat

        # Проверяем что файл скачался и не пустой
        if [ ! -s /etc/dae-wing/geosite.dat ]; then
          echo "ERROR: geosite.dat is empty or failed to download"
          exit 1
        fi

        echo "Geodata files updated successfully"
        echo "geoip.dat size: $(du -h /etc/dae-wing/geoip.dat | cut -f1)"
        echo "geosite.dat size: $(du -h /etc/dae-wing/geosite.dat | cut -f1)"
      '';
    };
  };

  # Автоматическое обновление каждые 6 часов
  systemd.timers.dae-update-geodata = {
    description = "Update dae geodata every 6 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 0/6:00:00";  # Каждые 6 часов: 00:00, 06:00, 12:00, 18:00
      Persistent = true;
      RandomizedDelaySec = "30m";  # Рандомная задержка до 30 мин для снижения нагрузки
    };
  };
}
