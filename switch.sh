#!/usr/bin/env bash
set -e

cd ~/newnixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

export SOPS_AGE_KEY=$(sudo ssh-to-age -i ed25519_key -private-key)

nixos-rebuild build --show-trace --builders "" --flake .#$WHERE

sudo nixos-rebuild switch --show-trace --builders "" --flake .#$WHERE

export SOPS_AGE_KEY=""

nix-env --delete-generations 7d

nix-store --gc
