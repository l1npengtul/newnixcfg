{ pkgs, config, ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      EnableInsightsCollector = false;

    };
  };
}
