{
    inputs,
        lib,
        config,
        pkgs,
        ...
}: {
    imports = [
        ./hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs = {
        overlays = [];
        config = {
            allowUnfree = true;
        };
    };

    nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
        settings = {
            experimental-features = "nix-command flakes";
            flake-registry = "";
            nix-path = config.nix.nixPath;
        };
        channel.enable = false;

        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    services.earlyoom = {
        enable = true;
    };
    
    services.gnome.gnome-keyring.enable = true;


    networking.hostName = "dev";
    
    programs.nix-ld.enable = true;
    
    home-manager.users.daveved = import ../home-manager/home.nix;
    programs.zsh.enable = true;

    users.users = {
        daveved = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "video" "audio" "docker"];
            shell = pkgs.zsh;
            initialPassword = "bingbong";
        };
    };

  hardware.pulseaudio.enable = true;
nixpkgs.config.pulseaudio = true;
services.pipewire.enable = false;
services.pipewire.pulse.enable = false;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

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

environment.systemPackages = with pkgs; [
  picom
];

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

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };
    
    system.stateVersion = "25.05";
}
