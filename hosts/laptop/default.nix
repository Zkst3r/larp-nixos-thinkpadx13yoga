{ pkgs, hostname, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/performance.nix
    ../../modules/nixos/dae.nix
    inputs.minegrub-theme.nixosModules.default
  ];

  # Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader с minegrub темой
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      efiInstallAsRemovable = false;
      configurationLimit = 10;  # Показываем 10 старых поколений
      extraEntries = ''
        menuentry 'UEFI Firmware Settings' --id 'uefi-firmware' {
          fwsetup
        }
      '';
      minegrub-world-sel = {
        enable = true;
        customIcons = [
          {
            name = "nixos";
            lineTop = "NixOS Unstable";
            lineBottom = "Niri + Noctalia";
            imgName = "nixos";
          }
        ];
      };
    };
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "tun" ];

  # Network
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Security
  security.polkit.enable = true;

  # Removable media
  services.udisks2.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Virtualisation
  virtualisation.docker.enable = true;

  # Wayland / environment
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.TERMINAL = "kitty";

  # Отключить физический swap — zram достаточно
  swapDevices = [];

  system.stateVersion = "26.11";
}
