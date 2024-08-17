{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.element.enable = mkEnableOption "Enable Element, matrix client";
}
