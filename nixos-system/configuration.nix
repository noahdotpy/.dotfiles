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

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fonts = [
      pkgs.nerdfonts
    ];
  };

  # Enable Grub2 bootloader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      efiInstallAsRemovable = true;
    };
    efi.efiSysMountPoint = "/boot/efi";
    timeout = 1;
  };

  networking = {

    hostName = "nix";

    # Enable networking
    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;

  };
  

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Custom nix options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable the X11 windowing system.
  services = {
    
    # Enable gnome keyring.
    gnome.gnome-keyring.enable = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable flatpak.
    flatpak.enable = true;

    xserver = {
      
      enable = true;

      # Configure keymap in X11
      layout = "au";
      xkbVariant = "";
      
      # Enable the KDE Plasma Desktop Environment.
      displayManager = {
        sddm.enable = true;
      };
      desktopManager = {
        plasma5.enable = true;
      };

      # Enable the i3-gaps window manager.
      windowManager = {
        i3 = {
          package = pkgs.i3-gaps;
          enable = true;
        };
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

  };


  programs = {

    nm-applet.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "qt";
      # enableSSHSupport = true;
    };

    dconf.enable = true;

    kdeconnect.enable = true;

    fish.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
      };
    };
    starship.enable = true;

  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable virtualisation.
  virtualisation.libvirtd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with `passwd` post-install.
  users.users.noah = {
    isNormalUser = true;
    initialPassword = "temp";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    # Internet
    pkgs.librewolf
    pkgs.wget
    pkgs.curl

    # Multi-media
    pkgs.vlc
    
    # Text Editors
    pkgs.micro
    pkgs.vim
    pkgs.neovim
    pkgs.notepadqq
    
    # CLI/TUI
    pkgs.htop
    pkgs.duplicity  
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.pulsemixer
    pkgs.acpi
    pkgs.git
    pkgs.feh
    pkgs.gnupg
    pkgs.gdu

    # Tools
    pkgs.deja-dup
    pkgs.ark
    pkgs.ksnip
    pkgs.unzip
    pkgs.zip
    pkgs.pinentry
    pkgs.gnome.dconf-editor

    # i3 related
    pkgs.rofi
    pkgs.rofi-emoji
    pkgs.polybar
    pkgs.picom
    pkgs.haskellPackages.greenclip
    pkgs.nitrogen
    pkgs.i3lock-color
    pkgs.dunst
    pkgs.blueman
    
    
    # Libraries/Programming Languages
    pkgs.libsForQt5.kdialog
    pkgs.libsForQt5.kgpg
    pkgs.libnotify
    pkgs.gcc
    pkgs.glibc
    pkgs.python311

    # Miscellaneous
    pkgs.onlyoffice-bin
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
