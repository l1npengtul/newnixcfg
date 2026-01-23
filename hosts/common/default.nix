{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./tailscale-client.nix
    (import ./user.nix {
      inherit pkgs;
      username = "l1npengtul";
    })
    ./hardware/printer.nix
    ./hardware/gpu.nix
  ];
}
