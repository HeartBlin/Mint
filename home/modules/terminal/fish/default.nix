{ config, lib, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (osConfig.Ark) flakeDir;

  cfg = config.Ark.terminal;
in {
  config = mkIf (cfg.shell == "fish") {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set -gx FLAKE ${flakeDir}
      '';

      functions = {
        ".".body = ''nix shell nixpkgs#$argv[1] --command "fish"'';
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -l";
        rebuild = "nh os switch";
        boot = "nh os boot";
        update = "nix flake update --flake ${flakeDir} && nh os switch";
        clean = "nh clean all && nh os boot";
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        add_newline = false;

        character = {
          disabled = false;
          success_symbol = "[λ](bold purple)";
          error_symbol = "[λ](bold red)";
        };

        directory.disabled = false;
      };
    };
  };
}
