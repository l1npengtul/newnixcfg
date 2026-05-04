{ pkgs, ... }:
let
  rpgmtranslate-qt = pkgs.callPackage ./rpgmtranslate/rpgmtranslate.nix { };
in
{
  environment.systemPackages = with pkgs; [
    python3
    zulu
    jdk8
    distrobox
    rpgmtranslate-qt
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
