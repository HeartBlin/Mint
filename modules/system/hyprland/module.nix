{ config, inputs', lib, pkgs, userName, ... }:

let
  inherit (lib) mkIf;

  cfg = config.home-manager.users.${userName}.Mint.hyprland;
in {
  config = mkIf cfg.enable {
    programs = {
      xwayland.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs'.hyprland.packages.hyprland;
      };
    };

    environment = {
      systemPackages = with pkgs; [ nautilus ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };
    programs.nautilus-open-any-terminal.enable = true;

    services = {
      gvfs.enable = true;
      gnome.sushi.enable = true;
    };
  };
}
