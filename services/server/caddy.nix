{
  inputs,
  config,
  pkgs,
  ...
}:
let
  shhh = builtins.toString inputs.shhh;
in
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-biQdtiscdmrwP6VUsuXmZrvcdewl+g50kdmab5lhE0s=";
    };
    environmentFile = config.sops.secrets."CF_API_TOKEN".path;
  };

  sops.secrets."CF_API_TOKEN" = {
    sopsFile = "${shhh}/caddy.env";
    format = "dotenv";
    owner = "caddy";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
