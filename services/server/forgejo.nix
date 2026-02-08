{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
  shhh = builtins.toString inputs.shhh;
  fjc = inputs.shhh.services.forgejo;
in
{
  services.forgejo = {
    enable = true;
    database.type = fjc.db_type;
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = fjc.domain;
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = fjc.http_port;
      };
      service.DISABLE_REGISTRATION = true;
      actions = {
        ENABLED = true;
      };
      "cron.sync_external_users" = {
        RUN_AT_START = true;
        SCHEDULE = "@every 24h";
        UPDATE_EXISTING = true;
      };
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";
        SMTP_ADDR = fjc.smtp_addr;
        SMTP_PORT = fjc.mailer_port;
        FROM = "noreply@$${fjc.domain}";
        USER = fjc.smtp_user;
      };
    };
    secrets = {
      mailer.PASSWD = config.sops.secrets.forgejo-mailer-password.path;
    };
  };

  sops.secrets.forgejo-mailer-password = {
    sopsFile = "${shhh}/forgejo.yaml";
    owner = "forgejo";
  };
  sops.secrets.forgejo-admin-password = {
    sopsFile = "${shhh}/forgejo.yaml";
    owner = "forgejo";
  };

  services.caddy.virtualHosts."${srv.DOMAIN}".extraConfig = ''
    tls {
      dns cloudflare {env.CF_API_KEY}
    }
    reverse_proxy localhost:${builtins.toString fjc.http_port}
  '';

  environment.persistence."/nix/persist".directories = [
    {
      directory = "/var/lib/forgejo";
      user = "forgejo";
      mode = "u=rw,g=r,o=";
    }
  ];

  systemd.services.forgejo.preStart =
    let
      adminCmd = "${lib.getExe cfg.package} admin user";
      pwd = config.sops.secrets.forgejo-admin-password;
      user = fjc.admin;
    in
    ''
      ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
    '';
}
