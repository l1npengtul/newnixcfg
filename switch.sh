#!/usr/bin/env bash
set -e

cd ~/newnixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

PK=$(sudo cat /etc/ssh/ssh_host_ed25519_key)
echo ${PK} >> tmp.txt
chmod 600 tmp.txt
export SOPS_AGE_KEY=$(ssh-to-age -i tmp.txt -private-key)
rm tmp.txt
SSH_TO_AGE_PASSPHRASE=""
PK=""

nixos-rebuild build --show-trace --builders "" --flake .#$WHERE

sudo nixos-rebuild switch --show-trace --builders "" --flake .#$WHERE

nix-env --delete-generations 7d

nix-store --gc
