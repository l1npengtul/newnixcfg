{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./firewall.nix
    ./forgor.nix
    ./nix.nix
    ./noexec.nix
    ./systemd.nix
    ./remote-unlock.nix
    ./tailscale-server.nix
    (import ./../user.nix {
      inherit inputs pkgs;
      username = inputs.shhh.systems.username;
    })
  ];
}
