{ inputs, pkgs, pkgs-unstable, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  users.users.raftdev = {
    isNormalUser = true;
    description = "RaftDev";
    extraGroups = [ "raftdev" "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs-unstable; };
    users."raftdev" = import ./home.nix;
  };
}