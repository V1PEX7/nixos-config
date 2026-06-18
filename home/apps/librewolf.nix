{ ... }:
{
  programs.librewolf = {
    enable = false;

    settings = {
      "browser.startup.homepage" = "about:blank";
      "browser.newtabpage.enabled" = false;
      "browser.tabs.inTitlebar" = 1;

      "browser.privatebrowsing.autostart" = true;

      "media.ffmpeg.vaapi.enabled" = true;

      "network.trr.mode" = 2;
      "network.trr.uri" = "https://dns.quad9.net/dns-query";
      "network.dns.echconfig.enabled" = true;
      "network.http.speculative-parallel-limit" = 0;
      "network.http.referer.XOriginPolicy" = 2;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      "network.prefetch-next" = false;
      "network.dns.disablePrefetch" = true;
      "network.predictor.enabled" = false;
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;

      "media.peerconnection.enabled" = false;

      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.letterboxing" = false;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.clearOnShutdown.cache" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.formdata" = true;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.offlineApps" = true;
      "privacy.clearOnShutdown.sessions" = true;
      "privacy.sanitize.sanitizeOnShutdown" = true;

      "browser.cache.disk.enable" = false;
      "browser.cache.offline.enable" = false;
      "browser.formfill.enable" = false;
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;

      "signon.rememberSignons" = false;
      "signon.autofillForms" = false;

      "places.history.enabled" = false;

      "dom.security.https_only_mode" = true;
      "dom.event.clipboardevents.enabled" = false;
      "dom.push.enabled" = false;
      "dom.webnotifications.enabled" = false;

      "geo.enabled" = false;
      "geo.provider.network.url" = "";
    };
  };
}
