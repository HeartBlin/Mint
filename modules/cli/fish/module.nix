{ config, flakedir, lib, pkgs, username, ... }:

let
  inherit (lib) getExe mkEnableOption mkIf;
  inherit (config.Mint.system) uwsm;
  inherit (config.Mint.gui) hyprland;
  cfg = config.Mint.cli.fish;
in {
  options.Mint.cli.fish.enable = mkEnableOption "Enable Fish shell";

  config = mkIf cfg.enable {
    # Set the users shell
    users.users."${username}".shell = pkgs.fish;
    programs = {
      fish = {
        enable = true;
        shellAliases = {
          ls = "${pkgs.eza}/bin/eza -l";

          # Git commands
          ga = "git add .";
          gc = "git commit -m";
          gp = "git push";
          gs = "git status";

          restoreLock = mkIf hyprland.enable
            "hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1' && hyprctl --instance 0 'dispatch exec hyprlock'";
        };

        # Enable transience
        interactiveShellInit = ''
          set fish_greeting
          set -gx FLAKE ${flakedir}

          function starship_transient_prompt_func
            ${getExe pkgs.starship} module character
          end

          function .
            nix shell nixpkgs#$argv[1]
          end

          function fish_command_not_found
            echo Did not find command: $argv[1]
          end

          function openServer
            env -C ~/MinecraftServer java -Xmx4096M -Xms4096M -jar ~/MinecraftServer/spigot.jar
          end

          enable_transience
        '';

        loginShellInit = mkIf uwsm.enable ''
          if uwsm check may-start && uwsm select
            uwsm start default
          end
        '';
      };

      # Custom prompt
      starship = {
        enable = true;
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

      # Integrate direnv
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
