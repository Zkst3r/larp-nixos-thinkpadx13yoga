{ ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable        = true;
    wayland.enable = true;
    theme          = "catppuccin-mocha-mauve";
  };
  services.displayManager.defaultSession = "niri";

  programs.niri.enable = true;
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    config.niri = {
      "org.freedesktop.impl.portal.ScreenCast"  = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot"  = [ "gnome" ];
    };
  };
}
