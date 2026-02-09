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
    group = "${username}";
    extraGroups = [
      "syncthing"
    ];
  };
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    key = config.sops.secrets."syncthing-key".path;
    cert = config.sops.secrets."syncthing-cert".path;
    user = username;
    guiAddress = syc.gui-port;
    guiPasswordFile = config.sops.secrets."syncthing/password".path;
    openDefaultPorts = true;
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

  sops.secrets."syncthing-key" = {
    sopsFile = "${shhh}/syncthing-keys/${config.networking.hostName}/key.pem";
    format = "binary";
    owner = "${username}";
  };
  sops.secrets."syncthing-cert" = {
    sopsFile = "${shhh}/syncthing-keys/${config.networking.hostName}/cert.pem";
    format = "binary";
    owner = "${username}";
  };
  sops.secrets."syncthing/password" = {
    sopsFile = "${shhh}/syncthing.yaml";
    owner = "${username}";
  };
  sops.secrets."syncthing/decrypt" = {
    sopsFile = "${shhh}/syncthing.yaml";
    owner = "${username}";
  };
}
