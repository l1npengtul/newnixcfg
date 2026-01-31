{
  config,
  osConfig,
  ...
}: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    #     key = config.sops.secrets."syncthing/key".path;
    #     cert = config.sops.secrets."syncthing/cert".path;
    tray.enable = true;
    settings = {
      devices = {
        "clubcyberia".id = "2MCEZGX-MZ4MYMV-SW5RSO7-NDLJWAL-FVEMON7-T2ADAL6-ZVYI2CF-CQPE4QS";
        "wiltshire".id = "5DVZIJY-JVDCANH-PGOZVVI-F5OG5EU-QQKMVXK-NA7CUUH-L3YOWGT-DI7QQAX";
      };
      folders = {
        "Documents" = {
          path = "/home/l1npengtul/Documents";
          devices = [
            "wiltshire"
            {
              name = "clubcyberia";
              encryptionPasswordFile = config.sops.secrets."syncthing/decrypt".path;
            }
          ];
        };
      };
    };
  };
  sops.secrets = {
    "syncthing/key" = {
      sopsFile = ./. + "/../secrets/${osConfig.networking.hostName}.yaml";
    };
    "syncthing/cert" = {
      sopsFile = ./. + "/../secrets/${osConfig.networking.hostName}.yaml";
    };
    "syncthing/password" = {
      sopsFile = ./../secrets/syncthing.yaml;
    };
    "syncthing/decrypt" = {
      sopsFile = ./../secrets/syncthing.yaml;
    };
  };
  systemd.user.services.syncthing.Unit.After = ["sops-nix.service"];
}
