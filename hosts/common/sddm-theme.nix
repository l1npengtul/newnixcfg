{
  lib,
  formats,
  stdenvNoCC,
  fetchgit,
  /*
  An example of how you can override the background with a NixOS wallpaper
  *
  *  environment.systemPackages = [
  *    (pkgs.elegant-sddm.override {
  *      themeConfig.General = {
           background = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
  *      };
  *    })
  *  ];
  */
  themeConfig ? null,
}: let
  user-cfg = (formats.ini {}).generate "theme.conf.user" themeConfig;
in
  stdenvNoCC.mkDerivation {
    pname = "sddm-reactionary";
    version = "unstable-2024-02-08";

    src = fetchgit {
      url = "https://www.opencode.net/phob1an/reactionary.git";
      rev = "4aa2d20f0e93ae4387a90947fcc6c90940c18122";
      hash = "sha256-obKYi85SEMSvoF9KY8TbU02mag57yr/03TvNNNa67N0=";
    };

    dontWrapQtApps = true;

    installPhase =
      ''
        runHook preInstall

        mkdir -p "$out/share/sddm/themes"
        cp -r sddm/themes/reactionary "$out/share/sddm/themes/reactionary"
      ''
      + (lib.optionalString (lib.isAttrs themeConfig) ''
        ln -sf ${user-cfg} $out/share/sddm/themes/reactionary/theme.conf.user
      '')
      + ''
        runHook postInstall
      '';
    meta = {
      description = "Reactionary SDDM Theme";
      homepage = "https://www.opencode.net/phob1an/reactionary";
      license = lib.licenses.gpl3;
      maintainers = with lib.maintainers; [l1npengtul];
    };
  }
