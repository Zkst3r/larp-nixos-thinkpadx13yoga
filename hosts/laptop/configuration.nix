{ config, pkgs, lib,  ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./pkgs.nix
      ./laptop.nix
    ];
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # polkit
  security.polkit.enable = true;  

  # flash
  services.udisks2.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
  
  environment.variables.TERMINAL = "alacritty";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kster = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "kster";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  environment.shellAliases = {
    switch-laptop = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
  };
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };  
  
  programs.dconf.enable = true;
  services.xserver.enable = true;  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
  };

  #niri
  programs.niri.enable = true;
  services.displayManager.defaultSession = "niri";

  xdg.portal = {
    enable = true;
#    extraPortals = [ 
#      pkgs.xdg-desktop-portal-gnome
#      pkgs.xdg-desktop-portal-gtk
#    ];
    config = {
      niri = {
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];         
      };
    };
  };
  
  

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "26.05";
}
