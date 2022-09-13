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
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

  programs = {
    kitty = {
      enable = true;
      theme = "Tokyo Night";
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };

  home.packages = [
      # Programming languages
      pkgs.unstable.go_1_19

      # Programming/Text Editors
      pkgs.spacevim
      pkgs.neovide # graphical client for neovim
      pkgs.vscode
      pkgs.jetbrains.pycharm-community
      pkgs.jetbrains.idea-community
      pkgs.kate
      pkgs.helix

      # Theming
      pkgs.papirus-icon-theme
      pkgs.tela-circle-icon-theme

      # Graphics
      pkgs.gimp

      # TUI/CLI
      pkgs.unstable.glances
      pkgs.gh

      # Terminal Emulators
      pkgs.alacritty

      # Libraries
      pkgs.libnotify
      pkgs.libsForQt5.okular

      # Miscellaneous
      pkgs.autotiling
      pkgs.virt-manager
      pkgs.qbittorrent
      pkgs.mailspring
  ];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
