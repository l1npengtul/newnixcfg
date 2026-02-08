{username ? "l1npengtul", ...}: {
  users.users."${username}".extraGroups = [
    "wheel"
    "audio"
    "networkmanager"
    "libvirtd"
    "jackaudio"
    "adbusers"
    "kvm"
    "scanner"
    "lp"
    "cdrom"
  ];
}
