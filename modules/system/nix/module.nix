{ config, inputs, lib, ... }:

let
  inherit (lib) filterAttrs isType mapAttrs mapAttrsToList mkForce pipe;
  inherit (config.Mint) flakeDir;

  ##
  ## Found this snippet of code from this repo:
  ## https://github.com/fufexan/dotfiles/blob/main/system/nix/default.nix
  ## I tried to do it with the pipe operator but both nix and lix dont
  ## really like it that much. Neither the nix flake check command
  ## for that matter
  ##

  registry = pipe inputs [
    (filterAttrs (_: isType "flake"))
    (mapAttrs (_: flake: { inherit flake; }))
    (x: x // { nixpkgs.flake = inputs.nixpkgs; })
  ];

  nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
in {
  nix = {
    inherit registry nixPath;

    # Optimise store
    optimise.automatic = true;

    # Don't eat the CPU please
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 5;

    settings = {
      # Allow flakes & other experimental features
      experimental-features = [
        "flakes"
        "nix-command"
        "auto-allocate-uids"
        "cgroups"
        "no-url-literals"
        "pipe-operator"
      ];

      # Trusted users
      allowed-users = [ "root" "@wheel" ];
      trusted-users = [ "root" "@wheel" ];

      # Build in sandboxes
      sandbox = true;
      sandbox-fallback = false;

      # Direnv
      keep-derivations = true;
      keep-outputs = true;

      # Keep it pure
      pure-eval = true;

      # Enable cgroups
      use-cgroups = true;

      # Shut up
      warn-dirty = false;

      # Optimise again
      auto-optimise-store = true;

      # Caches
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org?priority=10" # Funny
        "https://nix-community.cachix.org" # Community
        "https://hyprland.cachix.org" # Hyprland
      ];

      # Keys for caches
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  # Allow unfree
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
    enableParallelBuilding = true;
  };

  # Neat Nix Helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = flakeDir;
  };

  # BLOAT
  environment.defaultPackages = mkForce [ ];
  documentation = {
    enable = false;
    man.enable = false; # Don't need this personally
  };
}
