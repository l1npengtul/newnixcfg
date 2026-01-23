{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.kamera
    kdePackages.spectacle
    kdePackages.gwenview
    gimp
  ];
}
