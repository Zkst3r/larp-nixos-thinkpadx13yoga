{ pkgs, inputs, ... }:

{
  home.username      = "kster";
  home.homeDirectory = "/home/kster";
  home.stateVersion  = "25.11";

  imports = [
    inputs.noctalia.homeModules.default
    ./programs/kitty.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./theme.nix
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    # Media
    vlc
    mpv
    ffmpeg
    obs-studio

    # Productivity
    kdePackages.kate
    kdePackages.okular
    rnote
    xournalpp
    obsidian
    libreoffice

    # Development
    neovim
    gh
    jetbrains.pycharm
    (python3.withPackages (ps: with ps; [ tkinter ]))

    # Browsers
    firefox
    chromium
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

    # Communication
    telegram-desktop
    #discord
    webcord-vencord

    # Other
    qbittorrent
    fastfetch
  ];

  xdg.configFile."niri/config.kdl".source        = ./niri/niri.kdl;
  xdg.configFile."dolphinrc".source              = ./dolphin/dolphinrc;
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
  xdg.configFile."fastfetch/cat.png".source      = ./fastfetch/cat.png;

  programs.home-manager.enable = true;
}
