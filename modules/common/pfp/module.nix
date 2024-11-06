{ hostname, username, ... }:

{
  system.activationScripts.profilePicture = {
    text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp /home/${username}/Mint/hosts/${hostname}/pfp.png /var/lib/AccountsService/icons/${username}
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${username}\n" > /var/lib/AccountsService/users/${username}
    '';
  };
}
