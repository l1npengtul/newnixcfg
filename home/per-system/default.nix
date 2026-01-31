{config, ...}: {
  imports = [
    (./. + "${config.networking.hostName}.nix")
  ];
}
