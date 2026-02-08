{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    forceEncodingConfig = true;
    hardwareAcceleration.enable = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
  environment.persistence."/nix/persist2".files = ["/var/lib/jellyfin"];
}
