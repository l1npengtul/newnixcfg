{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    hardwareAcceleration = {
      enable = true;
      device = "/dev/dri/renderD128";
      type = "vaapi";
    };
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
  environment.persistence."/nix/persist2".directories = [
    {
      directory = "/var/lib/jellyfin";
      user = "jellyfin";
      mode = "u=rw,g=r,o=";
    }
  ];
  users.users.jellyfin.extraGroups = [
    "video"
    "render"
  ];
}
