{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  pkg-config,
  alsa-lib,
  copyDesktopItems,
  makeDesktopItem,
  libX11,
  libXcomposite,
  libXcursor,
  libXinerama,
  libXrandr,
  libXtst,
  libXdmcp,
  libXext,
  xvfb,
  freetype,
  fontconfig,
  expat,
  libGL,
  libjack2,
  curl,
  ninja,
  writableTmpDirAsHomeHook,
  # Disable VST building by default, since NixOS doesn't have a VST license
  enableVST2 ? false,
}: let
  plugins = [
    "ABTester"
    "AddInvert"
    "ChannelMute"
    "CompensatedDelay"
    "Compressor"
    "Crossfeed"
    "Delay"
    "Expander"
    "Gate"
    "HugeGain"
    "Limiter"
    "Maths"
    "MidiLooper"
    "Oscilloscope"
    "PitchTrack"
    "SFX8"
    "SampleDelay"
    "SimpleVerb"
    "SpectrumAnalyzer"
    "StereoEnhancer"
    "StereoProcessor"
    "ToneGenerator"
    "WaveLooper"
    "XYScope"
  ];
  desktopItems =
    map (pl: (makeDesktopItem {
      type = "Application";
      name = "socalabs-${lib.toLower pl}";
      desktopName = "Socalabs ${pl}";
      comment = "Socalabs ${pl} Plugin (Standalone)";
      # only SFX8 has an icon
      exec = "${pl}";
      categories = [
        "Audio"
        "AudioVideo"
      ];
    }))
    plugins;
in
  stdenv.mkDerivation {
    pname = "socalabs-sfx8";
    version = "1.1.0";
    inherit desktopItems;

    src = fetchFromGitHub {
      owner = "FigBug";
      repo = "slPlugins";
      rev = "dc51ca3cc468e2fcead6ac0c2ba460f3f9c04176";
      hash = "";
      fetchSubmodules = true;
      preFetch = ''
        # can't clone using ssh
        export GIT_CONFIG_COUNT=1
        export GIT_CONFIG_KEY_0=url.https://github.com/.insteadOf
        export GIT_CONFIG_VALUE_0=git@github.com:
      '';
    };

    nativeBuildInputs = [
      cmake
      pkg-config
      copyDesktopItems
      ninja
      writableTmpDirAsHomeHook
    ];

    buildInputs = [
      alsa-lib
      libX11
      libXcomposite
      libXcursor
      libXinerama
      libXrandr
      libXtst
      libXdmcp
      libXext
      xvfb
      libGL
      libjack2
      freetype
      fontconfig
      expat
      curl
    ];

    cmakeFlags = [
      (lib.cmakeBool "JUCE_COPY_PLUGIN_AFTER_BUILD" false)
      "--preset ninja-gcc"
    ];

    postPatch = ''
      find plugins/ -name CMakeLists.txt -exec substituteInPlace {} --replace-fail 'FORMATS Standalone VST VST3 AU LV2' 'FORMATS Standalone ${lib.optionalString enableVST2 "VST"} VST3'
    '';

    strictDeps = true;

    preBuild = ''
      cd ../Builds/ninja-gcc
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/vst3 $out/bin

      ls

      install -Dm444 $src/plugin/Resources/logo.png $out/share/pixmaps/SFX8.png

      runHook postInstall
    '';

    NIX_LDFLAGS = (
      toString [
        "-lX11"
        "-lXext"
        "-lXcomposite"
        "-lXcursor"
        "-lXinerama"
        "-lXrandr"
        "-lXtst"
        "-lXdmcp"
      ]
    );

    meta = {
      description = "Socalabs SLPlugins";
      homepage = "https://socalabs.com/";
      platforms = lib.platforms.linux;
      license = [lib.licenses.gpl3] ++ lib.optional enableVST2 lib.licenses.unfree;
      maintainers = [lib.maintainers.l1npengtul];
    };
  }
