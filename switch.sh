#!/usr/bin/env bash
set -e

cd ~/newnixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

sudo nixos-rebuild switch --show-trace --builders "" --flake .#$WHERE

nix-env --delete-generations 7d

nix-store --gc
