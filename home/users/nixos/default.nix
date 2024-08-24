_: {
  config.Ark = {
    ags.enable = true;
    chromium.enable = true;
    discord.enable = false;
    element.enable = false;
    git = {
      enable = true;

      # Change manually if needed
      username = "";
      email = "";
      signing.enable = false;
    };

    hyprland.enable = false;
    mangohud.enable = false;
    quickshell.enable = false;
    terminal = {
      foot.enable = true;
      shell = "fish";
    };

    vscode.enable = true;
  };
}
