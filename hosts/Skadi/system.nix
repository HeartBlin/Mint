{ pkgs, ... }:

{
  ## THIS WHOLE CONFIS IS TRASH !!!
  ## USED TO GET RID OF ERRORS IN 'nix flake check' !!!

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_10;

  users.groups.admin = { };
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "admin";
      group = "admin";
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  fileSystems = {
    "/".device = "/dev/hda1";
    "/data" = {
      device = "/dev/hda2";
      fsType = "ext3";
      options = [ "data=journal" ];
    };
    "/bigdisk".label = "bigdisk";
  };

  boot.loader.grub.device = "/dev/disk/by-id/wwn-0x500001234567890a";

  networking.firewall.allowedTCPPorts = [ 22 ];
  environment.systemPackages = with pkgs; [ htop ];
}
