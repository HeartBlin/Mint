{ config, inputs, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint.discord;
in {
  imports = [ inputs.nixcord.homeManagerModules.nixcord ];

  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
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
  };
}
