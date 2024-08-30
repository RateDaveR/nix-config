nix-config (blah)

Personal nix config for local development box. Started from [this](https://github.com/Misterio77/nix-starter-configs) tempalte project 

## Get to the point

```
# git clone https://github.com/DaveVED/nix-config.git
export NIX_CONFIG="experimental-features = nix-command flakes"
nix flake update
sudo nixos-rebuild switch --flake .#dev
```
