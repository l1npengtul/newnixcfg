{ pkgs, lib, ... }:
{
  users.users.restic = {
    group = "restic";
    isSystemUser = true;
  };
  users.group.restic = { };

  security.wrappers.restic = {
    source = lib.getExe pkgs.restic;
    owner = "restic";
    group = "restic";
    permissions = "500"; # or u=rx,g=,o=
    capabilities = "cap_dac_read_search+ep";
  };

}
