{
  inputs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  users.users.atticd = {
    description = "atticd service user";
    isSystemUser = true;
    group = "atticd";
  };
  users.groups.atticd = {};

  services.atticd = {
    enable = true;
    environmentFile = config.sops.secrets.ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64.path;
    user = "atticd";
    group = "atticd";

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
      dns cloudflare {env.CF_API_TOKEN}
    }
    reverse_proxy localhost:${builtins.toString inputs.shhh.services.atticd.port}
  '';

  sops.secrets.ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64 = {
    sopsFile = "${shhh}/atticd.env";
    format = "dotenv";
    owner = "atticd";
  };
  environment.persistence."/nix/persist".directories = [
    {
      directory = "/var/lib/atticd";
      user = "atticd";
      mode = "u=rw,g=r,o=";
    }
  ];
}
