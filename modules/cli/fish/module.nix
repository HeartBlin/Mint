{ config, flakedir, lib, pkgs, username, ... }:

let
  inherit (lib) getExe mkEnableOption mkIf;
  inherit (config.Mint.system) uwsm;
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
        };

        # Enable transience
        interactiveShellInit = ''
          set fish_greeting
          set -gx FLAKE ${flakedir}

          function starship_transient_prompt_func
            ${getExe pkgs.starship} module character
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

    # Functions
    systemd.user.services.fish-provisioning = let
      dot = pkgs.writeText "..fish" ''
        function .
          nix shell nixpkgs#$argv[1]
        end
      '';

      mcserver = pkgs.writeText "openServer.fish" ''
        function openServer
          env -C ~/MinecraftServer java -Xmx4096M -Xms4096M -jar ~/MinecraftServer/spigot.jar
        end
      '';

      fcnf = pkgs.writeText "fish_command_not_found.fish" ''
        function fish_command_not_found
          echo Did not find command: $argv[1]
        end
      '';
    in {
      description = "Adds the config for Fish";
      wantedBy = [ "multi-user.target" ];
      script = let path = "/home/${username}/.config/fish";
      in ''
        mkdir -p ${path}/functions
        ln -sf ${dot} ${path}/functions/..fish
        ln -sf ${mcserver} ${path}/functions/openServer.fish
        ln -sf ${fcnf} ${path}/functions/fish_command_not_found.fish
      '';
    };

    # Run on rebuild
    system.userActivationScripts.fish-provisioning.text = ''
      ${pkgs.systemd}/bin/systemctl --user restart fish-provisioning
    '';
  };
}
