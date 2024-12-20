{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mintWalls) palette;

  cfg = config.Mint.cli.foot;
in {
  options.Mint.cli.foot.enable = mkEnableOption "Enable Foot terminal emulator";

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        main = {
          font = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold = "CaskaydiaCove NF:style=Bold Italic:size=12";
          font-italic = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold-italic = "CaskaydiaCove NF:style=Bold Italic:size=12";
          pad = "20x20";
        };

        colors = with palette; {
          inherit background;
          foreground = onBackground;

          regular0 = "232a2d";
          regular1 = "e57474";
          regular2 = "8ccf7e";
          regular3 = "e5c76b";
          regular4 = "67b0e8";
          regular5 = "c47fd5";
          regular6 = "6cbfbf";
          regular7 = "b3b9b8";

          bright0 = "2d3437";
          bright1 = "ef7e7e";
          bright2 = "96d988";
          bright3 = "f4d67a";
          bright4 = "71baf2";
          bright5 = "ce89df";
          bright6 = "67cbe7";
          bright7 = "bdc3c2";
        };

        cursor = {
          style = "block";
          blink = "no";
        };
      };
    };

    fonts.packages = [ pkgs.nerd-fonts.caskaydia-cove ];
  };
}
