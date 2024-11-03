{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules
      ./../../users
    ];
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Kernel Stuff
  module.kernel = {
    unstable = true;
    nvidia = {
      enable = true;
      open = false;
      settings = false;
    };
  };

  # No Password for sudo, safe for desktop.
  security.sudo.wheelNeedsPassword = false;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "Raft-Desktop"; 
  networking.firewall.enable = false; # Fuck the firewall
  networking.networkmanager.enable = true;

  # Apps
  module.app.gaming.steam.enable = true;
  module.app.virtualisation.boxes.enable = true;

  # Forced Apps - Temporary
  environment.systemPackages = with pkgs; [
    alacritty
    vesktop

    vscode
    postman

    spotify
  ];


  ## NEEDS TO BE PLACED IN PROPER CONFIG.

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_BE.UTF-8";
    LC_IDENTIFICATION = "fr_BE.UTF-8";
    LC_MEASUREMENT = "fr_BE.UTF-8";
    LC_MONETARY = "fr_BE.UTF-8";
    LC_NAME = "fr_BE.UTF-8";
    LC_NUMERIC = "fr_BE.UTF-8";
    LC_PAPER = "fr_BE.UTF-8";
    LC_TELEPHONE = "fr_BE.UTF-8";
    LC_TIME = "fr_BE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "be-latin1";

  system.stateVersion = "24.05"; # Did you read the comment?

}
