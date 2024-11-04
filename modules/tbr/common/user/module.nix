{ prettyname, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = prettyname;
    extraGroups = [ "wheel" "networkmanager" ];
    homix = true;
  };
}
