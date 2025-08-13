{ config, pkgs, ... }:

{
  users.users.ebn = {
    isNormalUser = true;
    description = "E Brent Nelson";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "adbusers"];
    shell = pkgs.zsh;
  };
}
