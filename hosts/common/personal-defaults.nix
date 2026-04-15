{ ... }:
{
  imports = [
    ./hardware/optical.nix
    #     ./music.nix
    (import ./extra-user-groups.nix { })
  ];
}
