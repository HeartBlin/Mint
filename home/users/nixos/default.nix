_: {
  config.Ark = {
    chromium.enable = true;
    element.enable = false;
    git = {
      enable = true;

      # Change manually if needed
      username = "";
      email = "";
      signing.enable = false;
    };

    terminal = {
      foot.enable = true;
      shell = "fish";
    };

    vscode.enable = true;
  };
}
