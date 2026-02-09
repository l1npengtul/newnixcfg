{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.mcrcon ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = false;
  };
  environment.persistence."/nix/persist".directories = [
    {
      directory = "/srv/minecraft";
      user = "minecraft";
      group = "minecraft";
      mode = "u=rwx,g=rw,o=";
    }
  ];
}
