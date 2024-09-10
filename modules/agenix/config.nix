{username, ...}: {
  age.secrets = {
    GitHubAuth = {
      file = ../../secrets/GitHubAuth.age;
      path = "/home/${username}/.ssh/GitHubAuth";
      owner = "${username}";
      mode = "600";
      symlink = false;
    };
    GitHubAuthPub = {
      file = ../../secrets/GitHubAuthPub.age;
      path = "/home/${username}/.ssh/GitHubAuth.pub";
      owner = "${username}";
      mode = "644";
      symlink = false;
    };
    GitHubSign = {
      file = ../../secrets/GitHubSign.age;
      path = "/home/${username}/.ssh/GitHubSign";
      owner = "${username}";
      mode = "600";
      symlink = false;
    };
    GitHubSignPub = {
      file = ../../secrets/GitHubSignPub.age;
      path = "/home/${username}/.ssh/GitHubSign.pub";
      owner = "${username}";
      mode = "644";
      symlink = false;
    };
  };
}
