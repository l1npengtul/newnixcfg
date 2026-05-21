{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    anki-bin
    qownnotes
    qc
  ];
}
