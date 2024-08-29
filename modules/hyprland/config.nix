{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
    programs = {
      xwayland.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
    };

    # Configure file explorer
    environment.systemPackages = with pkgs; [ nautilus ];
    programs.nautilus-open-any-terminal.enable = true;
    services = {
      gvfs.enable = true;
      gnome.sushi.enable = true;
    };
  };
}
