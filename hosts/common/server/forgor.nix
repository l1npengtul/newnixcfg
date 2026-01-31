{...}: {
  environment.persistence."/nix/persist" = {
    hideMounts = true;

    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/systemd/coredump"
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/passwd"
    ];
  };

  systemd.services.nix-daemon = {
    environment = {
      # Location for temporary files
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # Create /var/cache/nix automatically on Nix Daemon start
      CacheDirectory = "nix";
    };
  };
}
