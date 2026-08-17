{ ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable         = true;
    wayland.enable = true;
    theme          = "catppuccin-mocha-mauve";
  };

  # programs.niri.enable настраивает xdg-portal, dconf, gnome-keyring автоматически
  programs.niri.enable = true;
}
