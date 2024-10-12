{ config, hostName, lib, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (config.Ark.cli) shell;
  inherit (osConfig.Ark) flakeDir;

  cfg = config.Ark.vscode;
in {
  config = mkIf cfg.enable {
    programs.vscode = {
      # The 'enable hell'
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      # Extensions
      mutableExtensionsDir = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        pkief.material-icon-theme
        esbenp.prettier-vscode
        github.vscode-github-actions
        eamodio.gitlens
      ];

      # General settings
      userSettings = {
        # Editor
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.fontLigatures" = true;
        "editor.guides.bracketPairs" = true;
        "editor.guides.indentation" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.linkedEditing" = true;
        "editor.lineHeight" = 22;
        "editor.minimap.enabled" = false;
        "editor.renderLineHighlight" = "all";
        "editor.semanticHighlighting.enabled" = true;
        "editor.showUnused" = true;
        "editor.smoothScrolling" = true;
        "editor.tabCompletion" = "on";
        "editor.tabSize" = 2;
        "editor.trimAutoWhitespace" = true;

        # Explorer
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;

        # Files
        "files.insertFinalNewline" = false;
        "files.trimTrailingWhitespace" = true;
        "files.exclude" = { "tsconfig.json" = true; };

        # Javascript/Typescript
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings"."nixd" = {
          "formatting"."command" = [ "nixfmt" ];
          "nixos"."expr" = ''
            (builtins.getFlake \"${flakeDir}\").nixosConfigurations.${hostName}.options'';
        };
        "nix.hiddenLanguageServerErrors" = [ "textDocument/definition" ];

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };

        # Telemetry
        "telemetry.telemetryLevel" = "off";

        # Terminal
        "terminal.integrated.smoothScrolling" = true;
        "terminal.integrated.defaultProfile.linux" = "${shell}";

        # Window
        "window.autoDetectColorScheme" = true;
        "window.experimentalControlOverlay" = false;
        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "window.titleBarStyle" = "custom";

        # Workbench
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.layoutControl.enabled" = false;
        "workbench.preferredDarkColorTheme" = "Default Dark+";
        "workbench.preferredLightColorTheme" = "Default Dark+";
        "workbench.sideBar.location" = "left";
        "workbench.startupEditor" = "none";
      };
    };

    home.packages = with pkgs; [ nixd nixfmt-classic ];
  };
}
