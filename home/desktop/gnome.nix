{ config, lib, pkgs, pkgs-unstable, ... }:

with lib;

let
  cfg = config.home.desktop.gnome;
in {
  options.home.desktop.gnome = {
    enable = mkEnableOption "Enables custom Gnome Shell configuration.";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {

        # Preferences
        "org/gnome/desktop/wm/preferences" = {
          focus-mode = "mouse";
        };

        "org/gnome/desktop/interface" = {
          gtk-enable-primary-paste = false;
          enable-hot-corners = false;
        };

        "org/gnome/desktop/peripherals/mouse" = {
          natural-scroll = false;
        };

        "org/gnome/system/location" = {
          enabled = false;
        };

        "org/gnome/desktop/privacy" = {
          disable-camera = true;
        };

        "system/locale" = {
          region = "fr_BE.UTF-8";
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = true;
        };

        # Keybindings
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = ["<Super><Shift>S"];
        };

        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-left = ["<Super><Control>Left"];
          switch-to-workspace-right = ["<Super><Control>Right"];
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [];
          toggle-tiled-right = [];
          maximize = [];
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          www = ["<Super>w"];
          help = [];
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Open Terminal";
          command = "alacritty";
          binding = "<Super>r";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Open Files";
          command = "nautilus --new-window";
          binding = "<Super>e";
        };

        # Extension - Forge (Tilling Window Manager)
        "org/gnome/shell/extensions/forge/keybindings" = {
          prefs-tiling-toggle = [];
          window-gap-size-decrease = [];
          window-gap-size-increase = [];

          window-focus-left = ["<Super>Left"];
          window-focus-right = ["<Super>Right"];
          window-focus-down = ["<Super>Down"];
          window-focus-up = ["<Super>Up"];

          window-resize-bottom-decrease = ["<Control><Super><Alt>Down"];
          window-resize-bottom-increase = ["<Super><Alt>Up"];
          window-resize-top-decrease = ["<Control><Super><Alt>Up"];
          window-resize-top-increase = ["<Super><Alt>Down"];
          window-resize-left-decrease = ["<Control><Super><Alt>Right"];
          window-resize-left-increase = ["<Super><Alt>Left"];
          window-resize-right-decrease = ["<Control><Super><Alt>Left"];
          window-resize-right-increase = ["<Super><Alt>Right"];

          con-stacked-layout-toggle = []; # Conflict with screenshot keybind
        };

        # Extension - Unite
        "org/gnome/shell/extensions/unite" = {
          desktop-name-text = "~";
          extend-left-box = false;
          show-desktop-name = true;
          autofocus-windows = true;
          hide-app-menu-icon = true;
          reduce-panel-spacing = false;
        };

        # Extension - Vitals
        "org/gnome/shell/extensions/vitals" = {
          position-in-panel = 0;
          menu-centered = true;
          fixed-widths = true;
          icon-style = 1;
          use-higher-precision = false;
        };
      };
    };

    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        { package = blur-my-shell; }
        { package = vitals; }
        { package = forge; }
        { package = unite; }
      ];
    };
  };
}
