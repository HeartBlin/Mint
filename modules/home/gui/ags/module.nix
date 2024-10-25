{ config, inputs, inputs', ... }:

let cfg = config.Mint.gui.ags;
in {
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    inherit (cfg) enable;

    extraPackages = with inputs'.ags.packages; [
      battery
      hyprland
      network
      tray
      wireplumber
    ];
  };
}
