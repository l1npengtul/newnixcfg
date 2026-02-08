{lib, ...}: {
  services.xserver.enable = lib.mkForce false;
}
