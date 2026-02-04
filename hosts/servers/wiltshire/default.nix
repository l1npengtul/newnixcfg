{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
  ];

  time.timeZone = inputs.shhh.systems.tz.wiltshire;

  networking.hostName = "wiltshire";
  networking.firewall.enable = true;

  system.stateVersion = "25.11";
}
