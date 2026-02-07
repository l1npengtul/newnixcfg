{
  inputs,
  config,
  ...
}: {
  environment.persistence."/nix/persist".files = [
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Documents"
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Pictures"
    "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Music"
  ];
}
