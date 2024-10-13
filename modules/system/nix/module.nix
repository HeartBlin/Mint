{ config, inputs, lib, ... }:

let
  inherit (lib) filterAttrs isType mapAttrs mapAttrsToList;
  inherit (config.Mint) flakeDir;

  ##
  ## Found this snippet of code from this repo:
  ## https://github.com/fufexan/dotfiles/blob/main/system/nix/default.nix
  ##

  flakeInputs = filterAttrs (_: v: isType "flake" v) inputs;
  registry = mapAttrs (_: v: { flake = v; }) flakeInputs;
  nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
in {
  nix = {
    inherit registry nixPath;

    settings = {
      # Allow flakes & other experimental features
      experimental-features = [
        "flakes"
        "nix-command"
        "auto-allocate-uids"
        "cgroups"
        "no-url-literals"
      ];

      # Trusted users
      allowed-users = [ "root" "@wheel" ];
      trusted-users = [ "root" "@wheel" ];

      # Direnv
      keep-derivations = true;
      keep-outputs = true;

      # Keep it pure
      pure-eval = true;

      # Enable cgroups
      use-cgroups = true;

      # Shut up
      warn-dirty = false;

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

      # Keys for caches
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

  # Allow unfree
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  # Neat Nix Helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = flakeDir;
  };

  # BLOAT
  documentation = {
    enable = false;
    doc.enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
}
