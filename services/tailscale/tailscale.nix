{
  config,
  pkgs,
  lib,
  sops,
  ...
}: {
  options = {
    services.connect-to-tailscale = {
      enable = lib.mkEnableOption "enable tailscale autoconnect";
      side = lib.mkOption {default = "client";};
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      if cfg.side == "client"
      then [
        pkgs.ktailctl
        pkgs.tailscale
      ]
      else [pkgs.tailscale];

    sops.secrets."tailscale_key" = {
      sopsFile = ./. + "/../secrets/${config.networking.hostName}.yaml";
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = cfg.side;
      authKeyFile = config.sops.secrets."tailscale_key".path;
    };

    networking.firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = ["tailscale0"];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [config.services.tailscale.port];
    };
  };
}
