{ ... }:
{
  services.flatpak = {
    enable = true;
    packages = [
      "at.vintagestory.VintageStory"
      "org.frescobaldi.Frescobaldi"
      "org.duckstation.DuckStation"
      "org.musescore.MuseScore"
      "com.usebottles.bottles"
      "com.logseq.Logseq"
    ];
  };
}
