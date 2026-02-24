{ pkgs, pkgs-stable, ... }:
{
  home.packages = with pkgs; [
    mpv
    libdvdcss
    libaacs
    vobcopy
    pkgs-stable.makemkv
    #     handbrake
    libbluray
    vlc
    avidemux
    mplayer
    mkvtoolnix
    ffmpeg-full
  ];
}
