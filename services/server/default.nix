{...}: {
  imports = [
    ./defaults/audit.nix
    ./defaults/clamav.nix
    ./defaults/podman.nix
    ./defaults/cockpit.nix
    ./tailscale-persist.nix
  ];
}
