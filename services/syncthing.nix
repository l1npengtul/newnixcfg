{
  inputs,
  config,
  ...
}: {
  import = [
    (import ./syncthing-base.nix {
      inherit inputs config;
      username = inputs.shhh.systems.username;
    })
  ];
}
