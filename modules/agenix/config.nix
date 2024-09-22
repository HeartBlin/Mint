{ config, lib, username, ... }:

let
  inherit (lib) mkIf;
  inherit (config.Ark) role;
in {
  config.age.secrets = mkIf (role != "iso") {
    GitHubAuth = {
      file = ../../secrets/GitHubAuth.age;
      path = "/home/${username}/.ssh/GitHubAuth";
      owner = "${username}";
      mode = "600";
    };
    GitHubAuthPub = {
      file = ../../secrets/GitHubAuthPub.age;
      path = "/home/${username}/.ssh/GitHubAuth.pub";
      owner = "${username}";
      mode = "644";
    };
    GitHubSign = {
      file = ../../secrets/GitHubSign.age;
      path = "/home/${username}/.ssh/GitHubSign";
      owner = "${username}";
      mode = "600";
    };
    GitHubSignPub = {
      file = ../../secrets/GitHubSignPub.age;
      path = "/home/${username}/.ssh/GitHubSign.pub";
      owner = "${username}";
      mode = "644";
    };
  };
}
