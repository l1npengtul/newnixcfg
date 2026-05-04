{
  lib,
  clangStdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt6,
  libarchive,
  magic-enum,
  nuspell,
  ffmpeg,
  libgit2,
  languagetool,
  openssl,
  rustPlatform,
  cargo,
  rustc,
  corrosion,
  rust-cbindgen,
  makeDesktopItem,
  copyDesktopItems,
}:
clangStdenv.mkDerivation (finalAttrs: {
  pname = "rpgmtranslate-qt";
  version = "1.0.0-rc.6";

  src = fetchFromGitHub {
    owner = "RPG-Maker-Translation-Tools";
    repo = "${finalAttrs.pname}";
    tag = "v${finalAttrs.version}";
    hash = "sha256-BELD3RpMF+S0PZZUjgf/s1gunQN0ez1eLnA3UQdNsZs=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  patches = [
    ./use-local-corrosion.patch
  ];

  desktopItems = [
    (makeDesktopItem {
      type = "Application";
      name = "rpgmtranslate-qt";
      desktopName = "RPGMTranslate QT";
      comment = "RPG Maker Game Translation Tool";
      exec = "rpgmtranslate";
      categories = [
        "Game"
        "Utility"
      ];
    })
  ];

  buildInputs = [
    libarchive
    magic-enum
    qt6.qtbase
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtmultimedia
    qt6.qttranslations
    qt6.qtdeclarative
    qt6.qttools
    nuspell
    ffmpeg
    languagetool
    openssl
    libgit2
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.wrapQtAppsHook
    qt6.qttools
    rustPlatform.cargoSetupHook
    rustPlatform.bindgenHook
    cargo
    rustc
    corrosion
    rust-cbindgen
    copyDesktopItems
  ];

  env.RUSTFLAGS = "-C target-feature=+aes,+sse2";

  cmakeFlags = [
    (lib.cmakeBool "ENABLE_LIBGIT2" false)
  ];

  qtWrapperArgs = [ "--prefix $RPGMTRANSLATE_DATA_DIR : \"$XDG_STATE_HOME/rpgmtranslate-qt" ];
})
