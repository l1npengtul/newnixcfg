{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    protontricks
    winetricks
  ];
}
