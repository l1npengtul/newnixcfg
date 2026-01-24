{...}: {
  imports = [
    ./tailscale.nix
  ];

  services.connect-to-tailscale.enable = true;
}
