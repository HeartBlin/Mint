{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.greeter.customGreeter.enable =
    mkEnableOption "Enables a custom /etc/issue and disables LightDM";
}
