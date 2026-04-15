{ pkgs, ... }:
let
  additional = with pkgs.vscode-marketplace; [
    hellotham.vsc-rosely-light
    mgwg.light-pink-theme
    swellaby.vscode-rust-test-adapter
    jscearcy.rust-doc-viewer
    tamasfe.even-better-toml
    itsyaasir.rust-feature-toggler
    littlefoxteam.vscode-python-test-adapter
  ];
in
{
  home.packages = with pkgs; [
    ghidra-bin
    gdb
    # hex editor
    okteta

    kdiff3

    fresh-editor
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions =
          with pkgs.vscode-extensions;
          [
            zhuangtongfa.material-theme
            yzhang.markdown-all-in-one
            mkhl.direnv
            rust-lang.rust-analyzer
            ritwickdey.liveserver
            ziglang.vscode-zig
            ms-python.python
            ms-python.pylint
            ms-python.debugpy
            ms-pyright.pyright
            ms-python.vscode-pylance
            llvm-vs-code-extensions.lldb-dap
            vadimcn.vscode-lldb
            jnoortheen.nix-ide
            kamadorueda.alejandra
            esbenp.prettier-vscode
            naumovs.color-highlight
            vitaliymaz.vscode-svg-previewer
            hbenl.vscode-test-explorer
            ms-vscode.test-adapter-converter
            fill-labs.dependi
          ]
          ++ additional;

        userSettings = {
          "editor.fontFamily" = "'ComicShannsMono Nerd Font Mono','Droid Sans Mono', 'monospace', monospace";
          "editor.formatOnSave" = true;
          "files.autoSave" = "onFocusChange";
          "rust-analyzer.assist.emitMustUse" = true;
          "rust-analyzer.check.command" = "clippy";
          "rust-analyzer.inlayHints.parameterHints" = true;
          "nix.enableLanguageServer" = true;
          "dependi.rust.unstableFilter" = "IncludeAlways";
          "workbench.colorTheme" = "Rosely Light";
          "evenBetterToml.formatter.arrayAutoExpand" = true;
          "evenBetterToml.formatter.arrayAutoCollapse" = true;
          "evenBetterToml.formatter.arrayTrailingComma" = true;
          "editor.fontSize" = 16;
          "editor.wordWrap" = "on";
          "chat.disableAIFeatures" = true;
        };
      };
    };
  };
}
