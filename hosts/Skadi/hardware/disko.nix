{ inputs, inputs', ... }:

{
  imports = [ inputs.disko.nixosModules.disko ];

  environment.systemPackages = [ inputs'.disko.packages.disko ];

  disko.devices.disk = {
    main = {
      type = "disk";
      device =
        "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX1W519812T";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            label = "Boot";
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" "umask=0077" ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypt";
              settings.allowDiscards = true;
              extraOpenArgs = [
                "--perf-no_read_workqueue"
                "--perf-no_write_workqueue"
                "--persistent"
              ];

              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L" "NixOS" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "subvol=root" "compress=zstd" "noatime" ];
                  };

                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "subvol=root" "compress=zstd" "noatime" ];
                  };

                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "subvol=root" "compress=zstd" "noatime" ];
                  };

                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size =
                      "32G"; # BIG boy, for hibernation mostly
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
