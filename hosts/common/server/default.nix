{
  inputs,
  pkgs,
  config,
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
    ./headless.nix
    (import ./../user.nix {
      inherit inputs pkgs config;
      username = inputs.shhh.systems.username;
    })
  ];
}
