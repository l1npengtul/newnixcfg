{pkgs, ...}: {
  home.packages = with pkgs; [
    blender
    kicad
    darktable
    davinci-resolve-studio
    krita
  ];
  programs.obs-studio = {
    enable = true;
  };
}
