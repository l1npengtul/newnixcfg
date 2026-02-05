{
  inputs,
  config,
  username ? inputs.shhh.systems.username,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
  syc = inputs.shhh.services.syncthing;
in {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    key = config.sops.secrets."syncthing/key".path;
    cert = config.sops.secrets."syncthing/cert".path;
    user = username;
    guiAddress = syc.gui-port;
    guiPasswordFile = config.sops.secrets."syncthing/password".path;
    settings = {
      devices = syc.devices;
      folders = (
        syc.folders {
          username = username;
          secret = config.sops.secrets."syncthing/decrypt".path;
        }
      );
      gui = {
        user = username;
      };
    };
  };
  sops.secrets = {
    "syncthing/key" = {
      sopsFile = "${shhh}/${config.networking.hostName}.yaml";
    };
    "syncthing/cert" = {
      sopsFile = "${shhh}/${config.networking.hostName}.yaml";
    };
    "syncthing/password" = {
      sopsFile = "${shhh}/syncthing.yaml";
    };
    "syncthing/decrypt" = {
      sopsFile = "${shhh}/syncthing.yaml";
    };
  };
}
