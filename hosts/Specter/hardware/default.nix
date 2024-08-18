{ config, ... }:

{
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
