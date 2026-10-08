#pund  Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nigga"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Tunis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
   };
  services.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Recommended for gaming and some applications
  };

  # Tell the X server to use the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
  	   nvidia-container-toolkit.enable = true;
  	   nvidia = {
    	   # Enable modesetting, required for most Wayland compositors
    	   modesetting.enable = true;
    	   # Enable the NVIDIA settings utility
    	   nvidiaSettings = true;
    	   # For RTX 3050 and all Turing+ GPUs, it's recommended to use the open-source kernel module
    	   open = true; 
    	   # Use the default stable driver package
    	   package = config.boot.kernelPackages.nvidiaPackages.stable;
	   
	   };
};

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
virtualisation.vmware.host.enable = true; 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."barnoun" = {
    isNormalUser = true;
    description = "barnoun";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    libGLX
    libxkbcommon
    fontconfig
    libx11
    glib
    freetype
    libxext
    libxrender
    dbus-glib
];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
     usbmon.enable = true;
     dumpcap.enable = true;
  };
  users.groups.wireshark.members = [ "barnoun" ];

  qt = {
  enable = true;
  platformTheme = "gnome";
  style = "adwaita-dark";
};

 virtualisation.docker.enable = true;
 virtualisation.docker.enableNvidia = true;


#OLLAMA
services.ollama = {
  enable = true;
  package = pkgs.ollama-cuda;
  host = "0.0.0.0";
  port = 11434;
};

hardware.alsa.enable = false;
hardware.alsa.enablePersistence = config.hardware.alsa.enable;
# to here
  programs.steam.enable=true;
  environment.systemPackages = with pkgs; [
  	librewolf
  	fastfetch
  	kitty
  	os-prober
	neovim
	fish
        (discord.override { withVencord = true; })
	httrack
	qbittorrent
	tor-browser
	jre8
	dex
	nitrogen
	easyeffects
	i3lock
	setxkbmap
	maim
	rofi
	picom
	i3lock
	gtk3
	lxappearance
	git
	kdePackages.dolphin
	vlc
	emacs	
	python3
	python313Packages.shodan
	brave
	cisco-packet-tracer_9
	unzip
	wine
	gzip
	obs-studio
	ghidra
	davinci-resolve
	gcc
	element-desktop
	element-web
	cmake
	libvterm
	heroic
	lutris
	alsa-utils
	burpsuite
	dnsutils
	docker
	docker-compose
];


services.gvfs.enable = true;
services.udisks2.enable=true;
fileSystems."/mnt/ssd" = {
  device = "/dev/disk/by-uuid/5c7d6997-8330-4d82-86a7-904643ac7ec5";
  fsType = "ext4";
  options = [
    "users"
    "nofail" 
    "exec"
    "x-gvfs-show"
  ];
};

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
   networking.firewall.allowedTCPPorts = [ 11434 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
