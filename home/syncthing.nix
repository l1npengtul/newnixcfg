{
  inputs,
  config,
  osConfig,
  pkgs,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    key = config.sops.secrets."syncthing/key".path;
    cert = config.sops.secrets."syncthing/cert".path;
    settings = {
      devices = {
        "clubcyberia".id = inputs.shhh.syncthing-device-ids.clubcyberia;
        "wiltshire".id = inputs.shhh.syncthing-device-ids.wiltshire;
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
      sopsFile = "${shhh}/${osConfig.networking.hostName}.yaml";
    };
    "syncthing/cert" = {
      sopsFile = "${shhh}/${osConfig.networking.hostName}.yaml";
    };
    "syncthing/password" = {
      sopsFile = "${shhh}/syncthing.yaml";
    };
    "syncthing/decrypt" = {
      sopsFile = "${shhh}/syncthing.yaml";
    };
  };
}
