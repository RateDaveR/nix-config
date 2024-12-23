{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nvim/default.nix
    ./tmux/default.nix
    ./zsh/default.nix
    ./git/default.nix
    ./vscode/default.nix
 ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  
  home.packages = with pkgs; [
    gcc
    ripgrep
    libsecret
    tree
    nodePackages.typescript
    nodePackages.typescript-language-server
    bun
    flameshot
  ];

  home = {
    username = "daveved";
    homeDirectory = "/home/daveved";
  };
  # Programs that are not imported. These are simple ones with minimal configs.
  programs.home-manager.enable = true;
  programs.kitty.enable = true;
  programs.firefox.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
