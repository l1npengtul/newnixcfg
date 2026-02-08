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
    globalConfig = ''
      tls {
          dns cloudflare {env.CF_API_KEY}
      }
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = [ config.sops.secrets."CF_API_KEY".path ];

  sops.secrets."CF_API_KEY" = {
    sopsFile = "${shhh}/caddy.env";
    format = "dotenv";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
