{
  inputs,
  config,
  ...
}:
let
  syc = inputs.shhh.services.syncthing;
  username = syc.user."${config.networking.hostName}";
in
{
  environment.persistence."/nix/persist".directories = [
    {
      directory = "/home/${
        inputs.shhh.services.syncthing.user."${config.networking.hostName}"
      }/Documents";
      user = username;
      group = "syncthing";
      mode = "u=rw,g=rw,o=rw";
    }
    {
      directory = "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Pictures";
      user = username;
      group = "syncthing";
      mode = "u=rw,g=rw,o=rw";
    }
    {
      directory = "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}/Music";
      user = username;
      group = "syncthing";
      mode = "u=rw,g=rw,o=rw";
    }
    {
      directory = "/home/${
        inputs.shhh.services.syncthing.user."${config.networking.hostName}"
      }/.local/share/bottles/bottles/plugins/drive_c";
      user = username;
      group = "syncthing";
      mode = "u=rw,g=rw,o=rw";
    }
    {
      directory = "/home/${inputs.shhh.services.syncthing.user."${config.networking.hostName}"}";
      user = username;
      group = "syncthing";
      mode = "u=rw,g=rw,o=rw";
    }
  ];
  users.users."${username}" = {
    createHome = true;
    isSystemUser = true;
  };
  users.groups."${username}" = { };
}
