nix-config (blah)

Personal nix config for local development box. Started from [this](https://github.com/Misterio77/nix-starter-configs) tempalte project 

## Get to the point

```
# git clone https://github.com/DaveVED/nix-config.git
nix flake init -t github:DaveVED/nix-config
nix flake update
# sudo nixos-rebuild switch --flake .#dev
nix shell nixpkgs#home-manager
ome-manager switch --flake .#daveved@dev
```
