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
      username = "l1npengtul";
    })
    ./hardware/printer.nix
    ./hardware/gpu.nix
    ./kde.nix
  ];
}
