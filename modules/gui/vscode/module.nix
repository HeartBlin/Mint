{ config, flakedir, hostname, inputs', lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.generators) toJSON;

  cfg = config.Mint.gui.vscode;

  vscode' = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      pkief.material-icon-theme
      esbenp.prettier-vscode
      github.vscode-github-actions
      ritwickdey.liveserver

      # Trying it out
      github.copilot
      github.copilot-chat
    ];
  };

  config' = toJSON { } {
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
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    # Nix
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.hiddenLanguageServerErrors" = [ "textDocument/definition" ];
    "nix.serverSettings"."nixd" = {
      "formatting"."command" = [ "nixfmt" ];
      "nixos"."expr" = ''
        (builtins.getFlake \"${flakedir}\").nixosConfigurations.${hostname}.options'';
    };

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
in {
  options.Mint.gui.vscode.enable = mkEnableOption "Enable Visual Studio Code";

  config = mkIf cfg.enable {
    environment.systemPackages =
      [ vscode' inputs'.nixd.packages.nixd pkgs.nixfmt-classic ];
    homix.".config/Code/User/settings.json".text = config';
  };
}
