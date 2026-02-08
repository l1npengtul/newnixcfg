{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cockpit];

  services.cockpit = {
    enable = true;
  };
}
