{ self, userName, ... }:

let
  prefixPath = x: y: map (z: "${self}/modules/${x}/${z}") y;

  systemPaths = [
    # Asus
    "asus/module.nix"
    "asus/options.nix"

    # Hyprland (system side)
    "hyprland/module.nix"

    # Nix & related
    "nix/module.nix"

    # NVidia drivers
    "nvidia/module.nix"
    "nvidia/options.nix"

    # Steam
    "steam/module.nix"
    "steam/options.nix"

    # VMware
    "vmware/module.nix"
    "vmware/options.nix"
  ];

  homePaths = [
    # Chrome
    "chrome/module.nix"
    "chrome/options.nix"

    # Fish
    "cli/fish/module.nix"
    "cli/fish/options.nix"

    # Foot
    "cli/foot/module.nix"
    "cli/foot/options.nix"

    # Git
    "git/module.nix"

    # Hyprland (home side)
    "hyprland/module.nix"
    "hyprland/options.nix"

    # MangoHUD
    "mangohud/module.nix"
    "mangohud/options.nix"

    # VSCode
    "vscode/module.nix"
    "vscode/options.nix"
  ];

  systemModules = prefixPath "system" systemPaths;
  homeModules = prefixPath "home" homePaths;
in {
  imports = systemModules;
  config.home-manager.users.${userName} = { imports = homeModules; };
}
