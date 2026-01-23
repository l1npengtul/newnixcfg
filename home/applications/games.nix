{pkgs, ...}: {
  home.packages = with pkgs; [
    #duckstation
    pcsx2
    rpcs3
    azahar
    prismlauncher
  ];
}
