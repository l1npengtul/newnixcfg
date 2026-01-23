{
  config,
  pkgs,
  lib,
  sops,
  ...
}: let
  cfg = config.services.tailscale-autoconnect;
in {
  options = {
    services.tailscale-autoconnect = {
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

    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = cfg.side;

    sops.secrets."tailscale_key" = {
      sopsFile = ./. + "/../secrets/${config.networking.hostName}.yaml";
      owner = "tailscale-autoconnect";
    };

    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = [
        "network-pre.target"
        "tailscale.service"
        "sops-nix.service"
      ];
      wants = [
        "network-pre.target"
        "tailscale.service"
      ];
      wantedBy = ["multi-user.target"];

      # set this service as a oneshot job
      serviceConfig = {
        User = "tailscale-autoconnect";
        Type = "oneshot";
      };

      # have the job run this shell script
      script = with pkgs; ''
        # wait for tailscaled to settle
        sleep 2

        # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then # if so, then do nothing
          exit 0
        fi

        export TSKEY=$(cat ${config.sops.secrets."tailscale_key".path})

        # otherwise authenticate with tailscale
        ${tailscale}/bin/tailscale up -authkey

      '';
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
