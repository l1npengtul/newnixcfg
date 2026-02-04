{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./tailscale-client.nix
    (import ./user.nix {
      inherit inputs pkgs;
      username = inputs.shhh.sys-username;
    })
    ./hardware/gpu.nix
    ./kde.nix
  ];
}
