_: {
  config.Ark = {
    chromium.enable = true;
    element.enable = true;
    git = {
      enable = true;
      username = "HeartBlin";
      email = "161874560+HeartBlin@users.noreply.github.com";
      authKey = "/home/heartblin/.ssh/GithubAuth";
      signing = {
        enable = true;
        signKey = "/home/heartblin/.ssh/GithubSign.pub";
      };
    };

    terminal = {
      foot.enable = true;
      shell = "fish";
    };

    vscode.enable = true;
  };
}
