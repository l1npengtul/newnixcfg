{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    audacious
    kdePackages.elisa
    kdePackages.audiotube
    kdePackages.k3b
    strawberry

    openutau
    kid3-cli
  ];
}
