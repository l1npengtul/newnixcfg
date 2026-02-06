#!/usr/bin/env bash

set -euo pipefail

git reset --soft HEAD

WHERE=$(cat /etc/hostname)

git add .
git commit -m "$(whoami)@${WHERE}: $(date) - $@"
git push
