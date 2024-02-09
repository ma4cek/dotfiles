# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
  };

  networking.hostName = "mini"; # Define your hostname.
  networking.wireless.enable = false;  # Wireless is not in use
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # automatically optimise store
  nix.optimise.automatic = true;

  # automated garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };



  # display manager is SDDM (non-wayland)
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  # enable gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # enable Docker
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
    storageDriver = "btrfs";
  };

  # Fonts
  fonts.packages = with pkgs; [
    fantasque-sans-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    roboto
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ma4cek = {
   isNormalUser = true;
   extraGroups = [ "wheel" "docker" ];
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # waybar overlay
  # nixpkgs.overlays = [
  #  (self: super: {
  #     waybar = super.waybar.overrideAttrs (oldAttrs: {
  #       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #     });
  #  })
  # ];

  # Steam
  programs.steam.enable = true;

  # Thunar File Manager
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # OpenGL support
  hardware.opengl.enable = true;
  
  # XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  # polkit
  security.polkit.enable = true;

  # pam modules for swaylock
  security.pam.services.swaylock = { };
 
  # 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "ma4cek" ];
  };

  # allow packages without a free license
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Wayland, Hyprland
    dunst # notification daemon
    grim # screenshots
    libnotify
    polkit_gnome # gnome polkit handler
    swayidle
    swaylock
    swww # wallpaper daemon
    waybar
    wofi # applauncher
    
    # Internet Stuff
    firefox
    thunderbird
    google-chrome
    qutebrowser

    # Multimedia
    mpv
    yt-dlp

    # Development
    git
    vscode

    # Utilities
    imv # picture viewer
    kitty
    mc
    neofetch
    networkmanagerapplet
    pavucontrol
    ranger # file manager
    signal-desktop
    unzip
    xfce.mousepad # editor
    zathura # document viewer
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
