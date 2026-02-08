{
  username ? "l1npengtul",
  ...
}:
{
  users.users."${username}".extraGroups = [
    "libvirtd"
    "jackaudio"
    "adbusers"
    "kvm"
    "scanner"
    "lp"
    "cdrom"
  ];
}
