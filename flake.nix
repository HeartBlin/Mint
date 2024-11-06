{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./parts ];
      systems = import inputs.systems;
    };

  inputs = {
    ##### Inputs meant to be followed #####

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # The main NixOS repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Provides 'systems'
    systems.url = "github:nix-systems/x86_64-linux";

    ########### Everything else ###########

    # Bleeding edge kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs = {
      home-manager.follows = "";
      nixpkgs.follows = "nixpkgs";
    };

    # Disk partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home management
    homix = {
      url = "github:sioodmy/homix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
      pre-commit-hooks-nix.follows = "pre-commit-hooks";
    };

    # Fork of Nix
    lix = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Import all packages
    pkgs-by-name.url = "github:drupol/pkgs-by-name-for-flake-parts";

    # Run checks automagically
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs = {
      nixpkgs.follows = "nixpkgs";
      nixpkgs-stable.follows = "nixpkgs";
    };
  };
}
