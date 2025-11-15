{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "zh-TW"
      "en-US"
    ];
    preferences = {
      # language
      "intl.locale.requested" = "zh-TW,en-US";
      "font.language.group" = "zh-TW";
      "intl.accept_languages" = "zh-tw,zh,en-us,en";

      # security & privacy
      "areporting.usage.uploadEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "dom.security.https_only_mode" = true;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "permissions.manager.defaultsUrl" = "";
      "privacy.clearOnShutdown.offlineApps" = true;
      "privacy.clearOnShutdown_v2.formdata" = true;
      "privacy.donottrackheader.enabled" = false;
      "privacy.globalprivacycontrol.enabled" = true;
      "services.sync.engine.forms" = false;
      "services.sync.engine.history" = false;
      "services.sync.engine.passwords" = false;
      "services.sync.engine.prefs.modified" = false;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown.cookies" = true;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown.downloads" = true;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown.history" = true;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown.offlineApps" = true;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown.sessions" = true;
      "services.sync.prefs.sync-seen.privacy.clearOnShutdown_v2.formdata" = true;
      "signon.autofillForms" = false;

      # display
      "browser.download.autohideButton" = false;
      "browser.ml.chat.page" = false;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.main.tools" = "aichat,syncedtabs,history,bookmarks";
    };
  };
}
