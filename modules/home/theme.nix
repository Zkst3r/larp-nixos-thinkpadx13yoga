{ config, pkgs, ... }:

{
  # Единый курсор для Wayland и XWayland
  home.pointerCursor = {
    enable     = true;
    name       = "catppuccin-mocha-mauve-cursors";
    package    = pkgs.catppuccin-cursors.mochaMauve;
    size       = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # GTK тема
  gtk = {
    enable = true;
    theme = {
      name    = "catppuccin-mocha-mauve-standard+default";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name    = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size    = 24;
    };
    # Явно задаём GTK4 тему чтобы не было предупреждения о смене дефолта
    gtk4.theme = config.gtk.theme;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Qt следует за GTK
  qt = {
    enable             = true;
    platformTheme.name = "gtk3";
    style.name         = "adwaita-dark";
  };

  # Переменные для курсора — фикс разного размера в Wayland/XWayland
  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    XCURSOR_SIZE  = "24";
  };
}
