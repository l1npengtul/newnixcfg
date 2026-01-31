{config, ...}: let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in {
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.l1npengtul.lol";
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
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
        SMTP_PORT = 465;
        FROM = "noreply@$git.l1npengtul.lol";
        USER = "forgejo-git";
      };
    };
    secrets = {
      mailer.PASSWD = config.sops.secrets.forgejo-mailer-password.path;
    };
  };

  sops.secrets.forgejo-mailer-password = {
    file = ../secrets/services/forgejo.yaml;
    owner = "forgejo";
  };

  environment.persistence."/nix/persist".files = ["/var/lib/forgejo"];
}
