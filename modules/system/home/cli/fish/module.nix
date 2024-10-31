{ config, flakedir, lib, pkgs, username, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Mint.cli.fish;
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
in {
  config = mkIf cfg.enable {
    users.users."${username}".shell = pkgs.fish;
    programs = {
      fish = {
        enable = true;
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

        interactiveShellInit = ''
          set fish_greeting
          set -gx FLAKE ${flakedir}
        '';
      };

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

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };
    };

    systemd.user.services.fish-provisioning = {
      description = "Adds the config for Fish";
      wantedBy = [ "multi-user.target" ];
      script = ''
        mkdir -p /home/${username}/.config/fish/functions
        ln -sf ${dot} /home/${username}/.config/fish/functions/..fish
        ln -sf ${mcserver} /home/${username}/.config/fish/functions/openServer.fish
      '';
    };

    system.userActivationScripts.fish-provisioning.text = ''
      ${pkgs.systemd}/bin/systemctl --user restart fish-provisioning
    '';
  };
}
