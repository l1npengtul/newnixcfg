{
  inputs,
  config,
  username,
}: let
  shhh = builtins.toString inputs.shhh;
  syc = inputs.shhh.services.syncthing;
in {
  sops.secrets."syncthing/key" = {
    sopsFile = "${shhh}/${config.networking.hostName}.yaml";
  };
  sops.secrets."syncthing/cert" = {
    sopsFile = "${shhh}/${config.networking.hostName}.yaml";
  };
  sops.secrets."syncthing/password" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
  sops.secrets."syncthing/decrypt" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };

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
}
