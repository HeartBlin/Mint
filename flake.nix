{
  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./parts ];
      systems = import systems;
    };

  inputs = {
    ##### Inputs meant to be followed #####

    # Input for non-flake systems
    flake-compat.url = "github:edolstra/flake-compat";

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # The main NixOS repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Provides 'systems'
    systems.url = "github:nix-systems/x86_64-linux";

    ########### Everything else ###########

    # Disk partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Idle daemon
    hypridle.url = "github:hyprwm/hypridle";
    hypridle.inputs = {
      hyprlang.follows = "hyprland/hyprlang";
      hyprutils.follows = "hyprland/hyprutils";
      nixpkgs.follows = "hyprland/nixpkgs";
      systems.follows = "hyprland/systems";
    };

    # Wayland Compositor
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs = {
      nixpkgs.follows = "nixpkgs";
      systems.follows = "systems";
    };

    # Lockscreen
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs = {
      hyprlang.follows = "hyprland/hyprlang";
      hyprutils.follows = "hyprland/hyprutils";
      nixpkgs.follows = "hyprland/nixpkgs";
      systems.follows = "hyprland/systems";
    };

    # SecureBoot support
    lanzaboote.url = "github:/nix-community/lanzaboote/v0.4.1";
    lanzaboote.inputs = {
      flake-compat.follows = "flake-compat";
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
      pre-commit-hooks-nix.follows = "pre-commit-hooks";
    };

    # Faster eval Nix fork
    lix.url =
      "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    lix.inputs.nixpkgs.follows = "nixpkgs";

    # Personal Wallpapers
    mintwalls.url = "git+file:///home/heartblin/MintWalls";
    # mintwalls.url = "github:HeartBlin/MintWalls";
    mintwalls.inputs = {
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
      systems.follows = "systems";
    };

    # Declarative Discord plugins
    nixcord.url = "github:KaylorBen/nixcord";

    # Run checks automagically
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs = {
      flake-compat.follows = "flake-compat";
      nixpkgs.follows = "nixpkgs";
      nixpkgs-stable.follows = "nixpkgs";
    };
  };
}
