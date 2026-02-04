{
  disko.devices = {
    disk = {
      one = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                ];
              };
            };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
      two = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
              };
            };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%";
            lvm_type = "mirror";
            content = {
              type = "btrfs";
              mountOptions = [
                "defaults"
              ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "subvol=root"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/home" = {
                  mountOptions = [
                    "subvol=home"
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/home";
                };
                "/nix" = {
                  mountOptions = [
                    "subvol=nix"
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "/nix/persist" = {
                  mountpoint = "/nix/persist";
                  mountOptions = [
                    "subvol=persist"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/log" = {
                  mountpoint = "/var/log";
                  mountOptions = [
                    "subvol=log"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/lib" = {
                  mountpoint = "/var/lib";
                  mountOptions = [
                    "subvol=lib"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/srv" = {
                  mountpoint = "/srv";
                  mountOptions = [
                    "subvol=srv"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/etc/nixos" = {
                  mountpoint = "/etc/nixos";
                  mountOptions = [
                    "subvol=nixcfg"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/swap" = {
                  mountpoint = "/.swapvol";
                  swap.swapfile.size = "64G";
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/nix/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  fileSystems."/var/lib".neededForBoot = true;
}
