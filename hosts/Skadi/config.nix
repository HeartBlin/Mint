{ pkgs, ... }:

{
  Ark = {
    asus.enable = true;
    nvidia = {
      enable = true;
      hybrid.enable = true;
    };

    steam.enable = true;
    vmware.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [ vscode git ];
}

