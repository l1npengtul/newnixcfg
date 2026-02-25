{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    protontricks
    winetricks
    wineasio
    protonup-qt
    protonup-rs
    protonup-ng
    protonplus
  ];
}
