{ lib, ... }:

let inherit (lib) mkForce;
in {
  # Disable default programs
  programs.nano.enable = mkForce false;
  services.xserver = {
    desktopManager.xterm.enable = mkForce false;
    displayManager.lightdm.enable = mkForce false;
  };

  environment.defaultPackages = mkForce [ ];
  documentation = {
    enable = mkForce false;
    man.enable = mkForce false;
  };

  # Boot settings
  boot = {
    bootspec.enable = mkForce true;
    initrd.systemd.enable = mkForce true;
    consoleLogLevel = mkForce 3;
    kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];
    tmp = {
      cleanOnBoot = mkForce true;
      useTmpfs = mkForce true;
    };
  };

  # https://github.com/fufexan/dotfiles/blob/main/system/core/default.nix
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales =
      [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "ro_RO.UTF-8/UTF-8" ];
  };
}
