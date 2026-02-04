{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
  ];

  time.timeZone = inputs.shhh.systems.omvdijan;

  networking.hostName = "omvdijan";
  networking.firewall.enable = true;

  system.stateVersion = "25.11";
}
