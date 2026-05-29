{ pkgs, ... }:

{
  home.username = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion = "25.11";

  imports = [
    ./alacritty
  ];

  home.packages = with pkgs; [
    telegram-desktop
    firefox
  ];


  programs.git = {
    enable = true;
    settings.user.name = "kster";
    settings.user.email = "cmpfire@yanxdex.ru";
  };
  
  xdg.configFile."niri/config.kdl".source = ./niri/niri.kdl;  

  programs.home-manager.enable = true;
}
