{...}: {
  services.tailscale-autoconnect = {
    enable = true;
    side = "server";
  };
}
