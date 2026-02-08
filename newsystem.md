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

# new system

```
 echo "mypassword" | mkpasswd -m sha-512 --stdin
```
use space in front to not have it in history
```
export installhost=<hostname>

install -d -m755 "/tmp/$installhost/nix/persist/etc/ssh"
ssh-keygen -t ed25519 -N "" -C "root@$hostname" -f /tmp/$installhost/nix/persist/etc/ssh/ssh_host_ed25519_key
cat /tmp/$installhost/nix/persist/etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
chmod 600 "/tmp/$installhost/nix/persist/etc/ssh/ssh_host_ed25519_key"

install -d -m755 "/tmp/$installhost/nix/persist/etc/secrets/initrd/"
ssh-keygen -t ed25519 -N "" -f /tmp/$installhost/nix/persist/etc/secrets/initrd/ssh_host_ed25519_key
chmod 600 "/tmp/$installhost/nix/persist/etc/secrets/initrd/ssh_host_ed25519_key"
```

write secret key to `"/tmp/secret.key"`
```
 echo -n "mypassword" >> /tmp/secret.key
```


```
nixos-anywhere --generate-hardware-config nixos-generate-config ./hosts/servers/$installhost/hardware-configuration.nix \
 --flake .#$hostname \
 --target-host root@<ip address> \
 --disk-encryption-keys "/tmp/secret.key" "/tmp/secret.key" \
 --extra-files "/tmp/$installhost"
```

post install

use `lspci -v` and add the ethernet driver to `boot.initrd.availibleKernelModules`
if using btrfs, use `findmnt /`, find root subvolume and write this script to `boot.initrd.postResumeCommands`

```
  # Reset root subvolume on boot
  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-partlabel/disk-main-root /btrfs_tmp # CONFIRM THIS IS CORRECT FROM findmnt
    if [[ -e /btrfs_tmp/root ]]; then
      mkdir -p /btrfs_tmp/old_roots
      timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume_recursively "/btrfs_tmp/$i"
      done
      btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
      delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
```
