{
  lib,
  stdenvNoCC,
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
  writeShellScript,
  bubblewrap,
  mktemp,
}:
let
  rpgmtranslate-qt-unwrapped = clangStdenv.mkDerivation (finalAttrs: {
    pname = "rpgmtranslate-qt-unwrapped";
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
  });
in
stdenvNoCC.mkDerivation {
  pname = "rpgmtranslate-qt";
  inherit (rpgmtranslate-qt-unwrapped) version;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  installPhase =
    let
      wrapper = writeShellScript "rpgmtranslate-qt" ''
        set -e

        echo "Creating temporary directory"
        TMPDIR=$(${mktemp}/bin/mktemp --directory)
        echo "Temporary directory: $TMPDIR"
        echo "Copying default Vamp Plugin settings"
        cp -r ${rpgmtranslate-qt-unwrapped}/libexec/resources/VampTransforms $TMPDIR
        echo "Changing permissions to be writable"
        chmod -R u+w $TMPDIR/VampTransforms

        echo "Starting Bitwig Studio in Bubblewrap Environment"
        ${bubblewrap}/bin/bwrap \
          --bind / / \
          --bind $TMPDIR/VampTransforms ${rpgmtranslate-qt-unwrapped}/libexec/resources/VampTransforms \
          --dev-bind /dev /dev \
          ${rpgmtranslate-qt-unwrapped}/bin/bitwig-studio \
          || true

        echo "Bitwig exited, removing temporary directory"
        rm -rf $TMPDIR
      '';
    in
    ''
      mkdir -p $out/bin
      cp ${wrapper} $out/bin/bitwig-studio
      cp -r ${rpgmtranslate-qt-unwrapped}/share $out
    '';

}
