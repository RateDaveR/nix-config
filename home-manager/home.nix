# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  
  home.packages = with pkgs; [
    gcc
    ripgrep
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };
  };

  # TODO: Set your username
  home = {
    username = "daveved";
    homeDirectory = "/home/daveved";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "DaveVED";
    userEmail = "dave.dennis@gs.com";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  programs.kitty = {
    enable = true;
  };
  
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
    {
        plugin = rose-pine;
        config = "colorscheme rose-pine";
    }
    {
        plugin = nvim-treesitter.withPlugins (treesitter-plugins: 
            with treesitter-plugins; [
                bash
                lua
                nix
                python
                go
                typescript
            ]
        );
        config = toLuaFile ./nvim/config/plugins/treesitter.lua;
    }
    {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/config/plugins/lsp.lua;
    }
    telescope-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/config/options.lua}
    '';
  };       
  programs.firefox.enable = true;
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.dracula
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse on
    '';
 };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
