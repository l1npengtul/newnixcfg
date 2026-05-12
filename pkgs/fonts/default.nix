{ pkgs, ... }:
let
  rainyhearts-ttf = pkgs.callPackage ./custom/rainyhearts { inherit pkgs; };
  dalmoori-ttf = pkgs.callPackage ./custom/dalmoori { };
  pixelmplus-ttf = pkgs.callPackage ./custom/pixelmplus { };
  libre-moretus = pkgs.callPackage ./custom/libre-moretus { };
  minipax = pkgs.callPackage ./custom/minipax { };
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    liberation_ttf
    fira-code
    fira-code-symbols
    proggyfonts
    nerd-fonts.comic-shanns-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    rainyhearts-ttf
    dalmoori-ttf
    pixelmplus-ttf
    fira
    fira-mono
    roboto
    libertine
    gelasio
    ibm-plex
    libre-moretus
    minipax
  ];

  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [
        "rainyhearts"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
      ];
      monospace = [
        "ComicShannsMono Nerd Font Mono"
        "Noto Sans Mono CJK JP"
        "Noto Sans Mono CJK KR"
      ];
    };
  };
}
