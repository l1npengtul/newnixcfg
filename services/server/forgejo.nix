{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
  shhh = builtins.toString inputs.shhh;
in {
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.l1npengtul.lol";
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = inputs.shhh.ports.forgejo.http;
      };
      service.DISABLE_REGISTRATION = true;
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";
        SMTP_ADDR = "mail.smtp2go.com";
        SMTP_PORT = inputs.shhh.ports.forgejo.http;
        FROM = "noreply@$git.l1npengtul.lol";
        USER = "forgejo-git";
      };
    };
    secrets = {
      mailer.PASSWD = config.sops.secrets.forgejo-mailer-password.path;
    };
  };

  sops.secrets.forgejo-mailer-password = {
    file = "${shhh}/forgejo.yaml";
    owner = "forgejo";
  };
  sops.secrets.forgejo-admin-password = {
    file = "${shhh}/forgejo.yaml";
    owner = "forgejo";
  };

  environment.persistence."/nix/persist".files = ["/var/lib/forgejo"];

  systemd.services.forgejo.preStart = let
    adminCmd = "${lib.getExe cfg.package} admin user";
    pwd = config.sops.secrets.forgejo-admin-password;
    user = inputs.shhh.sevices.forgejo.admin;
  in ''
    ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
  '';
}
