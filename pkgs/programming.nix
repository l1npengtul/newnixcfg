{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3
    zulu
    jdk8
  ];
}
