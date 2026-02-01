#!/usr/bin/env bash
set -e

cd ~/newnixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

PK=$(sudo cat /etc/ssh/ssh_host_ed25519_key)
export SOPS_AGE_KEY=$(echo ${PK} | ssh-to-age -private-key)
SSH_TO_AGE_PASSPHRASE=""
PK=""

nixos-rebuild build --show-trace --builders "" --flake .#$WHERE

sudo nixos-rebuild switch --show-trace --builders "" --flake .#$WHERE

nix-env --delete-generations 7d

nix-store --gc
