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
          thickness          = 30;
          margin_edge        = 0;
          margin_ends        = 0;
          padding            = 6;
          widget_spacing     = 4;
          background_opacity = 0.88;
          shadow             = false;
          border_width       = 0;
          hover_highlight    = true;
          start  = [ "launcher" "clock" "caffeine" "power_profile" "privacy" "screenshot" ];
          center = [ "workspaces" ];
          end    = [ "tray" "sysmon" "volume" "battery" "network" "bluetooth" "notifications" "keyboard_layout" ];
        };
      };

      widget = {
        clock = {
          format = "{:%H:%M}";
        };
        sysmon = {
          type          = "sysmon";
          stat          = "cpu_usage";
          visualization = "graph";
          show_value    = false;
        };
      };

      weather = {
        enabled         = true;
        refresh_minutes = 30;
        unit            = "metric";
        effects         = true;
      };

      location = {
        auto_locate = false;
        address     = "Moscow";
      };

      system.monitor = {
        enabled          = true;
        cpu_poll_seconds = 2.0;
        memory_poll_seconds = 2.0;
        network_poll_seconds = 3.0;
        disk_poll_seconds = 10.0;
        gpu_poll_seconds  = 0.0;
      };

      desktop_widgets = {
        enabled      = true;
        widget_order = [ "clock_main" "weather_main" "sysmon_main" "media_main" ];

        widget = {
          clock_main = {
            type   = "clock";
            output = "";
            cx     = 107.0;
            cy     = 75.0;

            settings = {
              clock_style        = "digital";
              format             = "{:%H:%M}\n{:%e %B %Y}";
              center_text        = false;
              background         = true;
              background_opacity = 0.6;
              background_radius  = 12.0;
              background_padding = 16.0;
            };
          };

          weather_main = {
            type   = "weather";
            output = "";
            cx     = 410.0;
            cy     = 75.0;

            settings = {
              shadow             = true;
              show_forecast      = false;
              background         = true;
              background_opacity = 0.6;
              background_radius  = 12.0;
              background_padding = 16.0;
            };
          };

          sysmon_main = {
            type   = "sysmon";
            output = "";
            cx     = 130.0;
            cy     = 515.0;

            settings = {
              display    = "graph";
              stat       = "cpu_usage";
              stat2      = "cpu_temp";
              color      = "primary";
              color2     = "secondary";
              show_label = true;
              background         = true;
              background_opacity = 0.6;
              background_radius  = 12.0;
              background_padding = 12.0;
            };
          };

          media_main = {
            type   = "media_player";
            output = "";
            cx     = 185.0;
            cy     = 635.0;

            settings = {
              layout             = "horizontal";
              hide_when_no_media = false;
              shadow             = true;
              background         = true;
              background_opacity = 0.6;
              background_radius  = 12.0;
              background_padding = 12.0;
            };
          };
        };
      };

      dock = {
        enabled             = true;
        position            = "bottom";
        icon_size           = 48;
        margin_edge         = 8;
        margin_ends         = 16;
        item_spacing        = 6;
        cross_axis_padding  = 8;
        main_axis_padding   = 16;
        background_opacity  = 0.85;
        shadow              = true;
        border_width        = 1;
        border              = "outline";
        show_running        = true;
        auto_hide           = false;
        smart_auto_hide     = false;
        magnification       = true;
        magnification_scale = 1.4;
        show_dots           = true;
        launcher_position   = "none";
        pinned = [
          "firefox"
          "kitty"
          "org.kde.dolphin"
          "obsidian"
          "org.telegram.desktop"
          "discord"
        ];
      };
    };
  };
}
