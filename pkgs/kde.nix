{pkgs, ...}: {
  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
  };

  programs = {
    xwayland.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
  };

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.ark
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kompare
    kdePackages.yakuake
    kdePackages.discover
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    wayland-utils
    wl-clipboard
  ];
}
