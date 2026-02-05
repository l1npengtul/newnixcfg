{
  inputs,
  config,
  ...
}: {
  import = [
    (import ./syncthing-base.nix {
      inherit inputs config;
    })
  ];
}
