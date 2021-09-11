_: with _; utils.script {
  env = {
    argExtensions = packages.nixpkgs.symlinkJoin {
      name = "extensions";
      paths = [
        packages.nixpkgs.vscode-extensions._4ops.terraform
        packages.nixpkgs.vscode-extensions.bbenoist.Nix
        packages.nixpkgs.vscode-extensions.coenraads.bracket-pair-colorizer-2
        packages.nixpkgs.vscode-extensions.coolbear.systemd-unit-file
        packages.nixpkgs.vscode-extensions.jkillian.custom-local-formatters
        packages.nixpkgs.vscode-extensions.redhat.vscode-yaml
        packages.nixpkgs.vscode-extensions.haskell.haskell
        packages.nixpkgs.vscode-extensions.mads-hartmann.bash-ide-vscode
        packages.nixpkgs.vscode-extensions.shardulm94.trailing-spaces
        packages.nixpkgs.vscode-extensions.streetsidesoftware.code-spell-checker
        packages.nixpkgs.vscode-extensions.tamasfe.even-better-toml
      ] ++ packages.nixpkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
        {
          name = "terminal";
          publisher = "formulahendry";
          version = "0.0.10";
          sha256 = "0gj71xy7r82n1pic00xsi04dg7zg0dsxx000s03iq6lnz47s84gn";
        }
        {
          name = "vscodeintellicode";
          publisher = "visualstudioexptteam";
          version = "1.2.14";
          sha256 = "1j72v6grwasqk34m1jy3d6w3fgrw0dnsv7v17wca8baxrvgqsm6g";
        }
        {
          name = "vscode-pylance";
          publisher = "ms-python";
          version = "2021.9.1";
          sha256 = "08lijgnyrn1vbs5aqb18w0xzzw6n4ss2m8a8zwyjk62l01ngmffg";
        }
        {
          name = "python";
          publisher = "ms-python";
          version = "2021.8.1159798656";
          sha256 = "030si91s53ii9mqwzf4djsdh7ranaky3x9m26s279n6g9i7vd3r7";
        }
        {
          name = "rest-client";
          publisher = "humao";
          version = "0.24.5";
          sha256 = "1hj294nsmlzvhbvwv4wyf7mgfw64q4pgkjzzgyjfc26pzyaxb4bn";
        }
        {
          name = "beautify";
          publisher = "hookyqr";
          version = "1.5.0";
          sha256 = "1c0kfavdwgwham92xrh0gnyxkrl9qlkpv39l1yhrldn8vd10fj5i";
        }
        {
          name = "gitlens";
          publisher = "eamodio";
          version = "11.5.1";
          sha256 = "1c0kfavdwgwham92xrh0gnyxkrl9qlkpv39l1yhrldn8vd10fj5i";
        }
        {
          name = "vscode-icons";
          publisher = "vscode-icons-team";
          version = "11.6.0";
          sha256 = "07mp6q7xy9r53b1bh8gaw6kz64m4bzyxzm095105vv1p5l78b3lf";
        }
        {
          name = "magicpython";
          publisher = "magicstack";
          version = "1.1.0";
          sha256 = "08zwzjw2j2ilisasryd73x63ypmfv7pcap66fcpmkmnyb7jgs6nv";
        }
        {
          name = "prettify-json";
          publisher = "mohsen1";
          version = "0.0.3";
          sha256 = "1spj01dpfggfchwly3iyfm2ak618q2wqd90qx5ndvkj3a7x6rxwn";
        }
      ];
    };
    argSettings = builtins.toJSON {
      "[html]" = {
        "editor.formatOnSave" = false;
      };
      "[python]" = { "editor.tabSize" = 4; };
      "customLocalFormatters.formatters" = [
        {
          command = "${packages.nixpkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          languages = [ "nix" ];
        }
        {
          command =
            (packages.nixpkgs.writeScript "python-fmt" ''
              #! ${packages.nixpkgs.bash}/bin/bash

              PYTHONPATH=/pythonpath/not/set

              ${packages.nixpkgs.black}/bin/black \
                --config \
                ${sources.product}/makes/utils/python-format/settings-black.toml \
                - \
                | \
              ${packages.nixpkgs.python38Packages.isort}/bin/isort \
                --settings-path \
                ${sources.product}/makes/utils/python-format/settings-isort.toml \
                -
            '').outPath;
          languages = [ "python" ];
        }
        {
          command = "${packages.nixpkgs.shfmt}/bin/shfmt -bn -ci -i 2 -s -sr -";
          languages = [ "shellscript" ];
        }
        {
          command = "${packages.nixpkgs.terraform}/bin/terraform fmt -";
          languages = [ "tf" ];
        }
      ];
      "diffEditor.ignoreTrimWhitespace" = false;
      "diffEditor.maxComputationTime" = 0;
      "diffEditor.renderSideBySide" = true;
      "diffEditor.wordWrap" = "on";
      "editor.cursorStyle" = "line";
      "editor.defaultFormatter" = "jkillian.custom-local-formatters";
      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = false;
      "editor.fontFamily" = "'${abs.font}'";
      "editor.fontSize" = 16.5;
      "editor.minimap.maxColumn" = 80;
      "editor.minimap.renderCharacters" = false;
      "editor.minimap.showSlider" = "always";
      "editor.minimap.side" = "rigth";
      "editor.minimap.size" = "fill";
      "editor.rulers" = [ 80 ];
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "extensions.autoUpdate" = false;
      "files.eol" = "\n";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "python.analysis.autoSearchPaths" = true;
      "python.analysis.diagnosticMode" = "workspace";
      "python.formatting.provider" = "none";
      "python.languageServer" = "Pylance";
      "python.linting.enabled" = true;
      "python.linting.lintOnSave" = true;
      "python.linting.mypyArgs" = [
        "--config-file"
        "${sources.product}/makes/utils/lint-python/settings-mypy.cfg"
      ];
      "python.linting.mypyEnabled" = true;
      "python.linting.mypyPath" = "${packages.nixpkgs.mypy}/bin/mypy";
      "python.linting.prospectorArgs" = [
        "--profile"
        "${sources.product}/makes/utils/lint-python/settings-prospector.yaml"
      ];
      "python.defaultInterpreterPath" = "/run/current-system/sw/bin/python3.8";
      "python.linting.prospectorEnabled" = true;
      "python.linting.prospectorPath" = "prospector";
      "python.linting.pylintEnabled" = false;
      "python.pythonPath" = "${packages.nixpkgs.python38}/bin/python";
      "security.workspace.trust.enabled" = false;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
      "update.showReleaseNotes" = false;
      "window.zoomLevel" = 0;
      "workbench.colorTheme" = "Default Dark";
      "workbench.editor.enablePreview" = true;
      "workbench.editor.focusRecentEditorAfterClose" = false;
      "workbench.editor.openPositioning" = "last";
      "workbench.settings.editor" = "json";
      "workbench.startupEditor" = "none";
      "workbench.iconTheme" = "vscode-icons";
    };
    argsKeyBindings = builtins.toJSON [
      {
        key = "ctrl+d";
        command = "editor.action.copyLinesDownAction";
        when = "editorTextFocus && !editorReadonly";
      }
    ];
  };
  src = ./activate.sh;
}
