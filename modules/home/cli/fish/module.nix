{ config, flakedir, pkgs, ... }:

let cfg = config.Mint.cli;
in {
  programs = {
    fish = {
      enable = cfg.shell == "fish";

      interactiveShellInit = ''
        set fish_greeting
        set -gx FLAKE ${flakedir}

        function starship_transient_prompt_func
          starship module character
        end

        starship init fish | source
        enable_transience
      '';

      functions = {
        ".".body = ''nix shell nixpkgs#$argv[1] --command "fish"'';
        ",".body = ''
          if not set -q argv[1]
            nix flake init --template ${flakedir}/.#moduleNix
          else
            nix flake init --template ${flakedir}/.#$argv[1]
          end
        '';
        "fish_command_not_found".body = "echo Did not find command: $argv[1]";
        "mkcd".body = "mkdir -p $argv && cd $argv";
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -l";

        # Nix Flake Management
        rebuild = "nh os switch";
        boot = "nh os boot";
        update = "nix flake update --flake ${flakedir} && nh os switch";
        clean = "nh clean all && nh os boot";

        # Git commands
        ga = "git add .";
        gc = "git commit -m";
        gp = "git push";
        gs = "git status";
      };
    };

    starship = {
      enable = cfg.shell == "fish";
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

    direnv = {
      enable = cfg.shell == "fish";
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
