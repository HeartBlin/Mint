_: {
  boot = {
    initrd.systemd.enable = true;
    consoleLogLevel = 3;
    kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];
  };

  # https://github.com/fufexan/dotfiles/blob/main/system/core/default.nix
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales =
      [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "ro_RO.UTF-8/UTF-8" ];
  };
}
