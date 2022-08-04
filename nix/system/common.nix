{ lib, pkgs, config, ... }:

with lib;
let
    username = "david";
in
{
  system.stateVersion = "22.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    description = "David";
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "abcd1234";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Common packages
    zsh
    neovim
    git
    lm_sensors
    htop
    alacritty
    kitty
    wezterm
    gdb
    ripgrep
    qemu_full
    rustup
    rust-analyzer
    nodejs
    tokei
    bat
    bash-completion
    zsh-completions
    xorriso
    cmake
    fira
    fira-mono
    fira-code
    dejavu_fonts
    liberation_ttf
    noto-fonts
    man
    xclip
    pciutils
    # Desktop environment
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    # GUI programs not used for development
    firefox
    signal-desktop
    tdesktop
    discord
    mpv
    vlc
    smplayer
    libreoffice
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
