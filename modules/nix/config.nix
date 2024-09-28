{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mapAttrsToList mkIf;
  inherit (config.Ark) flakeDir role;
in {
  imports = [ inputs.lix.nixosModules.default ];

  nix = {
    # Channels
    nixPath = mapAttrsToList (x: _: "${x}=flake:${x}") config.nix.registry;

    # Chill tf out
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 5;

    settings = {
      pure-eval = true;

      auto-optimise-store = true;
      builders-use-substitutes = true;

      allowed-users = [ "root" "@wheel" ];
      trusted-users = [ "root" "@wheel" ];

      # Registry
      flake-registry = "/etc/nix/registry.json";

      # Run sandboxed builds
      sandbox = true;
      sandbox-fallback = false;

      # Allow flakes
      experimental-features = [ "flakes" "nix-command" "auto-allocate-uids" ];

      warn-dirty = false; # Shut up

      # Caches
      substituters = [
        "https://cache.nixos.org?priority=10" # Funny
        "https://cache.ngi0.nixos.org/" # CA nix
        "https://nix-community.cachix.org" # Community
        "https://nixpkgs-unfree.cachix.org" # Unfree 1
        "https://numtide.cachix.org" # Unfree 2
        "https://nixpkgs-wayland.cachix.org" # Wayland
        "https://hyprland.cachix.org" # Hyprland
        "https://nyx.cachix.org" # Foot-transparent
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };

  environment = {
    systemPackages = [ pkgs.git ];
    defaultPackages = [ ];
  };

  programs.nh = mkIf (role != "iso") {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = flakeDir;
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
    man.enable = false;
  };

  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/system/activation/switchable-system.nix
  system.switch = {
    enable = false;
    enableNg = true;
  };
}
