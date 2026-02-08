{
  inputs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  services.atticd = {
    enable = true;
    environmentFile = config.sops.secrets.ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64.path;

    settings = {
      listen = "[::]:${builtins.toString inputs.shhh.services.atticd.port}";

      jwt = {};

      chunking = {
        nar-size-threshold = 64 * 1024;
        min-size = 16 * 1024;
        avg-size = 64 * 1024;
        max-size = 256 * 1024;
      };
    };
  };

  services.caddy.virtualHosts."${inputs.shhh.services.atticd.domain}".extraConfig = ''
    tls {
      dns cloudflare {env.CF_API_KEY}
    }
    reverse_proxy localhost:${inputs.shhh.services.atticd.port}
  '';

  sops.secrets.ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64 = {
    sopsFile = "${shhh}/atticd.env";
    format = "dotenv";
  };
  environment.persistence."/nix/persist".directories = [
    {
      directory = "/var/lib/atticd";
      user = "atticd";
      mode = "u=rw,g=r,o=";
    }
  ];
}
