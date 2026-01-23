1. Generate SSH ed25519 Keypair
```
$ ssh-keygen -t ed25519 -C "l1npengtul@hostname" -f path/to/desired/output
```

2. Convert SSH Keypair to age keys

```
# Public Key
$ ssh-to-age -i $HOME/.ssh/id_ed25519.pub -o pub-key.txt

# Private Key
$ SSH_TO_AGE_PASSPHRASE=$(systemd-ask-password) ssh-to-age -private-key -i $HOME/.ssh/id_ed25519 -o key.txt

# Run these to setup the environment!!!
$ export SSH_TO_AGE_PASSPHRASE=$(systemd-ask-password)
$ export SOPS_AGE_KEY=$(ssh-to-age -i ~/.ssh/id_ed25519 -private-key)
```

3. Write **Public** key to .sops.yaml

Add age key with hostname to `keys` with `&`
Add creation rule to `creation_rules` and `key_rules`

4. Add Secrets to new secret file

```
$ nix-shell -p sops --run "sops secrets/example.yaml"
```

Update Secret File

```
$ nix-shell -p sops --run "sops updatekeys secrets/example.yaml"
```
