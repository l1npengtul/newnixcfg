{
  pkgs,
  config,
  ...
}: let
  gearmulator = pkgs.stdenvNoCC.mkDerivation {
    pname = "gearmulator";
    version = "0unstable-6767";
    src = config.sops.secrets."gearmulator.zip".path;

    nativeBuildInputs = [pkgs.unzip];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runPhase preInstall

      cp -r gearmulator-roms/* $out

      runPhase postInstall
    '';
  };
in {
  sops.secrets."gearmulator.zip" = {
    sopsFile = ./../../secrets/hm/gearmulator.zip;
    format = "binary";
  };

  xdg.dataFile."The Usual Suspects" = {
    recursive = true;
    source = pkgs.symlinkJoin {
      name = "gearmulator-roms";
      paths = [gearmulator];
    };
  };

  home.packages = with pkgs; [
    audacity
    audacious
    kdePackages.elisa
    kdePackages.audiotube
    kdePackages.k3b
    strawberry

    openutau
    kid3-cli
  ];
}
