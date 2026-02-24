{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ udftools ];
  boot.initrd.kernelModules = [ "udf" ];
}
