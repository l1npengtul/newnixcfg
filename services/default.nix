{...}: {
  imports = [
    ./libvirtd.nix
    ./tailscale.nix
    ./sshd.nix
  ];
}
