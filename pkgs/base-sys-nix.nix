{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # nix utilities
    nixfmt-tree
    nix-update
    nix-du
    nix-prefetch
    nix-prefetch-scripts
    # system utilities
    binutils
    tmux
    zenith
    micro-full
    fishPlugins.grc
    ssh-to-age
    sops
    openssl
    p7zip-rar
    unar
    ripgrep-all
    ripgrep
    unzip
    pciutils
  ];
}
