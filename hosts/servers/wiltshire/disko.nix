{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
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
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "95%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  keyFile = "/tmp/secret.key";
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "charlotte"
                    "-f"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
      hdd1 = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted2";
                settings = {
                  keyFile = "/tmp/secret.key";
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "scarlotte"
                    "-f"
                  ];
                  subvolumes = {
                    "/nix/persist" = {
                      mountpoint = "/nix/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "64G";
                    };
                  };
                };
              };
            };
          };
        };
      };
      hdd2 = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted2";
                settings = {
                  keyFile = "/tmp/secret.key";
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "tvworld"
                    "-f"
                  ];
                  subvolumes = {
                    "/nix/persist2" = {
                      mountpoint = "/nix/persist2";
                      mountOptions = [
                        "compress=lz4"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
