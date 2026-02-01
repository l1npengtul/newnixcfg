{inputs, ...}: {
  services.openssh = {
    enable = true;
    ports = [inputs.shhh.ports.ssh];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [inputs.shhh.ports.ssh];
  };
}
