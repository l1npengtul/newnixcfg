{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # nix utilities
    nil
    nixfmt
    alejandra
    nixfmt-tree
    patchelfUnstable
    file
    nix-prefetch-github
    nixpkgs-review
    nix-update
    nix-du
    deploy-rs
    nix-prefetch
    nix-prefetch-scripts
    agenix-cli
    nixos-anywhere
    # system utilities
    dpkg
    binutils
    upx
    tmux
    popsicle
    hyfetch
    zenith
    onefetch
    exfat
    exfatprogs
    xfsprogs
    f3
    mesa-demos
    freshfetch
    micro-full
    fishPlugins.grc
    #     zgrviewer
    fd
    dmg2img
    ipmicfg
    ipmiview
    adoptopenjdk-icedtea-web
    ssh-to-pgp
    ssh-to-age
    age
    sops
    openssl
    woeusb-ng
    minicom
    ntfs3g
    p7zip
    p7zip-rar
    unar
    yq
    f3
    grabserial
    ripgrep-all
    ripgrep
    git-lfs
    sof-firmware
    unzip
    p7zip
    pciutils
    usbutils
    nmap
    firefox
  ];
  programs.nix-index-database.comma.enable = true;
}
