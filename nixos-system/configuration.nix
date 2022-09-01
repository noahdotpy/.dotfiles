# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      # <home-manager/nixos> # Home manager
    ];
  fonts.fontDir.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 1;

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.enable = true;

  virtualisation.libvirtd.enable = true;

  programs.dconf.enable = true;

  services.flatpak.enable = true;
  programs.kdeconnect.enable = true;

  programs.fish.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
    };
  };
  programs.starship.enable = true;
  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with `passwd` post-install.
  users.users.noah = {
    isNormalUser = true;
    initialPassword = "temp";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.wget
    pkgs.htop
    pkgs.curl
    pkgs.deja-dup
    pkgs.ark
    pkgs.duplicity  
    pkgs.alacritty
    pkgs.rofi
    pkgs.polybar
    pkgs.picom
    pkgs.haskellPackages.greenclip
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.pulsemixer
    pkgs.ksnip
    # pkgs.pulseaudio
    pkgs.rofi-emoji
    pkgs.acpi
    pkgs.dunst
    pkgs.vim
    pkgs.neovim
    pkgs.nerdfonts
    pkgs.git
    pkgs.libsForQt5.kgpg
    pkgs.pinentry
    pkgs.blueman
    pkgs.feh
    pkgs.gnupg
    pkgs.nitrogen
    pkgs.pinentry
    pkgs.onlyoffice-bin
    pkgs.gnome.dconf-editor
    pkgs.gnome.nautilus
    pkgs.unzip
    pkgs.zip
    pkgs.i3lock-color
    pkgs.python311
    pkgs.glibc
    pkgs.gcc
    pkgs.notepadqq
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    # enableSSHSupport = true;
  };
  services.gnome.gnome-keyring.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
