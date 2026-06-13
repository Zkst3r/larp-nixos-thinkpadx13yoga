{ pkgs, inputs,  ... }: {
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    #system
    vim
    wget
    curl
    git    
    htop
    btop
    eza
    lolcat    

    #DE pkgs
    noctalia-shell
    alacritty
    wl-clipboard
    cliphist

    #dolphin
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.kio-extras
    p7zip
    unrar
    unzip
   

    catppuccin-sddm    
    papirus-icon-theme 
    adwaita-icon-theme
    hicolor-icon-theme    

    #laptop
    blueman
    brightnessctl
    pavucontrol
    pulseaudio
    
    #apps
    dae
    daed
    zed
    rnote
    fastfetch     
    xwayland-satellite
    
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
