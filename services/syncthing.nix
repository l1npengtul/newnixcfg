{
  inputs,
  lib,
  config,
  osConfig,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
  syc = inputs.shhh.services.syncthing;
  usr = inputs.shhh.systems.username;
in {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    key = config.sops.secrets."syncthing/key".path;
    cert = config.sops.secrets."syncthing/cert".path;
    user = usr;
    guiAddress = syc.gui-port;
    guiPasswordFile = config.sops.secrets."syncthing/password".path;
    settings = {
      devices = syc.devices;
      folders = lib.mergeAttrsList syc.fldrs {
        username = usr;
        secret = config.sops.secrets."syncthing/decrypt".path;
        secreted = ["clubcyberia"];
        no_secret = ["wiltshire"];
      };
      gui = {
        user = usr;
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
