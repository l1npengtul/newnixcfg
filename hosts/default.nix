{config, ...}: {
  imports = [
    (./. + "${config.networking.hostName}")
  ];
}
