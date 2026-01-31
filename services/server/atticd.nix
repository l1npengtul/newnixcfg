{
  pkgs,
  config,
  ...
}: {
  services.atticd = {
    enable = true;
    environmentFile = config.sops.secrets.atticd.path;

    settings = {
      listen = "[::]:4774";

      jwt = {};

      chunking = {
        nar-size-threshold = 64 * 1024;
        min-size = 16 * 1024;
        avg-size = 64 * 1024;
        max-size = 256 * 1024;
      };
    };
  };

  sops.secrets.atticd = {
    sopsFile = ./../secrets/atticd.env;
  };
  environment.persistence."/nix/persist".directories = ["/var/lib/atticd"];
}
