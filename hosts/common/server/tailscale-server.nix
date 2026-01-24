{...}: {
  services.tailscale-connect = {
    enable = true;
    side = "server";
  };
}
