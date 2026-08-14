{ config, pkgs, ... }:

{
  # Чёрный курсор Bibata
  home.pointerCursor = {
    enable     = true;
    name       = "Bibata-Modern-Classic";
    package    = pkgs.bibata-cursors;
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
      name    = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size    = 24;
    };
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

  # Переменные для курсора
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE  = "24";
  };
}
