{pkgs, ...}: {
  #   xdg.dataFile."The Usual Suspects" = {
  #     recursive = true;
  #     source = pkgs.symlinkJoin {
  #       name = "gearmulator-roms";
  #       paths = [gearmulator];
  #     };
  #   };

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
