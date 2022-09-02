{ config, pkgs, ... }:

let
  nixpkgsConfig = if config.nixpkgs.config == null then {} else config.nixpkgs.config;
in
{

  imports =
  [
      ./associations.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

  home.packages = let unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/master") { config = nixpkgsConfig; }; in [
      pkgs.librewolf
      pkgs.kate
      pkgs.vscode
      pkgs.jetbrains.pycharm-community
      pkgs.jetbrains.idea-community
      pkgs.autotiling
      pkgs.virt-manager
      pkgs.qbittorrent
      pkgs.starship
      pkgs.libsForQt5.okular
      pkgs.libnotify
      pkgs.gh
      pkgs.spacevim
      pkgs.papirus-icon-theme
      pkgs.gimp
      pkgs.minecraft
      pkgs.mailspring
      unstable.go_1_19
      unstable.glances
  ];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}