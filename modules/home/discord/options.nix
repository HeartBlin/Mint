{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Mint.discord.enable = mkEnableOption "Enable Discord"; }
