{
  pkgs,
  config,
  ...
}: let
  gearmulator = pkgs.stdenvNoCC.mkDerivation {
    src = config.sops.secrets.gearmulator.path;

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
  sops.secrets.gearmulator = {
    sopsFile = ./../secrets/hm/gearmulator.zip;
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
