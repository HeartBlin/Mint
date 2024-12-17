{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkEnableOption mkIf mkOption;
  inherit (lib.types) str;
  cfg = config.Mint.system.nvidia;

  # bleedingEdge = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #   version = "565.57.01";
  #   sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
  #   sha256_aarch64 = "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
  #   openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
  #   settingsSha256 = "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
  #   persistencedSha256 = "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
  # };
in {
  options.Mint.system.nvidia = {
    enable = mkEnableOption "Enable Nvidia drivers";
    hybrid = {
      enable = mkEnableOption "Enable Nvidia hybrid graphics";
      id = {
        amd = mkOption {
          type = str;
          default = "PCI:6:0:0";
          description = "ID of AMD GPU";
        };

        nvidia = mkOption {
          type = str;
          default = "PCI:1:0:0";
          description = "ID of Nvidia GPU";
        };
      };
    };
  };

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
