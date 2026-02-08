{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
  ];

  time.timeZone = inputs.shhh.systems.garganta;

  networking.hostName = "garganta";
  networking.firewall.enable = true;

  system.stateVersion = "25.11";
}
