{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkIf;
  cfg = config.Mint.nvidia;
in {
  config = mkIf cfg.enable {
    nixpkgs.config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      cudaSupport = true;
    };

    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
    ];

    environment.systemPackages = [
      pkgs.btop

      pkgs.vulkan-tools
      pkgs.vulkan-loader
      pkgs.vulkan-extension-layer

      pkgs.libva
      pkgs.libva-utils
    ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      dynamicBoost.enable = true;
      modesetting.enable = true;

      prime = mkIf cfg.hybrid.enable {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        amdgpuBusId = "${cfg.hybrid.id.amd}";
        nvidiaBusId = "${cfg.hybrid.id.nvidia}";
      };

      powerManagement = {
        enable = mkDefault true;
        finegrained = mkDefault true;
      };

      nvidiaSettings = false;
      open = true;
      nvidiaPersistenced = true;
    };

    hardware.graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };
  };
}
