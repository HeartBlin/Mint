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

        function starship_transient_prompt_func
          starship module character
        end

        starship init fish | source
        enable_transience
      '';

      functions = {
        ".".body = ''nix shell nixpkgs#$argv[1] --command "fish"'';
        "fish_command_not_found".body = "echo Did not find command: $argv[1]";
        "mkcd".body = "mkdir -p $argv && cd $argv";
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -l";
        rebuild = "nh os switch";
        boot = "nh os boot";
        update = "nix flake update ${flakeDir} && nh os switch";
        clean = "nh clean all && nh os boot";
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = false; # I do it manually

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
