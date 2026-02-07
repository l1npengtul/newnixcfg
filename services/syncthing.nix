{
  inputs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
  syc = inputs.shhh.services.syncthing;
  username = syc.user."${config.networking.hostName}";
in {
  users.users."${username}" = {
    createHome = true;
    extraGroups = [
      "syncthing"
    ];
  };
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    key = config.sops.secrets."hosts/${config.networking.hostName}/key".path;
    cert = config.sops.secrets."hosts/${config.networking.hostName}/cert".path;
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

  sops.secrets."hosts/${config.networking.hostName}/key" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
  sops.secrets."hosts/${config.networking.hostName}/cert" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
  sops.secrets."syncthing/password" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
  sops.secrets."syncthing/decrypt" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
}
