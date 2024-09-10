{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) fakeSha256 mkDefault mkIf;

  bleedingEdge = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "560.35.03";
    sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
    sha256_aarch64 = fakeSha256;
    openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
    settingsSha256 = fakeSha256;
    persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
  };

  cfg = config.Ark.nvidia;
in {
  config = mkIf cfg.enable {
    nixpkgs.config = {
      allowUnfree = true;
      nvidia.acceptLicense = true; # IDK why this is here tbh
      cudaSupport = true;
    };

    # Set it as the active driver
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    # Set the kernel up
    boot.blacklistedKernelModules = ["nouveau"];
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

    # Feed it vaapi
    hardware.graphics = {
      extraPackages = with pkgs; [nvidia-vaapi-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
    };
  };
}