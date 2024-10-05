{ userName, ... }:

let
  systemModules = [
    # Asus
    ./asus/module.nix
    ./asus/options.nix

    # Hyprland (system side)
    ./hyprland/module.nix

    # Nix & related
    ./nix/module.nix

    # NVidia drivers
    ./nvidia/module.nix
    ./nvidia/options.nix

    # Steam
    ./steam/module.nix
    ./steam/options.nix

    # VMware
    ./vmware/module.nix
    ./vmware/options.nix
  ];

  homeModules = [
    # Chrome
    ./home/chrome/module.nix
    ./home/chrome/options.nix

    # Fish
    ./home/cli/fish/module.nix
    ./home/cli/fish/options.nix

    # Foot
    ./home/cli/foot/module.nix
    ./home/cli/foot/options.nix

    # Git
    ./home/git/module.nix

    # Hyprland (home side)
    ./home/hyprland/module.nix
    ./home/hyprland/options.nix

    # MangoHUD
    ./home/mangohud/module.nix
    ./home/mangohud/options.nix

    # VSCode
    ./home/vscode/module.nix
    ./home/vscode/options.nix
  ];
in {
  imports = systemModules;
  config.home-manager.users.${userName} = { imports = homeModules; };
}
