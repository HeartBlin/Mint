{
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./parts ];
      systems = [
        "x86_64-linux" # Also add "aarch64-linux" when I have the hardware
      ];
    };

  inputs = {
    agenix = {
      type = "git";
      url = "https://github.com/ryantm/agenix";
      submodules = false;

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ags = {
      type = "git";
      url = "https://github.com/Aylur/ags";
      submodules = false;

      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      type = "git";
      url = "https://github.com/chaotic-cx/nyx";
      ref = "nyxpkgs-unstable";
      submodules = false;

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    disko = {
      type = "git";
      url = "https://github.com/nix-community/disko";
      submodules = false;

      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      type = "git";
      url = "https://github.com/hercules-ci/flake-parts";
      submodules = false;

      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      type = "git";
      url = "https://github.com/nix-community/home-manager";
      submodules = false;

      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      ref = "refs/tags/v0.43.0";
      submodules = true;

      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      type = "git";
      url = "https://github.com/nix-community/lanzaboote";
      ref = "refs/tags/v0.4.1";
      submodules = false;

      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixpkgs = {
      type = "git";
      url = "https://github.com/NixOS/nixpkgs";
      ref = "nixos-unstable";
      submodules = false;
    };

    nyxexprs = {
      type = "git";
      url = "https://github.com/NotAShelf/nyxexprs";
      submodules = false;

      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    zen-browser = {
      type = "git";
      url = "https://github.com/MarceColl/zen-browser-flake";
      submodules = false;

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
