{...}: {
  imports = [
    ./libvirtd.nix
    ./tailscale.nix
    ./sshd.nix
    ./syncthing/devices.nix
  ];
}
