{ pkgs, inputs, ... }:

{
  programs.noctalia = {
    enable         = true;
    package        = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = true;
    validateConfig = true;

    settings = {
      theme = {
        mode            = "dark";
        source          = "builtin";
        builtin         = "Catppuccin";
        pure_black_dark = false;
      };

      shell = {
        font_family                     = "JetBrainsMono Nerd Font";
        corner_radius_scale             = 1.0;
        button_borders                  = true;
        input_borders                   = true;
        popup_borders                   = true;
        card_borders                    = true;
        popup_shadows                   = true;
        time_format                     = "{:%H:%M}";
        date_format                     = "%A, %x";
        external_ip_enabled             = false;
        telemetry_enabled               = false;
        setup_wizard_enabled            = false;
        polkit_agent                    = true;
        clipboard_enabled               = true;
        clipboard_history_max_entries   = 100;
        clipboard_auto_paste            = "auto";
        clipboard_confirm_clear_history = true;
        app_icon_colorize               = false;
        settings_show_advanced          = true;
        shared_gl_context               = true;

        animation = {
          enabled = true;
          speed   = 1.0;
        };

        shadow = {
          direction = "down";
          alpha     = 0.55;
        };

        panel = {
          transparency_mode              = "soft";
          borders                        = true;
          shadow                         = true;
          floating_layer                 = "overlay";
          launcher_placement             = "floating";
          clipboard_placement            = "floating";
          control_center_placement       = "floating";
          floating_offset                = 8;
          open_near_click_launcher       = true;
          open_near_click_clipboard      = true;
          open_near_click_control_center = true;
        };

        launcher = {
          categories    = true;
          show_icons    = true;
          compact       = false;
          app_grid      = false;
          sort_by_usage = true;
          pinned        = [];
        };

        screenshot = {
          save_to_file         = true;
          directory            = "~/Pictures/Screenshots";
          copy_to_clipboard    = true;
          freeze_screen        = true;
          confirm_region       = false;
          remember_last_region = true;
          show_cursor          = false;
        };

        session = {
          grid           = false;
          show_shortcuts = true;
        };
      };

      bar = {
        order = [ "main" ];

        main = {
          position           = "bottom";
          enabled            = true;
          thickness          = 48;
          margin_edge        = 0;
          margin_ends        = 0;
          padding            = 8;
          widget_spacing     = 4;
          background_opacity = 0.88;
          shadow             = false;
          border_width       = 0;
          border_radius      = 48;
          hover_highlight    = true;
          start  = [ "launcher" "clock" "sysmon" "caffeine" "active_window" ];
          center = [ "workspaces" ];
          end    = [ "tray" "notifications" "volume" "keyboard_layout" "battery" "settings" ];
        };
      };

      widget = {
        clock = {
          format = "{:%H:%M %a, %b %d}";
        };
        sysmon = {
          type          = "sysmon";
          stat          = "cpu_usage";
          visualization = "gauge";
          show_value    = true;
        };
      };

      desktop_widgets.enabled = false;
      dock.enabled            = false;
    };
  };
}
