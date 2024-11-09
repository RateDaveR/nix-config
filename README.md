# nix-config (blah)

These are my personal [nixos](https://nixos.org) configuration files. A good 
starter for your own nixos configs can be found 
[here](https://github.com/Misterio77/nix-starter-configs).

These are custom to me.

## Get rocking and rolling

On a new box the following gets me going. 

```bash
git clone https://github.com/DaveVED/nix-config.git
export NIX_CONFIG="experimental-features = nix-command flakes"
nix flake update
sudo nixos-rebuild switch --flake .#dev
```

code --password-store="gnome-libsecret"
