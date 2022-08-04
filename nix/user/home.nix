{ config, pkgs, nixpkgs, lib, ... }:
{
  home.packages = with pkgs; [
    tree
  ];

  programs.git = {
    enable = true;
    userName = "David Gonzalez Martin";
    userEmail = "davidgm94.work@protonmail.com";
    package = pkgs.gitAndTools.gitFull;
    extraConfig = {
      core = {
        editor = "nvim";
	lf = "open";
	eol = "lf";
	autocrlf = false;
      };
      github.user = "davidgm94";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
