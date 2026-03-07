{ pkgs, ... }:
let
  version = "2025.4";
  pname = "trenchbroom";

  src = ./TrenchBroom.AppImage;
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;
}
