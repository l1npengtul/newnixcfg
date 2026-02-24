{
  inputs,
  pkgs,
  pkgs-stable,
  pkgs-master,
  ...
}:
let
  #organ = pkgs.callPackage ./socalabs/organ.nix {};
  #piano = pkgs.callPackage ./socalabs/piano.nix {};
  #slplugins = pkgs.callPackage ./socalabs/slplugins.nix {};
  #wavetable = pkgs.callPackage ./socalabs/wavetable.nix {};
  treetable = pkgs.callPackage ./demucs/treetable.nix { };
  submitit = pkgs.callPackage ./demucs/submitit.nix { };
  dora-search = pkgs.callPackage ./demucs/dora-search.nix {
    treetable = treetable;
    submitit = submitit;
  };
  lameenc = pkgs.callPackage ./demucs/lameenc.nix { };
  openunmix = pkgs.python3Packages.callPackage ./demucs/openunmix.nix { };
  demucs = pkgs.callPackage ./demucs/demucs.nix {
    openunmix = openunmix;
    lameenc = lameenc;
    dora-search = dora-search;
  };
  libswell = pkgs.callPackage ./libswell { };
  paulxstretch = pkgs.callPackage ./paulxstretch.nix { };
  ripplerx = pkgs.callPackage ./ripplerx.nix { };
  #grainbow = pkgs.callPackage ./grainbow {};
  #   synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro {};
  recstar = pkgs.callPackage ./recstar { };
  nn = pkgs.callPackage ./neuralnote.nix { };
  #musescore-evolution = pkgs.callPackage ./musescore-evolution.nix {};
  #surgext = pkgs.callPackage ./surgext-nightly.nix {};
  #vvital = pkgs.callPackage ./vital.nix {};
in
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    odin2
    surge-XT
    lsp-plugins
    qpwgraph
    dexed
    setbfree
    zynaddsubfx
    audacity
    musescore
    #musescore-evolution
    paulstretch
    zam-plugins
    chow-tape-model
    vcv-rack
    cardinal
    alsa-utils
    vital
    distrho-ports
    bitwig-studio
    yabridgectl
    yabridge
    wineWow64Packages.stagingFull
    dxvk_2
    #recstar
    plugdata
    #dl-librescore
    carla
    (reaper.overrideAttrs (prev: {
      postInstall = (prev.postInstall or "") + ''
        rm $out/opt/REAPER/libSwell.so
        ln -s ${libswell}/lib/libSwell.so $out/opt/REAPER/libSwell.so
      '';
    }))
    reaper-sws-extension
    reaper-reapack-extension

    airwindows
    airwin2rack
    socalabs-sid
    socalabs-sn76489
    socalabs-papu
    socalabs-rp2a03
    socalabs-voc
    #organ
    #wavetable
    #piano
    #slplugins
    decent-sampler
    friture

    flac

    #demucs

    sfizz
    linuxsampler

    #sonic-visualiser

    paulxstretch
    ripplerx
    #grainbow
    inputs.audio.packages.${pkgs.stdenv.hostPlatform.system}.atlas2
    nn
  ];
}
