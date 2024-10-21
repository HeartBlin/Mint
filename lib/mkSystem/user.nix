{ commonArgs, hostName, inputs, prettyName, self, stateVersion, userName, ... }:

{
  users.users."${userName}" = {
    isNormalUser = true;
    description = prettyName;
    initialPassword = "changeme";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = commonArgs;

    users.${userName} = {
      imports = [
        # Modules
        inputs.mintwalls.homeManagerModules.mintWalls

        # Paths
        "${self}/hosts/${hostName}/user/config.nix"

        # Options
        { programs.home-manager.enable = true; }
        { home.stateVersion = stateVersion; }
      ];
    };
  };

  system.activationScripts.profilePicture.text = ''
    mkdir -p /var/lib/AccountsService/{icons,users}
    cp /home/${userName}/Mint/hosts/${hostName}/user/pfp.png /var/lib/AccountsService/icons/${userName}
    echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${userName}\n" > /var/lib/AccountsService/users/${userName}
  '';
}
