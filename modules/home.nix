{ pkgs, inputs, ... }:

{
  home.username = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion = "25.11";

  imports = [
    ./alacritty
  ];

  home.packages = with pkgs; [
    rnote
    neovim
    telegram-desktop
    firefox
    obs-studio
    discord
    webcord-vencord
    jetbrains.pycharm #rkn
    libreoffice
    qbittorrent
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
  ];

  qt = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings.user.name = "kster";
    settings.user.email = "cmpfire@yanxdex.ru";
  };
  
  xdg.configFile."niri/config.kdl".source = ./niri/niri.kdl;  
  xdg.configFile."dolphinrc".source = ./dolphin/dolphinrc;
  programs.home-manager.enable = true;
}
