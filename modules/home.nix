{ pkgs, ... }:

{
  home.username = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    telegram-desktop
    firefox
  ];


  programs.git = {
    enable = true;
    settings.user.name = "kster";
    settings.user.email = "cmpfire@yanxdex.ru";
  };

  xdg.configFile."niri/config.kdl".source = ./config.kdl;  
  xdg.configFile."waybar".source = ./waybar;  

  programs.home-manager.enable = true;
}
