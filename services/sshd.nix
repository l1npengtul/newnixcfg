{inputs, ...}: {
  services.openssh = {
    enable = true;
    ports = [inputs.shhh.services.ssh.port];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
}
