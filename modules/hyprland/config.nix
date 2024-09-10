{
  config,
  inputs',
  lib,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.home-manager.users.${username}.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
    programs = {
      xwayland.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs'.hyprland.packages.hyprland;
        portalPackage =
          inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
      };
    };

    # Configure file explorer
    environment.systemPackages = with pkgs; [nautilus];
    programs.nautilus-open-any-terminal.enable = true;
    services = {
      gvfs.enable = true;
      gnome.sushi.enable = true;
    };
  };
}
