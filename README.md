# nix-config (blah)

These are my personal [nixos](https://nixos.org) configuration files.

## Get to the point

```
# git clone https://github.com/DaveVED/nix-config.git
export NIX_CONFIG="experimental-features = nix-command flakes"
nix flake update
sudo nixos-rebuild switch --flake .#dev
```
