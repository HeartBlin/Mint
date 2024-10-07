{ self, userName, ... }:

let
  prefixPath = x: y: map (z: "${self}/modules/${x}/${z}.nix") y;

  systemPaths = [
    # Asus
    "asus/module"
    "asus/options"

    # Hyprland (system side)
    "hyprland/module"

    # Network
    "network/module"

    # Nix & related
    "nix/module"

    # NVidia drivers
    "nvidia/module"
    "nvidia/options"

    # SecureBoot suport, includes normal bootloader too
    "secureboot/module"
    "secureboot/options"

    # Steam
    "steam/module"
    "steam/options"

    # TPM LUKS unlocking
    "tpm/module"
    "tpm/options"

    # VMware
    "vmware/module"
    "vmware/options"
  ];

  homePaths = [
    # Chrome
    "chrome/module"
    "chrome/options"

    # Fish
    "cli/fish/module"
    "cli/fish/options"

    # Foot
    "cli/foot/module"
    "cli/foot/options"

    # Git
    "git/module"

    # Hyprland (home side)
    "hyprland/module"
    "hyprland/options"

    # MangoHUD
    "mangohud/module"
    "mangohud/options"

    # VSCode
    "vscode/module"
    "vscode/options"
  ];

  systemModules = prefixPath "system" systemPaths;
  homeModules = prefixPath "home" homePaths;
in {
  imports = systemModules;
  config.home-manager.users.${userName} = { imports = homeModules; };
}
