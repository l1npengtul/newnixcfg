{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./tailscale-client.nix
    (import ./user.nix {
      inherit inputs pkgs config;
      username = inputs.shhh.systems.username;
    })
    (import ./user-groups.nix {
      username = inputs.shhh.systems.username;
    })
    ./kde.nix
    ./audio.nix
    ./default.nix
    ./fwupd.nix
    ./libinput.nix
  ];
}
