{ pkgs, hostname, ... }:

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
  ];

  # Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
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

  # Virtualisation
  virtualisation.docker.enable = true;

  # Wayland / environment
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.TERMINAL = "kitty";

  # Отключить физический swap — zram достаточно
  swapDevices = [];

  system.stateVersion = "26.11";
}
