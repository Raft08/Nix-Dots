{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.app.terminal.alacritty;
in {
  options.home.app.terminal.alacritty = {
    enable = mkEnableOption "Enable Alacritty's Configuration.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        live_config_reload = true;
        
        shell = {
          program = "fish";
        };

        window = {
          blur = true;
          padding = {
            x = 15;
            y = 15;
          };
        };
      };
    };
  };
}
