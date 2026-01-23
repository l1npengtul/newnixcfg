{
  inputs,
  pkgs,
  ...
}: {
  xdg.configFile.REAPER = {
    recursive = true;
    source = pkgs.symlinkJoin {
      name = "reapkgs";
      paths = with inputs.reapkgs-known.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
        birdbird-reascript-testing."BirdBird_Global Sampler.lua"
        birdbird-reascript-testing."BirdBird_Parameter History.lua"
        birdbird-reascript-testing."BirdBird_FX Inspector.lua"
        rejj."ReEQ.jsfx"
        saike-tools."Amaranth.jsfx"
        saike-tools."saike_abyss.jsfx"
        saike-tools."Saike_Morph.jsfx"
        saike-tools."saike_smooth.jsfx"
        saike-tools."saike_duskverb.jsfx"
        saike-tools."saike_nostalgizer.jsfx"
        saike-tools."saikedrums.jsfx"
        saike-tools."saike_partials.jsfx"
        saike-tools."saike_bric_a_brac.jsfx"
        saike-tools."Swellotron.jsfx"
        saike-tools."Reflectosaurus.jsfx"
        saike-tools."Saike_FMFilter2.jsfx"
        saike-tools."saike_lava.jsfx"
        saike-tools."SatanVerb.jsfx"
        saike-tools."Filther.jsfx"
        saike-tools."StereoSpectrumSplit.jsfx"
        saike-tools."StereoManipulator.jsfx"
        saike-tools."SaikeMultiSpectralAnalyzer_MK2.jsfx"
        saike-tools."Saike_Yutani.jsfx"
        saike-tools."Saike Stereo Bub III.jsfx"
        saike-tools."Transience.jsfx"
        saike-tools."Tight_Compressor.jsfx"
        saike-tools."ToneStacks.jsfx"
        saike-tools."BandSplitter.jsfx"
      ];
    };
  };

  home.file.sws-extension = {
    source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
    target = ".config/REAPER/UserPlugins/reaper_sws-x86_64.so";
  };

  home.file.sws-script1 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
    target = ".config/REAPER/Scripts/sws_python.py";
  };

  home.file.sws-script2 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";
    target = ".config/REAPER/Scripts/sws_python64.py";
  };

  home.file.reapack = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
    target = ".config/REAPER/UserPlugins/reaper_reapack-x86_64.so";
  };

  home.file.reapertips = {
    source = ./reapertips/02_Theme/reapertips.ReaperThemeZip;
    target = ".config/REAPER/ColorThemes/reapertips.ReaperThemeZip";
  };

  home.file.reapertipstoolbars = {
    source = ./toolbar_icons;
    target = ".config/REAPER/Data/toolbar_icons";
    recursive = true;
  };

  home.file.reapertips-saturated-sws-color = {
    source = ./reapertips-colors/Mac-Saturated.SWSColor;
    target = ".config/REAPER/";
  };

  home.file.reapertipslibswell = {
    source = ./reapertips/libSwell-user.colortheme;
    target = ".config/REAPER/libSwell-user.colortheme";
  };
}
