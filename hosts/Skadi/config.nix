_: {
  mintWalls.wallpaper = "SteamAutumn";

  Mint = {
    cli = {
      fish.enable = true;
      foot.enable = true;
    };

    gui = {
      bottles.enable = true;
      chrome.enable = true;
      discord.enable = true;
      hyprland = {
        enable = true;
        wallpapers = {
          "eDP-1".monitor = "eDP-1";
          "HDMI-A-1".monitor = "HDMI-A-1";
        };
      };

      mangohud.enable = true;
      minecraft.enable = true;
      nautilus.enable = true;
      steam.enable = true;
      thunderbird.enable = true;
      vmware.enable = false;
      vscode.enable = true;
    };

    system = {
      asus.enable = true;
      bluetooth.enable = true;
      gdm.enable = false;
      nvidia = {
        enable = true;
        hybrid.enable = true;
      };

      secureboot.enable = true;
      tpm.enable = true;
      underclock.enable = false;
      uwsm.enable = true;
    };
  };
}

