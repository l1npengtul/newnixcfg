{pkgs, ...}: {
  services.protonmail-bridge.enable = true;
  environment.systemPackages = with pkgs; [protonmail-bridge-gui];
}
