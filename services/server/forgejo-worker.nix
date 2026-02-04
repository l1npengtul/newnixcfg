{
  inputs,
  pkgs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = "${config.networking.hostName}-default-monolith";
      url = "https://${inputs.shhh.services.forgejo.domain}";
      tokenFile = config.sops.secrets."forgejo-${config.networking.hostName}-runner-token".path;
      labels = [
        "ubuntu-latest:docker://node:25-bookworm"
        "ubuntu-22.04:docker://node:25-bookworm"
        "ubuntu-20.04:docker://node:16-bullseye"
        "ubuntu-18.04:docker://node:16-buster"
      ];
    };
  };
  config.sops.secrets."forgejo-${config.networking.hostName}-runner-token" = {
    sopsFile = "${shhh}/forgejo.yaml";
  };
}
