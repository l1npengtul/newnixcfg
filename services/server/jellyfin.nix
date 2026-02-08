{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    forceEncodingConfig = true;
    hardwareAcceleration = {
      enable = true;
      device = "/dev/dri/renderD128";
    };
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
  environment.persistence."/nix/persist2".files = ["/var/lib/jellyfin"];
  users.users.jellyfin.extraGroups = [
    "video"
    "render"
  ];
}
