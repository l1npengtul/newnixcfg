{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    anki-bin
    logseq
    qownnotes
    qc
  ];
}
