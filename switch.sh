#!/usr/bin/env bash
set -e

cd ~/newnixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

#export SSH_TO_AGE_PASSPHRASE=$(systemd-ask-password)
#export SOPS_AGE_KEY=$(ssh-to-age -i ~/.ssh/id_ed25519 -private-key)
#echo "Age Key: $(echo $SOPS_AGE_KEY)"

sudo nixos-rebuild switch --show-trace --builders "" --flake .#$WHERE

nix-env --delete-generations 7d

nix-store --gc
