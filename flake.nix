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

    # GTK Bar
    ags.url = "github:aylur/ags/v2";
    ags.inputs = { nixpkgs.follows = "nixpkgs"; };

    # Bleeding edge kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs = {
      home-manager.follows = "home-manager";
      nixpkgs.follows = "nixpkgs";
    };

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
      flake-compat.follows = "";
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
      pre-commit-hooks-nix.follows = "";
    };

    # Faster eval Nix fork
    lix.url =
      "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    lix.inputs.nixpkgs.follows = "nixpkgs";

    # Personal Wallpapers
    # mintwalls.url = "git+file:///home/heartblin/MintWalls";
    mintwalls.url = "github:HeartBlin/MintWalls";
    mintwalls.inputs = {
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
      systems.follows = "systems";
    };

    # Declarative Discord plugins
    nixcord.url = "github:KaylorBen/nixcord";
    nixcord.inputs = {
      flake-compat.follows = "";
      nixpkgs.follows = "nixpkgs";
    };

    # Run checks automagically
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs = {
      flake-compat.follows = "";
      nixpkgs.follows = "nixpkgs";
      nixpkgs-stable.follows = "";
    };
  };
}
