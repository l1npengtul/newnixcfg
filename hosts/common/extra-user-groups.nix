{
  username ? "l1npengtul",
  ...
}:
{
  users.users."${username}".extraGroups = [
    "jackaudio"
    "adbusers"
    "kvm"
    "scanner"
    "lp"
    "cdrom"
  ];
}
