{
  inputs,
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
    openssh.authorizedKeys.keys = inputs.shhh.services.ssh.authorized-keys;
  };
  programs.fish.enable = true;
  nix.settings.trusted-users = [
    "@wheel"
    "root"
    "${username}"
  ];
  sops.age.sshKeyPaths = inputs.shhh.sops-ssh-paths;
}
