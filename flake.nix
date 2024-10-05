{
  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./parts ];
      systems = import systems;
    };

  inputs = {
    ##### Inputs meant to be followed #####

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";

    # The main NixOS repo
    nixpkgs.url = "github:NixOS/nixpkgs";

    # Provides 'systems'
    systems.url = "github:nix-systems/default-linux";

    ########### Everything else ###########

    # Disk partitioning
    disko.url = "github:nix-community/disko";

    # Home management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wayland Compositor
    hyprland.url = "github:hyprwm/Hyprland";

    # SecureBoot support
    lanzaboote.url = "github:/nix-community/lanzaboote/v0.4.1";

    # Easy packages
    pkgs-by-name.url = "github:drupol/pkgs-by-name-for-flake-parts";

    # Run checks automagically
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # Zen browser
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
}
