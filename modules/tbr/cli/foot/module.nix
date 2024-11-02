{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  shell = if cfg.fish.enable then "fish" else "bash";
  cfg = config.Mint.cli;
in {
  options.Mint.cli.foot.enable = mkEnableOption "Enable Foot terminal emulator";

  config = mkIf cfg.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          inherit shell;

          font = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold = "CaskaydiaCove NF:style=Bold Italic:size=12";
          font-italic = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold-italic = "CaskaydiaCove NF:style=Bold Italic:size=12";

          pad = "20x20";
        };

        colors = {
          background = "141b1e";
          foreground = "dadada";

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

    fonts.packages =
      [ (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; }) ];
  };
}