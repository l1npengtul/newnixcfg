{...}: {
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-7 days";
  };

  sops.age.sshKeyFiles = ["/etc/ssh/ssh_host_ed25519_key"];

  home.stateVersion = "25.11";
}
