{ config, pkgs, nixpkgs, lib, ... }:
{
  home.packages = with pkgs; [
    tree
  ];

  programs.git = {
    enable = true;
    userName = "David Gonzalez Martin";
    userEmail = "davidgm94.work@protonmail.com";
  };
}
