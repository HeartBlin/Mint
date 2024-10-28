{ config, lib, pkgs, username, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Mint.gui.vscode;

  vscode' = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      pkief.material-icon-theme
      esbenp.prettier-vscode
      github.vscode-github-actions
    ];
  };

  dots = pkgs.writeText "settings.json" ''
    {
      "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "[nix]": {
        "editor.defaultFormatter": "jnoortheen.nix-ide",
        "editor.formatOnPaste": true,
        "editor.formatOnSave": true,
        "editor.formatOnType": false
      },
      "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "editor.cursorBlinking": "smooth",
      "editor.cursorSmoothCaretAnimation": "on",
      "editor.fontLigatures": true,
      "editor.guides.bracketPairs": true,
      "editor.guides.indentation": true,
      "editor.inlineSuggest.enabled": true,
      "editor.lineHeight": 22,
      "editor.linkedEditing": true,
      "editor.minimap.enabled": false,
      "editor.renderLineHighlight": "all",
      "editor.semanticHighlighting.enabled": true,
      "editor.showUnused": true,
      "editor.smoothScrolling": true,
      "editor.tabCompletion": "on",
      "editor.tabSize": 2,
      "editor.trimAutoWhitespace": true,
      "explorer.confirmDelete": false,
      "explorer.confirmDragAndDrop": false,
      "extensions.autoCheckUpdates": false,
      "files.exclude": {
        "tsconfig.json": true
      },
      "files.insertFinalNewline": false,
      "files.trimTrailingWhitespace": true,
      "nix.enableLanguageServer": true,
      "nix.hiddenLanguageServerErrors": [
        "textDocument/definition"
      ],
      "nix.serverPath": "nixd",
      "nix.serverSettings": {
        "nixd": {
          "formatting": {
            "command": [
              "nixfmt"
            ]
          },
          "nixos": {
            "expr": "(builtins.getFlake \\\"/home/heartblin/Mint\\\").nixosConfigurations.Skadi.options"
          }
        }
      },
      "telemetry.telemetryLevel": "off",
      "terminal.integrated.defaultProfile.linux": "fish",
      "terminal.integrated.smoothScrolling": true,
      "update.mode": "none",
      "window.autoDetectColorScheme": true,
      "window.dialogStyle": "custom",
      "window.experimentalControlOverlay": false,
      "window.menuBarVisibility": "toggle",
      "window.titleBarStyle": "custom",
      "workbench.iconTheme": "material-icon-theme",
      "workbench.layoutControl.enabled": false,
      "workbench.preferredDarkColorTheme": "Default Dark+",
      "workbench.preferredLightColorTheme": "Default Dark+",
      "workbench.sideBar.location": "left",
      "workbench.startupEditor": "none"
    }
  '';
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode' nixd nixfmt-classic ];

    systemd.user.services.vscode-provisioning = {
      description = "Adds the config for VSCode";
      wantedBy = [ "multi-user.target" ];
      script = ''
        mkdir -p /home/${username}/.config/Code/User
        ln -sf ${dots.outPath} /home/${username}/.config/Code/User/settings.json
      '';
    };

    system.userActivationScripts.vscode-provisioning.text = ''
      ${pkgs.systemd}/bin/systemctl --user restart vscode-provisioning
    '';
  };
}
