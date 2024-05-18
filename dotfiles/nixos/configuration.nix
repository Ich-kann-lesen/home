
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, pkgs-stable, ... }:

{
  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];

  };
  # Keep System up-to-date
  system.autoUpgrade.enable = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Add 16 GB Swap file
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];


# ____  _____ ______     _____ ____ _____ ____  
#/ ___|| ____|  _ \ \   / /_ _/ ___| ____/ ___| 
#\___ \|  _| | |_) \ \ / / | | |   |  _| \___ \ 
# ___) | |___|  _ < \ V /  | | |___| |___ ___) |
#|____/|_____|_| \_\ \_/  |___\____|_____|____/ 



services = {


  xserver = {
    enable = true;
    windowManager = {
      #herbstluftwm.enable = true;
      #qtile.enable = true;
      #awesome.enable = true;
    };
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;


  # Configure keymap in X11
    xkb = {
      layout = "de";
      variant = "";
      options = "";
    };
  };

  printing.enable = true;

  pipewire = {
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

  # Install Flatpak
  flatpak.enable = true;

  # upower to get battery percentage
  upower.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
};




programs = {
  # Wayland WMs
  hyprland.enable = true;
  sway.enable = true;

  zsh.enable = true;
  zsh.ohMyZsh.enable = true;
  starship.enable = true;
  
  nix-ld.enable = true;
  nix-ld.libraries = with pkgs; [
    python311Packages.pygame
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # mtr.enable = true;
  # gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

};


  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true;

  #virtualisation.virtualbox.host.enable = true;
  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.god = {
      isNormalUser = true;
      description = "Louis";
      extraGroups = [ "networkmanager" "wheel" "dialout" "uinput" "input"];
      packages = with pkgs; [
       # thunderbird
        ];
  };

  extraGroups.vboxusers.members = [ "god" ];

  defaultUserShell = pkgs.zsh;
};

  
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = 
    (with pkgs; [
# ____   _    ____ _  __    _    ____ _____ ____  
#|  _ \ / \  / ___| |/ /   / \  / ___| ____/ ___| 
#| |_) / _ \| |   | ' /   / _ \| |  _|  _| \___ \ 
#|  __/ ___ \ |___| . \  / ___ \ |_| | |___ ___) |
#|_| /_/   \_\____|_|\_\/_/   \_\____|_____|____/ 

      alacritty
      apple-cursor
      arandr
      arduino-ide
      autotiling
      bluetuith
      btop
      cargo
      cava
      cmake
      cmatrix
      conky
      cowsay
      discord
      figlet
      firefox
      floorp
      ghostscript
      git
      glibc
      gnumake
      gparted
      gtk4
      htop
      hyprpaper
      jq
      kate
      kitty
      krabby
      krita
      libreoffice
      librewolf
      mpv
      mumble
      murmur
      neofetch
      neovim
      ntfs3g
      obs-studio
      obsidian
      pdftk
      plasma-browser-integration
      proxychains
      ranger
      ripgrep
      rustc
      signal-desktop
      spotify
      starship
      tree
      typioca
      unzip
      upower
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      webcord
      #virtualbox
      #vscodium
      weylus
      wget
      whatsapp-for-linux
      wine
      wlr-randr
      wofi
      xcape
      xdotool
      ydotool
      zip
  #    gImagereader
  #    kdeconnect-kde
  #    xdg-utils-unstable
  ])

  ++

  (with pkgs-stable; [
    python3
    python311Packages.pygame
  ]);


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1701 9001 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
