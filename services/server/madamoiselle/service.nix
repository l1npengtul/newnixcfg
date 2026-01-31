{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.madamoiselle;
  madamoiselle = pkgs.callPackage ./madamoiselle.nix {};
in {
  options = {
    services.madamoiselle = {
      enable = lib.mkEnableOption "enable madamoiselle";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.madamoiselle = {
      createHome = true;
      description = "madamoiselle service user";
      isSystemUser = true;
      group = "services";
    };
    systemd.services.madamoiselle = {
      wantedBy = ["default.target"];
      after = ["network.target"];
      description = "enable madamoiselle discord bot";
      serviceConfig = {
        User = "madamoiselle";
        Group = "services";
        Restart = "on-failure";
        ProtectHome = true;
        ProtectSystem = true;
        NoNewPrivileges = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;

        After = ["sops-nix.service"];
      };

      environment = {
        RUST_LOG = "madamoiselle";
      };

      script = ''
        export MADAMOISELLE_DISCORD_TOKEN=$(cat ${config.sops.secrets."madamoiselle/discord_token".path})

        ${madamoiselle}/bin/madamoiselle
      '';
    };

    sops.secrets."madamoiselle/discord_token" = {
      restartUnits = ["madamoiselle.service"];
    };
    environment.systemPackages = [madamoiselle];
    environment.etc."madamoiselle.toml".source = ./madamoiselle.toml;
    environment.persistence."/nix/persist".files = ["/var/lib/madamoiselle/madamoiselle.db"];
  };
}
