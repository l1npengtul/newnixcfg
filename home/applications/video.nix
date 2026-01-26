{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    libdvdcss
    libaacs
    vobcopy
    makemkv
    #     handbrake
    libbluray
    vlc
    avidemux
    mplayer
    mkvtoolnix
    ffmpeg-full
  ];
}
