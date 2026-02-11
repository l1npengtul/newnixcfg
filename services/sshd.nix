{ inputs, config, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ inputs.shhh.services.ssh.port ];
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  users.users."root".openssh.authorizedKeys.keys =
    inputs.shhh.services.ssh.authorized-keys.system."${config.networking.hostName}";
}
