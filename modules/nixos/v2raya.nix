{ pkgs, ... }:

{
  # Включаем и настраиваем v2rayA service
  services.v2raya = {
    enable = true;
  };

  # Создать директорию для v2ray geodata
  systemd.tmpfiles.rules = [
    "d /etc/v2raya 0755 root root -"
  ];

  # Автоматическое скачивание geodata для v2ray
  systemd.services.v2raya-update-geodata = {
    description = "Download v2ray geodata files";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = pkgs.writeShellScript "download-v2ray-geodata" ''
        set -euo pipefail

        echo "Downloading geoip.dat from v2ray..."
        ${pkgs.curl}/bin/curl -fsSL -o /etc/v2raya/geoip.dat \
          https://github.com/v2fly/geoip/releases/latest/download/geoip.dat

        if [ ! -s /etc/v2raya/geoip.dat ]; then
          echo "ERROR: geoip.dat is empty or failed to download"
          exit 1
        fi

        echo "Downloading geosite.dat from v2ray..."
        ${pkgs.curl}/bin/curl -fsSL -o /etc/v2raya/geosite.dat \
          https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat

        if [ ! -s /etc/v2raya/geosite.dat ]; then
          echo "ERROR: geosite.dat is empty or failed to download"
          exit 1
        fi

        echo "Geodata files updated successfully"
        echo "geoip.dat size: $(du -h /etc/v2raya/geoip.dat | cut -f1)"
        echo "geosite.dat size: $(du -h /etc/v2raya/geosite.dat | cut -f1)"
      '';
    };
  };

  # Автоматическое обновление каждые 6 часов
  systemd.timers.v2raya-update-geodata = {
    description = "Update v2ray geodata every 6 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 0/6:00:00";
      Persistent = true;
      RandomizedDelaySec = "30m";
    };
  };
}
