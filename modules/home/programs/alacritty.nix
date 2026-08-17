{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        opacity     = 0.93;
        padding     = { x = 8; y = 8; };
      };
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size          = 13.0;
      };
      colors = {
        # Catppuccin Mocha
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        normal = {
          black   = "#45475a"; red     = "#f38ba8";
          green   = "#a6e3a1"; yellow  = "#f9e2af";
          blue    = "#89b4fa"; magenta = "#f5c2e7";
          cyan    = "#94e2d5"; white   = "#bac2de";
        };
        bright = {
          black   = "#585b70"; red     = "#f38ba8";
          green   = "#a6e3a1"; yellow  = "#f9e2af";
          blue    = "#89b4fa"; magenta = "#f5c2e7";
          cyan    = "#94e2d5"; white   = "#a6adc8";
        };
      };
    };
  };
}
