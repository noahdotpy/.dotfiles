{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

  let
    unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master/)
    { config = config.nixpkgs.config; }; # reuse the current configuration
  in {
    home.packages = [
      pkgs.glances
      pkgs.librewolf
      pkgs.kate
      pkgs.# pulseaudio
      pkgs.vscode
      pkgs.jetbrains.pycharm-community
      pkgs.jetbrains.idea-community
      pkgs.autotiling
      pkgs.virt-manager
      pkgs.qbittorrent
      pkgs.# github-desktop
      unstable.go_1_19
      pkgs.starship
    ];
  }

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
