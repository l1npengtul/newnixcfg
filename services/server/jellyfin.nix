{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
  environment.persistence."/nix/persist".files = ["/var/lib/jellyfin"];
}
