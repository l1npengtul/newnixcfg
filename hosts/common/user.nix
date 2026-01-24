{
  pkgs,
  username ? "l1npengtul",
  ...
}: {
  users.users."${username}" = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "libvirtd"
      "jackaudio"
      "adbusers"
      "kvm"
      "scanner"
      "lp"
      "cdrom"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBITwQ7bUgxNBYdQFzWjRQkg9NW9s646icQZ/ifVitD4 l1npengtul@protonmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbe88oJjlFPbgN4pn4v5cdAWGEDiOiwQnEpTXPzSaYS l1npengtul@protonmail.com"
    ];
  };
  programs.fish.enable = true;
  nix.settings.trusted-users = [
    "@wheel"
    "root"
    "${username}"
  ];
  sops.age.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/${username}/.ssh/id_ed25519.pub"
  ];
}
