{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.Ark.terminal) shell;

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
        kamadorueda.alejandra
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
        "files.exclude" = {"tsconfig.json" = true;};

        # Javascript/Typescript
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        # Nix
        "alejandra.program" = "alejandra";
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
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
      };
    };

    home.packages = with pkgs; [nixd alejandra];
  };
}
