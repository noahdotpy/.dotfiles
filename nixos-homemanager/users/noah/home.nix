{ config, pkgs, ... }:

let
  nixpkgsConfig = if config.nixpkgs.config == null then {} else config.nixpkgs.config;

  browser = ["librewolf.desktop"];

  xdgAssociations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = ["com.github.Eloston.UngoogledChromium.desktop"];
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    # "text/*" = [ "emacs.desktop" ];
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    #"text/calendar" = [ "thunderbird.desktop" ];
    "application/json" = browser;
    "application/pdf" = ["okularApplication_pdf.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    "x-scheme-handler/spotify" = ["com.spotify.Client.desktop"];
    "x-scheme-handler/discord" = ["com.discordapp.Discord.desktop"];
  };
in
{

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

  home.sessionVariables = {
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = xdgAssociations;
  xdg.mimeApps.defaultApplications = xdgAssociations;

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
