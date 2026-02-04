{
  inputs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  services.atticd = {
    enable = true;
    environmentFile = config.sops.secrets.atticd.path;

    settings = {
      listen = inputs.shhh.services.atticd.listen;

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
    sopsFile = "${shhh}/atticd.env";
  };
  environment.persistence."/nix/persist".directories = ["/var/lib/atticd"];
}
