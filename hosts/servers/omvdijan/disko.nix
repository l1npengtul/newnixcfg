{
  disko.devices = {
    disk = {
      disk1 = {
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
                mountOptions = [ "umask=0077" ];
              };
            };
            crypt_p1 = {
              size = "950G";
              content = {
                type = "luks";
                name = "perlica"; # device-mapper name when decrypted
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                };
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            crypt_p2 = {
              size = "950G";
              content = {
                type = "luks";
                name = "xaihi";
                # Remove settings.keyFile if you want to use interactive password entry
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-d raid1"
                    "/dev/mapper/perlica" # Use decrypted mapped device, same name as defined in disk1
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                      ];
                    };
                    "/etc/nixos" = {
                      mountpoint = "/etc/nixos";
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
                    "/nix/persist" = {
                      mountpoint = "/nix/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "/var/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "ssd"
                        "noexec"
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
