{ config, inputs, ... }:

let cfg = config.Mint.gui.discord;
in {
  imports = [ inputs.nixcord.homeManagerModules.nixcord ];

  programs.nixcord = {
    inherit (cfg) enable;
    config.plugins = {
      alwaysAnimate.enable = true;
      anonymiseFileNames.enable = true;
      colorSighted.enable = true;
      ctrlEnterSend = {
        enable = true;
        submitRule = "shift+enter";
      };

      experiments.enable = true;
      noBlockedMessages.enable = true;
      noF1.enable = true;
      showMeYourName.enable = true;
    };
  };
}
