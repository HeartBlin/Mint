{ config, lib, pkgs, ... }:

let
  inherit (lib) fakeSha256 mkDefault;

  bleedingEdge = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "560.31.02";
    sha256_64bit = "sha256-0cwgejoFsefl2M6jdWZC+CKc58CqOXDjSi4saVPNKY0=";
    sha256_aarch64 = fakeSha256;
    openSha256 = "sha256-X5UzbIkILvo0QZlsTl9PisosgPj/XRmuuMH+cDohdZQ=";
    settingsSha256 = fakeSha256;
    persistencedSha256 = "sha256-BDtdpH5f9/PutG3Pv9G4ekqHafPm3xgDYdTcQumyMtg=";
  };
in {
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      nvidia.acceptLicense = true; # IDK why this is here tbh
      cudaSupport = true;
    };

    # Set it as the active driver
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    # Set the kernel up
    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
    ];

    # Extra things
    environment.systemPackages = [
      pkgs.btop # See GPU usage

      pkgs.vulkan-tools
      pkgs.vulkan-loader
      pkgs.vulkan-extension-layer

      pkgs.libva
      pkgs.libva-utils
    ];

    hardware.nvidia = {
      package = bleedingEdge;

      dynamicBoost.enable = true;
      modesetting.enable = true;

      prime = {
        reverseSync.enable = true;
        reverseSync.setupCommands.enable = true;

        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      powerManagement = {
        enable = mkDefault true;
        finegrained = mkDefault true;
      };

      nvidiaSettings = false;
      open = true;
      nvidiaPersistenced = true;
    };

    # Feed it vaapi
    hardware.graphics = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };
  };
}
