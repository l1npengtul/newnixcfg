{ pkgs, ... }:
let
  dwproton = pkgs.callPackage ./dwproton.nix { };
in
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
    extraCompatPackages = [ dwproton ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = [
      (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };

  environment.systemPackages = with pkgs; [
    r2modman
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
      ];
    })
  ];

  hardware.steam-hardware.enable = true;
}
