{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    forceEncodingConfig = true;
    hardwareAcceleration.enable = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
  environment.persistence."/nix/persist".files = ["/var/lib/jellyfin"];
}
