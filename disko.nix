# disko.nix - Dynamic disk configuration
{ pkgs, lib, disko-disk ? "/dev/nvme0n1", ... }:

{
  disko.devices = {
    disk.main = {
      device = disko-disk;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "efi";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}