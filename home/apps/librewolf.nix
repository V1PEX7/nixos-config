{ ... }:
{
  programs.librewolf = {
    enable = true;

    settings = {
      "browser.startup.homepage" = "about:blank";
      "browser.newtabpage.enabled" = false;

      "network.trr.mode" = 3;
      "network.trr.uri" = "https://dns.quad9.net/dns-query";

      "media.peerconnection.ice.no_host" = true;

      "browser.contentblocking.category" = "strict";

      "network.dns.disablePrefetch" = true;
      "network.prefetch-next" = false;
      "network.predictor.enabled" = false;
    };
  };
}
