{
  inputs,
  config,
  ...
}: {
  import = [
    (import ./../syncthing-base.nix {
      inherit inputs config;
      username = inputs.shhh.services.syncthing.serveruser;
    })
  ];

  users.users."${inputs.shhh.services.syncthing.serveruser}" = {
    createHome = true;
    extraGroups = [
      "syncthing"
    ];
  };
}
