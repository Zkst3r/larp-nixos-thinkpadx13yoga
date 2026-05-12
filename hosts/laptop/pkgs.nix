{ pkgs, inputs,  ... }: {
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    #system
    vim
    wget
    curl
    git
    findutils
    glibc
    coreutils    
    htop    

    #DE pkgs
    blueman
    waybar
    noctalia-shell
    alacritty
    swaylock
    awww
    zenity
    fuzzel
    hyprlock
    hypridle
    wl-clipboard
    cliphist
    kdePackages.dolphin

    #laptop
    brightnessctl
    pavucontrol
    pulseaudio
    
    #apps
    dae
    daed
    zed
    obs-studio
    discord
    webcord-vencord
    rnote
    jetbrains.pycharm #RKN
    libreoffice
    fastfetch     
    xwayland-satellite
    qbittorrent
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    
    (python3.withPackages (ps: with ps; [
      tkinter
    ]))
  ];

  programs.steam.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraArgs = "-cef-disable-gpu-compositing";
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
