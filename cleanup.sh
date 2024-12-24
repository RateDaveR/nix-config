#!/bin/bash
sudo nix-collect-garbage -d
nix-env --delete-generations old
sudo nix-store --gc