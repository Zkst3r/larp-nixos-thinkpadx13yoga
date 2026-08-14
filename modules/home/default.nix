{ pkgs, inputs, ... }:

{
  home.username      = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion  = "25.11";

  imports = [
    ./programs/alacritty.nix
    ./programs/git.nix
  ];

  home.packages = with pkgs; [
    # Media
    vlc
    obs-studio

    # Productivity
    kdePackages.kate
    rnote
    libreoffice

    # Development
    neovim
    jetbrains.pycharm
    (python3.withPackages (ps: with ps; [ tkinter ]))

    # Browsers
    firefox
    chromium
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

    # Communication
    telegram-desktop
    discord
    webcord-vencord

    # Other
    qbittorrent
    fastfetch
  ];

  qt.enable = true;

  xdg.configFile."niri/config.kdl".source = ./niri/niri.kdl;
  xdg.configFile."dolphinrc".source       = ./dolphin/dolphinrc;

  programs.home-manager.enable = true;
}
