{...}: {
  environment.persistence."/nix/persist".directories = [
    {
      directory = "/var/lib/tailscale";
      mode = "u=rw,g=r,o=";
    }
  ];
}
