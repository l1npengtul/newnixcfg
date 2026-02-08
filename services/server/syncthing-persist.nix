{
  inputs,
  config,
  ...
}: let
  syc = inputs.shhh.services.syncthing;
  username = syc.user."${config.networking.hostName}";
in {
  environment.persistence."/nix/persist".files = [
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Documents"
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Pictures"
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Music"
  ];
  users.users."${username}" = {
    createHome = true;
    isSystemUser = true;
  };
  users.groups."${username}" = {};
}
