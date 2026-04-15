{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt6,
  libarchive,
  magic-enum,
  nuspell,
  ffmpeg,
  miniaudio,
  libgit2,
  languagetool,
  openssl,
}:
let
  rapidhash = stdenv.mkDerivation {
    pname = "rapidhash";
    version = "3";

    src = fetchFromGitHub {
      owner = "Nicoshev";
      repo = "rapidhash";
      tag = "rapidhash_v3";
      hash = lib.fakeHash;
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runPhase preInstall

      mkdir $out/include
      cp -r $src $out/include

      runPhase postInstall
    '';

  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "rpgmtranslate-qt";
  version = "1.0.0-rc.5";

  src = fetchFromGitHub {
    owner = "RPG-Maker-Translation-Tools";
    repo = "${finalAttrs.pname}";
    tag = "v${finalAttrs.version}";
    hash = lib.fakeHash;
  };

  buildInputs = [
    libarchive
    magic-enum
    qt6.qtbase
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtmultimedia
    qt6.qttranslations
    qt6.qtutilities
    nuspell
    ffmpeg
    miniaudio
    libgit2
    rapidhash
    languagetool
    openssl
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.wrapQtAppsHook
  ];

  cmakeFlags = [
    (lib.cmakeFeature "CMAKE_INSTALL_INCLUDEDIR" "include")
    (lib.cmakeFeature "CMAKE_INSTALL_LIBDIR" "lib")
  ];

})
