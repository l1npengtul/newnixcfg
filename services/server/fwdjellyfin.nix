{ ... }:
{

  services.caddy.virtualHosts."jellyfih.l1npengtul.lol".extraConfig = ''
    tls {
      dns cloudflare {env.CF_API_TOKEN}
    }
    reverse_proxy wiltshire.tailed3489.ts.net:8096
  '';

}
