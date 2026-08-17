{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Core utilities
    vim wget curl git htop btop eza lolcat

    # Desktop tools
    wl-clipboard

    # File manager (Dolphin + plugins)
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.kio-extras
    kdePackages.konsole
    p7zip unrar unzip zip

    # Themes & icons
    catppuccin-sddm
    papirus-icon-theme
    adwaita-icon-theme
    hicolor-icon-theme

    # Connectivity & audio control
    blueman
    brightnessctl
    pavucontrol
    pulseaudio

    # Network & VPN
    dae
    daed
    wireguard-tools
  ];

  programs.steam.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraArgs = "-cef-disable-gpu-compositing";
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
