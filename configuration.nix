{pkgs, ...}: {
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      socketActivation = true;
    };
    libinput.enable = true;
    fwupd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    git-lfs
    sof-firmware
    unzip
    p7zip
    pciutils
    usbutils
    nmap
    firefox
  ];

  environment.pathsToLink = [
    "/bin"
    "/lib"
    "/lib64"
    "/etx/xdg"
    "/sbin"
    "/share/applications"
    "/share/emacs"
    "/share/hunspell"
    "/share/nano"
    "/share/org"
    "/share/themes"
    "/share/vim-plugins"
    "/share/vulkan"
    "/share/kservices5"
    "/share/kservicetypes5"
    "/share/kxmlgui5"
    "/share/systemd"
    "/share/thumbnailers"
    "/share/xdg-desktop-portal"
    "/share/qemu"
    "/sys"
  ];

  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };

  boot = {
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };
  security.polkit.enable = true;
}
