{ pkgs, ... }:

{
  home.username = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion = "25.11";

  imports = [
    ./alacritty
#    ./fuzzel
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
#  xdg.configFile."waybar".source = ./waybar;  
#  xdg.configFile."hypr/hypridle.conf".source = ./hypridle/hypridle.conf;
#  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock/hyprlock.conf;

  programs.home-manager.enable = true;
}
