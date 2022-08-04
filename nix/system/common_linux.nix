{ lib, pkgs, config, ... }:

with lib;
let
    username = "david";
in
{
    users.users.${username}.extraGroups = [ "networkmanager" "wheel" ];
}
