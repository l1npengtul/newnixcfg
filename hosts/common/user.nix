{
  inputs,
  config,
  pkgs,
  username ? "l1npengtul",
  ...
}:
let
  shhh = builtins.toString inputs.shhh;
in
{
  users.users."${username}" = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = inputs.shhh.services.ssh.authorized-keys;
    hashedPasswordFile = config.sops.secrets."passwords/${config.networking.hostName}".path;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
  };
  users.groups."${username}" = { };
  programs.fish.enable = true;
  nix.settings.trusted-users = [
    "@wheel"
    "root"
    "${username}"
  ];
  sops.age.sshKeyPaths = inputs.shhh.sops-ssh-paths;
  sops.secrets."passwords/${config.networking.hostName}" = {
    sopsFile = "${shhh}/secrets.yaml";
    neededForUsers = true;
  };
  security.sudo.wheelNeedsPassword = false;
}
