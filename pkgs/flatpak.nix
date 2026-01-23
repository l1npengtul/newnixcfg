{...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "at.vintagestory.VintageStory"
      "org.frescobaldi.Frescobaldi"
      "org.duckstation.DuckStation"
      "com.kristianduske.TrenchBroom"
    ];
  };
}
