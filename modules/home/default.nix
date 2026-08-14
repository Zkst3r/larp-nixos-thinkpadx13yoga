{ pkgs, inputs, ... }:

{
  home.username    = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion  = "25.11";

  imports = [
    ./programs/alacritty.nix
    ./programs/git.nix
  ];

  home.packages = with pkgs; [
    vlc
    kdePackages.kate
    rnote
    neovim
    telegram-desktop
    firefox
    chromium
    obs-studio
    discord
    webcord-vencord
    jetbrains.pycharm
    libreoffice
    qbittorrent
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  qt.enable = true;

  xdg.configFile."niri/config.kdl".source  = ./niri/niri.kdl;
  xdg.configFile."dolphinrc".source        = ./dolphin/dolphinrc;

  programs.home-manager.enable = true;
}
