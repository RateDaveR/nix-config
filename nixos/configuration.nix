# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration
 # systemd.package = pkgs.systemd.override { withOomd = true; };
 # systemd.additionalUpstreamSystemUnits = [ "systemd-oomd.service" ];
 # systemd.services.systemd-oomd = {
 #   wantedBy = lib.mkIf (config.swapDevices != []) [ "multi-user.target" ];
 #   after = [ "swap.target" ];
 #   aliases = [ "dbus-org.freedesktop.oom1.service" ];
 # };
 # users.groups.systemd-oom.gid = 666;
 # users.users.systemd-oom = {
 #   uid =666;
 #   group = "systemd-oom";
 #   isSystemUser = true;
 # };
 # systemd.slices."-".sliceConfig.ManagedOOMSwap = "kill";
   services.earlyoom = {
    enable = true;
   };
 #  services.systemd-oomd.enable = false;

 # TODO: Set your hostname
  networking.hostName = "dev";

  home-manager.users.daveved = import ../home-manager/home.nix;
  programs.zsh.enable = true;
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    daveved = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["networkmanager" "wheel" "video" "audio" "docker"];
      shell = pkgs.zsh;
      initialPassword = "bingbong";
    };
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

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
  
  # GUI Options
  # Enable the X11 windowing system.
 # services.xserver = {
 #   enable = true;
 #   desktopManager = {xterm.enable=false;};
 #   displayManager = {
 #     defaultSession = "none+i3";
 #   };
 #   windowManager.i3 = {
 #     enable = true;
 #     extraPackages = with pkgs; [
 #       dmenu
 #       i3status#
#	i3lock
#	i3blocks
 #     ];
 #   };
 # };
 # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
 # programs.dconf.enable = true;

  #services.xserver.enable = true;
  #services.xserver.displayManager.defaultSession = "none+i3";
  #services.xserver.desktopManager.xterm.enable = true;
  #services.xserver.windowManager.i3 = {
  #  enable = true;
  #  desktopManager = {xterm.enable=false;};
  #  display
  #  extraPackages = with pkgs; [
  #    dmenu
  #    i3status
  #    i3lock
  #  ];
  #};
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  
  #i3 take it or leave it. 
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
	i3lock
	i3blocks
      ];
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
