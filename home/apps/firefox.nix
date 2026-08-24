{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        UrlbarInteractions = false;
        WhatsNew = false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      search = {
        force = true;
        default = "ddg";
      };

      containersForce = true;
      containers = {
        personal = {
          id = 1;
          name = "Personal";
          color = "blue";
          icon = "fingerprint";
        };
        work = {
          id = 2;
          name = "Work";
          color = "orange";
          icon = "briefcase";
        };
        google = {
          id = 3;
          name = "Google";
          color = "purple";
          icon = "fingerprint";
        };
      };

      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 0;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.tabs.inTitlebar" = 1;

        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        "security.ssl.require_safe_negotiation" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.cert_pinning.enforcement_level" = 2;
        "browser.xul.error_pages.expert_bad_cert" = true;

        "network.trr.mode" = 2;
        "network.trr.uri" = "https://dns.quad9.net/dns-query";
        "network.dns.echconfig.enabled" = true;

        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        "media.peerconnection.enabled" = false;

        "media.ffmpeg.vaapi.enabled" = true;

        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;

        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;

        "dom.push.enabled" = false;
        "dom.webnotifications.enabled" = false;

        "geo.enabled" = false;
        "geo.provider.use_geoclue" = false;

        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.letterboxing" = true;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "privacy.spoof_english" = 1;
        "browser.link.open_newwindow" = 3;
        "browser.link.open_newwindow.restriction" = 0;

        "browser.newtabpage.activity-stream.hideLogo" = true;
        "browser.newtabpage.activity-stream.logowordmark.alwaysVisible" = false;

        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.feeds.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.showSearchTerms.enabled" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.pocket.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.amp.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.yelpRealtime.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        "browser.urlbar.wikipedia.featureGate" = false;
        "browser.urlbar.market.featureGate" = false;
        "browser.urlbar.importantDates.featureGate" = false;

        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

        "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
        "browser.discovery.enabled" = false;
        "browser.uitour.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "app.shield.optoutstudies.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "captivedetect.canonicalURL" = "";

        "network.IDN_show_punycode" = true;
        "pdfjs.enableScripting" = false;
        "security.csp.reporting.enabled" = false;
        "privacy.antitracking.isolateContentScriptResources" = true;
        "browser.sessionstore.privacy_level" = 2;
        "browser.helperApps.deleteTempFileOnExit" = true;

        "browser.nova.enabled" = true;
      };
    };
  };
}
