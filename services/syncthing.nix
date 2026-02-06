{
  inputs,
  config,
  ...
}: let
  shhh = builtins.toString inputs.shhh;
in {
  import = [
    (import ./syncthing-base.nix {
      inherit inputs config;
    })
  ];

  sops.secrets."syncthing-key" = {
    sopsFile = "${shhh}/${config.networking.hostName}.yaml";
  };
  sops.secrets."syncthing-cert" = {
    sopsFile = "${shhh}/${config.networking.hostName}.yaml";
  };
  sops.secrets."syncthing/password" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
  sops.secrets."syncthing/decrypt" = {
    sopsFile = "${shhh}/syncthing.yaml";
  };
}
